#!/usr/bin/env bash
set -o errexit

DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install curl

repoSha=900dd69dcb790a008fdd33186b0e383893fc4402
curl --location --fail --show-error https://github.com/userdocs/qbittorrent-nox-static/archive/$repoSha.tar.gz --output qbStatic.tar.gz
tar -x -z -f qbStatic.tar.gz
mv qbittorrent-nox-static-$repoSha qbStatic
cd qbStatic
qbt_optimise_strip=yes qbt_libtorrent_version=2.0 qbt_qt_version=6.3.1 bash -o xtrace qbittorrent-nox-static.sh all
