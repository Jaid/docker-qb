#!/usr/bin/env bash
set -o errexit -o pipefail

repoSha=900dd69dcb790a008fdd33186b0e383893fc4402
tarFileName=qbStatic.tar.gz

cd
curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' https://github.com/userdocs/qbittorrent-nox-static/archive/$repoSha.tar.gz --output $tarFileName
tar -x -z -f $tarFileName
mv qbittorrent-nox-static-$repoSha qbStatic
rm $tarFileName
