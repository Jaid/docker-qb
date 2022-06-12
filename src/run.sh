#!/usr/bin/env sh
set -e
set -o errexit

if [ ! -f "$qbittorrentFolder/config/qBittorrent.conf" ]; then
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
Session\InterfaceName=
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
# Connection\alt_speeds_on=false
Downloads\DblClOnTorDl=1
Downloads\DblClOnTorFn=1
Downloads\NewAdditionDialog=false
Downloads\NewAdditionDialogFront=true
Downloads\PreAllocation=false
# Downloads\SavePath=/mnt/finished/
Downloads\SavePath=$finishedPath
# Downloads\ScanDirsLastPath=/mnt/space/Inbox
Downloads\ScanDirsLastPath=$inboxPath
Downloads\StartInPause=false
Downloads\TempPath=$downloadingPath
# Downloads\TempPath=/mnt/space/Downloading/
Downloads\TempPathEnabled=true
Downloads\TorrentExportDir=$torrentBackupPath
# Downloads\TorrentExportDir=/mnt/space/Meta
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
" >"$qbittorrentFolder/config/qBittorrent.conf"

  chown --recursive app:app /home/app
fi

su -c "qbittorrent-nox --profile=\"\$HOME\"" app
