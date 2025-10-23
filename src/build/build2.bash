#!/usr/bin/env bash
set -o errexit -o pipefail

env
downloadGithubArchive dracula/qbittorrent ~/qbDracula sha 2b1ba32b5978e73dc8962449f0560bc5713f2a1b
