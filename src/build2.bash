#!/usr/bin/env bash
set -o errexit -o pipefail

repoOwner=userdocs
repoName=qbittorrent-nox-static
repoSha=900dd69dcb790a008fdd33186b0e383893fc4402
tarFileName=qbStatic.tar.gz

cd
curl --location --retry 3 --fail --silent --show-error https://github.com/$repoOwner/$repoName/archive/$repoSha.tar.gz --output $tarFileName
tar -x -z -f $tarFileName
rm $tarFileName
mv $repoName-$repoSha qbStatic
