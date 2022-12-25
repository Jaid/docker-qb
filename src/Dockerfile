# syntax=docker/dockerfile:1

ARG ubuntuVersion=22.04

FROM ubuntu:$ubuntuVersion AS build

ADD build*.bash /bin
WORKDIR /root
RUN ["/usr/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/build.bash"]
RUN ["/usr/bin/bash", "-o", "errexit", "-o", "pipefail", "-o", "xtrace", "/bin/build2.bash"]

FROM jaidchen/ubuntu:2.2.0

ENV qbittorrentFolder=$userHome/qBittorrent
ENV qbittorrentUser=$userName
ENV webUser=admin
ENV webPort=3649
ENV directPort=33333
ENV webPasswordPbkdf2="KOhefdma+6Y9jh0NRrvmDA==:D9Qi3a/yoqFrpUCpd00ufqLbzVRRmFTTuuKx6HYY0NiRVVcw1lphedyjkzGsMwvlAgayHMqqXW3gl64hec1OXg=="
ENV startSlow=true
ENV finishedPath=$userHome/content/finished
ENV downloadingPath=$userHome/content/downloading
ENV inboxPath=$userHome/content/inbox
ENV torrentBackupPath=$userHome/content/torrentBackup
ENV gluetunApiHost=localhost
ENV gluetunApiPort=8000

COPY --from=build --chown=$userId:$groupId /root/qbStatic/qbt-build/bin/qbittorrent-nox /bin

EXPOSE $webPort
EXPOSE $directPort

VOLUME $userHome/qBittorrent
VOLUME $userHome/content
VOLUME $userHome/media
