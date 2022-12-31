#!/usr/bin/env bash
set -o errexit -o pipefail

repo=dracula/qbittorrent
repoSha=a9d64acd1faf2d23f46a98b20eba6640805a0f62
tarFileName=dracula.tar.gz

cd
curl --location --retry 3 --fail --silent --show-error https://github.com/$repo/archive/$repoSha.tar.gz --output $tarFileName
tar -x -z -f $tarFileName
rm $tarFileName
mv qbittorrent-nox-static-$repoSha qbDracula
