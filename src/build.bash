#!/usr/bin/env bash
set -o errexit

# repoSha=303df78232765713bbb459ffb0d50a930e4a7304

# DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update
# DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade
# DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install curl
# DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install build-essential libssl-dev libpcre3-dev libcurl4-openssl-dev
# curl --location --fail --show-error https://github.com/10gic/vanitygen-plusplus/archive/$repoSha.tar.gz --output vanitygen-plusplus.tar.gz
# tar -x -z -f vanitygen-plusplus.tar.gz
# mv vanitygen-plusplus-$repoSha vanitygen-plusplus
# make --directory vanitygen-plusplus
