# syntax=docker/dockerfile:1

FROM ubuntu:22.04 AS build

ENV DEBIAN_FRONTEND noninteractive
ENV qbt_libtorrent_version 2.0
ENV qbt_qt_version 6
ENV qbt_build_tool cmake
ENV buildDirectory /root/qbBuild

ADD build*.bash /bin
RUN mkdir --parents $buildDirectory
WORKDIR $buildDirectory
RUN ["/usr/bin/bash", "-o", "xtrace", "/bin/build.bash"]
RUN ["/usr/bin/bash", "-o", "xtrace", "/bin/build2.bash"]
RUN ["/usr/bin/bash", "-o", "xtrace", "/bin/build3.bash"]
RUN ["/usr/bin/bash", "-o", "xtrace", "/bin/build4.bash"]

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

COPY --from=build --chown=$userId:$groupId /root/qbBuild/bin/qbittorrent-nox /bin
COPY --from=build --chown=$userId:$groupId /root/qbDracula/webui $userHome/dracula

EXPOSE $webPort
EXPOSE $directPort

VOLUME $userHome/qBittorrent
VOLUME $userHome/content
VOLUME $userHome/media
