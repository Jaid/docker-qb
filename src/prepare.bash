#!/usr/bin/env bash

mkdir --parents "$userHome/qBittorrent"
mkdir --parents "$userHome/content"
mkdir --parents "$userHome/media"
chown --recursive "$userId:$groupId" "$userHome"

DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes update
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --option APT::Get::Install-Recommends=false --option APT::Get::Install-Suggests=false --yes install curl jq qbittorrent-nox
rm -rf /var/log/* /var/lib/apt/lists/* /var/cache/apt/archives/* /usr/share/doc /usr/share/man
