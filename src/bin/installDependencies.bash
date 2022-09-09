#!/usr/bin/env bash
set -o errexit

if [ "$debugBash" ]; then
  set -o xtrace
fi

if [ $# -lt 1 ]; then
  printf >&2 'Arguments needed: %s\nArguments given:  %s\n' 1 $#
  exit 1
fi

function aptGet {
  DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes --quiet "$@"
}

declare -a requiredAptPackages=()
for positionalArgument; do
  requiredAptPackages+=("$positionalArgument")
done

declare -a missingAptPackages=()
for requiredAptPackage in "${requiredAptPackages[@]}"; do
  set +o errexit
  checkResult=$(dpkg -l "$requiredAptPackage" 2>&1)
  checkResultStatus=$?
  set -o errexit
  if [ $checkResultStatus -ne 0 ]; then
    missingAptPackages+=("$requiredAptPackage")
  elif [[ $checkResult =~ \<none\> ]]; then # Like this: https://pastebin.com/raw/AWT53iqP
    missingAptPackages+=("$requiredAptPackage")
  elif [[ $checkResult =~ no\ packages\ found ]]; then # Like this: https://pastebin.com/raw/zKrZaDEN
    missingAptPackages+=("$requiredAptPackage")
  fi
done
if [ ${#missingAptPackages[@]} -gt 0 ]; then
  printf 'Installing apt packages: %s\n' "${missingAptPackages[*]}"
  aptGet update
  aptGet install "${missingAptPackages[@]}"
fi
