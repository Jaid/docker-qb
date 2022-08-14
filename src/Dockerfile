# syntax=docker/dockerfile:1

FROM alpine:3.16.2

RUN apk add --no-cache qbittorrent-nox

ARG userName=app
ARG groupName=$userName
ARG userId=1000
ARG groupId=1000

# https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#non-root-user
RUN addgroup -S --gid $groupId $groupName
RUN adduser --disabled-password --gecos '' --uid $userId --ingroup $groupName --home /home/$userName --shell /bin/sh $userName

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

COPY --chown=$userId:$groupId ./run.ash /home/$userName/bin/run.ash

WORKDIR /home/$userName

CMD ash /home/$qbittorrentUser/bin/run.ash

VOLUME /home/$userName/qBittorrent
VOLUME /home/$userName/content/finished
VOLUME /home/$userName/content/downloading
VOLUME /home/$userName/content/inbox
VOLUME /home/$userName/content/torrentBackup

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD wget -q --spider "localhost:$webPort" || exit 1