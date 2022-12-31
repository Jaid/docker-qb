#!/usr/bin/env bash
set -o errexit -o pipefail

repo=userdocs/qbittorrent-nox-static
repoSha=900dd69dcb790a008fdd33186b0e383893fc4402
tarFileName=qbStatic.tar.gz

cd
curl --location --retry 3 --fail --silent --show-error https://github.com/$repo/archive/$repoSha.tar.gz --output $tarFileName
tar -x -z -f $tarFileName
rm $tarFileName
mv qbittorrent-nox-static-$repoSha qbStatic
