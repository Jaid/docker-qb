#!/usr/bin/env bash
set -o errexit -o pipefail

env
downloadGithubArchive dracula/qbittorrent ~/qbDracula sha 08386a4b211a7c20382a35f1d349d1ca04ed84a2
