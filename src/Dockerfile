# syntax=docker/dockerfile:1

FROM jaidchen/ubuntu:main

RUN mkdir $userHome/{bin,qBittorrent,content,media}
COPY ./bin $userHome/bin
RUN chown --recursive $userId:$groupId $userHome

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

EXPOSE $webPort
EXPOSE $directPort

RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet install curl jq qbittorrent-nox

CMD bash $userHome/bin/run.bash

VOLUME $userHome/qBittorrent
VOLUME $userHome/content
VOLUME $userHome/media

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD wget -q --spider "localhost:$webPort" || exit 1