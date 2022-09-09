# syntax=docker/dockerfile:1

FROM ubuntu:kinetic

ENV userName=app
ENV groupName=app
ENV userId=1000
ENV groupId=1000

# https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#non-root-user
RUN addgroup --system --gid $groupId $groupName
RUN adduser --disabled-password --gecos '' --uid $userId --ingroup $groupName --home /home/$userName --shell /bin/bash $userName

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

COPY --chown=$userId:$groupId ./bin /home/$userName/bin

WORKDIR /home/$userName

ENV debugBash=false
RUN bash /home/$qbittorrentUser/bin/installDependencies.bash curl jq qbittorrent-nox
CMD bash /home/$qbittorrentUser/bin/run.bash

VOLUME /home/$userName/qBittorrent
VOLUME /home/$userName/content/finished
VOLUME /home/$userName/content/downloading
VOLUME /home/$userName/content/inbox
VOLUME /home/$userName/content/torrentBackup

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD wget -q --spider "localhost:$webPort" || exit 1