#!/usr/bin/env bash
set -o errexit -o pipefail

time bash ~/qbStatic/qbittorrent-nox-static.sh all --libtorrent-tag v2.0.8 --qbittorrent-tag master --icu --cmake --strip --build-directory "$buildDirectory"
du -sb "$buildDirectory/bin/qbittorrent-nox"
