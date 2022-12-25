#!/usr/bin/env bash
set -o errexit

cd qbStatic
qbt_optimise_strip=yes qbt_libtorrent_version=2.0 qbt_qt_version=6.3.1 bash -o xtrace qbittorrent-nox-static.sh all
