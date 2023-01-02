#!/usr/bin/env bash
set -o errexit -o pipefail

export DEBIAN_FRONTEND=noninteractive
export qbt_libtorrent_version=2.0
export qbt_qt_version=6
export qbt_build_tool=cmake
export buildDirectory=/root/qbBuild

time bash ~/qbStatic/qbittorrent-nox-static.sh all --libtorrent-tag v2.0.8 --qbittorrent-tag master --icu --cmake --strip --build-directory "$buildDirectory"
du -sb "$buildDirectory/bin/qbittorrent-nox"
