#!/usr/bin/env bash
set -o errexit -o pipefail

DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install build-essential curl pkg-config automake libtool git perl python3 python3-dev python3-numpy unzip graphviz re2c flex texinfo gettext
