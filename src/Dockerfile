# syntax=docker/dockerfile:1

FROM jaidchen/builder:main-lts AS build

ARG libtorrentVersion
ENV libtorrentVersion=$libtorrentVersion
ADD ./build/contextBuild* $userHome/bin
RUN ["/bin/bash", "-c", "/bin/bash -o errexit -o pipefail -o xtrace ${userHome}/bin/contextBuild.bash"]

FROM jaidchen/runner:main-lts

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

COPY --from=build --chown=$userId:$groupId /root/qbBuild/bin/qbittorrent-nox /bin
COPY --from=build --chown=$userId:$groupId /root/qbDracula $userHome/dracula
RUN chmod --recursive ugo+rw $userHome/dracula

EXPOSE $webPort
EXPOSE $directPort

VOLUME $userHome/qBittorrent
VOLUME $userHome/content
VOLUME $userHome/media
