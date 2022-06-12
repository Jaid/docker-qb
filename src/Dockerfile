# syntax=docker/dockerfile:1

FROM alpine:3.16

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

ARG webUser=admin
ENV webUser=$webUser

ARG webPasswordPbkdf2="KOhefdma+6Y9jh0NRrvmDA==:D9Qi3a/yoqFrpUCpd00ufqLbzVRRmFTTuuKx6HYY0NiRVVcw1lphedyjkzGsMwvlAgayHMqqXW3gl64hec1OXg=="
ENV webPasswordPbkdf2=$webPasswordPbkdf2

ARG webPort
ENV webPort=$webPort
EXPOSE $webPort

ARG directPort
ENV directPort=$directPort
EXPOSE $directPort

ARG startSlow=true
ENV startSlow=$startSlow

ARG finishedPath=/home/$userName/content/finished
ENV finishedPath=$finishedPath

ARG downloadingPath=/home/$userName/content/downloading
ENV downloadingPath=$downloadingPath

ARG inboxPath=/home/$userName/content/inbox
ENV inboxPath=$inboxPath

ARG torrentBackupPath=/home/$userName/content/torrentBackup
ENV torrentBackupPath=$torrentBackupPath

COPY --chown=$userId:$groupId ./run.sh /home/$userName/bin/run.sh

CMD sh /home/$qbittorrentUser/bin/run.sh

VOLUME /home/$userName/qBittorrent
VOLUME /home/$userName/content/finished
VOLUME /home/$userName/content/downloading
VOLUME /home/$userName/content/inbox
VOLUME /home/$userName/content/torrentBackup