#!/usr/bin/env ash
set -e
set -o errexit

echo "Running run.ash"

qbittorrentConf="$qbittorrentFolder/config/qBittorrent.conf"

if nc -z localhost 8000; then
  echo 'Found gluetun instance'
  if ! command -v curl >/dev/null 2>&1; then
    echo "jq not installed, running: apk add curl"
    apk add --no-cache curl
  fi
  if ! command -v jq >/dev/null 2>&1; then
    echo "jq not installed, running: apk add jq"
    apk add --no-cache jq
  fi
  gluetunIp=$(curl --retry 20 localhost:8000/v1/publicip/ip | jq --raw-output .ip)
  echo "Using VPN ip $gluetunIp"
  gluetunForwardedPort=$(curl --retry 20 localhost:8000/v1/openvpn/portforwarded | jq --raw-output .port)
  echo "Dynamically setting port to $gluetunForwardedPort"
  if [ -f "$qbittorrentConf" ]; then
    echo "$qbittorrentConf already exists, patching file"
    md5Before=$(md5sum "$qbittorrentConf")
    echo "MD5 before: $md5Before"
    sed -i "s|^Session\\\\Port=.*$|Session\\\\Port=$directPort|g" "$qbittorrentConf"
    sed -i "s|^Session\\\\Interface=.*$|Session\\\\Interface=tunVpn|g" "$qbittorrentConf"
    sed -i "s|^Session\\\\InterfaceName=.*$|Session\\\\InterfaceName=tunVpn|g" "$qbittorrentConf"
    md5After=$(md5sum "$qbittorrentConf")
    echo "MD5 after:  $md5After"
  else
    # Just overwrite the env vars
    export directPort="$gluetunForwardedPort"
    export limitToInterface=tunVpn
  fi
fi

if [ ! -f "$qbittorrentConf" ]; then
  echo "Config file $qbittorrentConf does not exist yet, will be dynamically created"
  mkdir --parents "$qbittorrentFolder/config"
  echo "[Application]
FileLogger\Age=1
FileLogger\AgeType=1
FileLogger\Backup=true
FileLogger\DeleteOld=true
FileLogger\Enabled=true
FileLogger\MaxSizeBytes=66560
FileLogger\Path=$qbittorrentFolder/logs

[AutoRun]
enabled=false

[BitTorrent]
Session\AddTorrentPaused=false
Session\AddTrackersEnabled=false
Session\AlternativeGlobalDLSpeedLimit=10
Session\AlternativeGlobalUPSpeedLimit=10
Session\DefaultSavePath=$finishedPath
Session\DisableAutoTMMByDefault=false
Session\DisableAutoTMMTriggers\CategoryChanged=false
Session\DisableAutoTMMTriggers\CategorySavePathChanged=false
Session\DisableAutoTMMTriggers\DefaultSavePathChanged=false
Session\Interface=$limitToInterface
Session\InterfaceName=$limitToInterface
Session\LSDEnabled=false
Session\MaxConnections=50
Session\MaxConnectionsPerTorrent=-1
Session\MaxRatioAction=0
Session\MaxUploads=-1
Session\MaxUploadsPerTorrent=-1
Session\PeXEnabled=false
Session\Port=$directPort
Session\Preallocation=false
Session\QueueingSystemEnabled=false
Session\SubcategoriesEnabled=true
Session\TempPath=$downloadingPath
Session\TempPathEnabled=true
Session\TorrentContentLayout=Subfolder
Session\TorrentExportDirectory=$torrentBackupPath
Session\UseAlternativeGlobalSpeedLimit=$startSlow
Session\UseRandomPort=false

[Core]
AutoDeleteAddedTorrentFile=Never

[LegalNotice]
Accepted=true

[Meta]
MigrationVersion=2

[Preferences]
Advanced\DisableRecursiveDownload=false
Advanced\EnableIconsInMenus=true
Advanced\RecheckOnCompletion=false
Advanced\TrayIconStyle=MonoLight
Advanced\confirmRemoveAllTags=true
Advanced\confirmTorrentDeletion=true
Advanced\trackerPort=9000
Advanced\useSystemIconTheme=true
Bittorrent\AddTrackers=false
Bittorrent\LSD=false
Bittorrent\MaxConnecs=-1
Bittorrent\MaxConnecsPerTorrent=-1
Bittorrent\MaxRatioAction=0
Bittorrent\MaxUploads=-1
Bittorrent\MaxUploadsPerTorrent=-1
Bittorrent\PeX=false
Connection\GlobalDLLimitAlt=10
Connection\GlobalUPLimitAlt=10
Connection\InterfaceName=
Connection\ResolvePeerCountries=true
Connection\ResolvePeerHostNames=false
Connection\alt_speeds_on=$startSlow
Downloads\DblClOnTorDl=1
Downloads\DblClOnTorFn=1
Downloads\NewAdditionDialog=false
Downloads\NewAdditionDialogFront=true
Downloads\PreAllocation=false
Downloads\SavePath=$finishedPath
Downloads\ScanDirsLastPath=$inboxPath
Downloads\StartInPause=false
Downloads\TempPath=$downloadingPath
Downloads\TempPathEnabled=true
Downloads\TorrentExportDir=$torrentBackupPath
DynDNS\Enabled=false
General\AlternatingRowColors=true
General\CloseToTray=true
General\CloseToTrayNotified=true
General\CustomUIThemePath=
General\ExitConfirm=false
General\HideZeroComboValues=0
General\HideZeroValues=true
General\Locale=en
General\MinimizeToTray=false
General\NoSplashScreen=true
General\PreventFromSuspendWhenDownloading=false
General\PreventFromSuspendWhenSeeding=false
General\StartMinimized=true
General\SystrayEnabled=true
General\UseCustomUITheme=false
General\UseRandomPort=false
Queueing\QueueingEnabled=false
WebUI\Address=*
WebUI\Port=$webPort
WebUI\AlternativeUIEnabled=false
WebUI\AuthSubnetWhitelist=@Invalid()
WebUI\AuthSubnetWhitelistEnabled=false
WebUI\BanDuration=3600
WebUI\CSRFProtection=true
WebUI\ClickjackingProtection=true
WebUI\CustomHTTPHeadersEnabled=false
WebUI\Enabled=true
WebUI\HTTPS\Enabled=false
WebUI\HostHeaderValidation=true
WebUI\LocalHostAuth=true
WebUI\MaxAuthenticationFailCount=3
WebUI\Username=$webUser
WebUI\Password_PBKDF2=\"@ByteArray($webPasswordPbkdf2)\"
WebUI\ReverseProxySupportEnabled=false
WebUI\SecureCookie=true
WebUI\ServerDomains=*
WebUI\SessionTimeout=3600
WebUI\UseUPnP=false

[ShutdownConfirmDlg]
DontConfirmAutoExit=false
" >"$qbittorrentConf"

  md5Sum=$(md5sum "$qbittorrentConf")
  echo "MD5: $md5Sum"

  chown --recursive "$qbittorrentUser:$qbittorrentUser" "/home/$qbittorrentUser"
fi

su -c "qbittorrent-nox --profile=\"\$HOME\"" app
