#!/usr/bin/env bash
set -o errexit -o pipefail

env
# libtorrentVersion=${libtorrentVersion:-2.0.9}
if [[ -z $abc ]]; then
  printf >&2 'Variable $abc not existing\n'
  exit 1
fi
printf 'abc = %s\n' "$abc"

export DEBIAN_FRONTEND=noninteractive
export qbt_libtorrent_version="${libtorrentVersion%.*}"
export qbt_qt_version=6
export qbt_build_tool=cmake
export buildDirectory=/root/qbBuild

time bash ~/qbStatic/qbittorrent-nox-static.sh all --libtorrent-tag "v$libtorrentVersion" --qbittorrent-tag master --icu --cmake --strip --build-directory "$buildDirectory"
du -sb "$buildDirectory/bin/qbittorrent-nox"
