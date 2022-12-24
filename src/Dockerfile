# syntax=docker/dockerfile:1

ARG ubuntuVersion=22.04

FROM ubuntu:22.04

WORKDIR /root
ADD build.bash /bin
RUN ["/usr/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/build.bash"]

# FROM jaidchen/ubuntu:main:2.2.0

# ENV qbittorrentFolder=$userHome/qBittorrent
# ENV qbittorrentUser=$userName
# ENV webUser=admin
# ENV webPort=3649
# ENV directPort=33333
# ENV webPasswordPbkdf2="KOhefdma+6Y9jh0NRrvmDA==:D9Qi3a/yoqFrpUCpd00ufqLbzVRRmFTTuuKx6HYY0NiRVVcw1lphedyjkzGsMwvlAgayHMqqXW3gl64hec1OXg=="
# ENV startSlow=true
# ENV finishedPath=$userHome/content/finished
# ENV downloadingPath=$userHome/content/downloading
# ENV inboxPath=$userHome/content/inbox
# ENV torrentBackupPath=$userHome/content/torrentBackup
# ENV gluetunApiHost=localhost
# ENV gluetunApiPort=8000

# EXPOSE $webPort
# EXPOSE $directPort

# VOLUME $userHome/qBittorrent
# VOLUME $userHome/content
# VOLUME $userHome/media
