# syntax=docker/dockerfile:1

FROM jaidchen/ubuntu:latest

COPY --chown=$userId:$groupId ./bin /home/$userName/bin

ENV qbittorrentFolder=/home/$userName/qBittorrent
ENV qbittorrentUser=$userName
ENV webUser=admin
ENV webPort=3649
ENV directPort=33333
ENV webPasswordPbkdf2="KOhefdma+6Y9jh0NRrvmDA==:D9Qi3a/yoqFrpUCpd00ufqLbzVRRmFTTuuKx6HYY0NiRVVcw1lphedyjkzGsMwvlAgayHMqqXW3gl64hec1OXg=="
ENV startSlow=true
ENV finishedPath=/home/$userName/content/finished
ENV downloadingPath=/home/$userName/content/downloading
ENV inboxPath=/home/$userName/content/inbox
ENV torrentBackupPath=/home/$userName/content/torrentBackup

EXPOSE $webPort
EXPOSE $directPort

RUN apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet install curl jq qbittorrent-nox

CMD bash /home/$qbittorrentUser/bin/run.bash

VOLUME /home/$userName/qBittorrent
VOLUME /home/$userName/content/finished
VOLUME /home/$userName/content/downloading
VOLUME /home/$userName/content/inbox
VOLUME /home/$userName/content/torrentBackup

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD wget -q --spider "localhost:$webPort" || exit 1