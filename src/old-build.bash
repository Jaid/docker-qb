#!/usr/bin/env bash
set -o errexit

DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install curl
DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install --no-install-recommends build-essential pkg-config qtbase5-dev qt5-qmake qtbase5-dev-tools libboost-dev cmake libssl-dev zlib1g-dev libgl1-mesa-dev libtorrent-rasterbar-dev ninja-build

repoSha=b12fdcf018df75733f594839ac66ca7c4f89018f
curl --location --fail --show-error https://github.com/qbittorrent/qBittorrent/archive/$repoSha.tar.gz --output qb.tar.gz
tar -x -z -f qb.tar.gz
mv qBittorrent-$repoSha qb

# repoSha=900dd69dcb790a008fdd33186b0e383893fc4402
# curl --location --fail --show-error https://github.com/userdocs/qbittorrent-nox-static/archive/$repoSha.tar.gz --output qbStatic.tar.gz
# tar -x -z -f qbStatic.tar.gz
# mv qbittorrent-nox-static-$repoSha qbStatic

#  DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update && repoSha=900dd69dcb790a008fdd33186b0e383893fc4402 && DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade && DEBIAN_FRONTEND=noninteractive apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install curl && cd && curl --location --fail --show-error https://github.com/userdocs/qbittorrent-nox-static/archive/$repoSha.tar.gz --output qbStatic.tar.gz && tar -x -z -f qbStatic.tar.gz && mv qbittorrent-nox-static-$repoSha qbStatic && cd qbStatic && qbt_optimise_strip=yes qbt_libtorrent_version=2.0 qbt_qt_version=6.3.1 bash -o xtrace qbittorrent-nox-static.sh all
#
#
#

# cd qbStatic
# qbt_optimise_strip=yes qbt_qt_version=6 bash qbittorrent-nox-static.sh

# ./configure \
#   QT_QMAKE="${qbt_install_dir}/bin" \
#   --prefix="${qbt_install_dir}" \
#   "${multi_qbittorrent[@]}" \
#   "${qbt_qbittorrent_debug}" \
#   --disable-gui \
#   CXXFLAGS="${CXXFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" \
#   --with-boost="${qbt_install_dir}/boost" --with-boost-libdir="${lib_dir}" |& tee -a "${qbt_install_dir}/logs/${app_name}.log"

# mkdir -p "${qbt_install_dir}/graphs/${qbittorrent_github_tag}"
# cmake -Wno-dev -Wno-deprecated --graphviz="${qbt_install_dir}/graphs/${qbittorrent_github_tag}/dep-graph.dot" -G Ninja -B build \
#   "${multi_qbittorrent[@]}" \
#   -D CMAKE_VERBOSE_MAKEFILE="${qbt_cmake_debug}" \
#   -D CMAKE_BUILD_TYPE="release" \
#   -D QT6="${qbt_use_qt6}" \
#   -D STACKTRACE="${stacktrace:-ON}" \
#   -D CMAKE_CXX_STANDARD="${standard}" \
#   -D CMAKE_PREFIX_PATH="${qbt_install_dir};${qbt_install_dir}/boost" \
#   -D Boost_NO_BOOST_CMAKE=TRUE \
#   -D CMAKE_CXX_FLAGS="${CXXFLAGS}" \
#   -D Iconv_LIBRARY="${lib_dir}/libiconv.a" \
#   -D GUI=OFF \
#   -D CMAKE_INSTALL_PREFIX="${qbt_install_dir}" |& tee -a "${qbt_install_dir}/logs/${app_name}.log"
# cmake --build build |& tee -a "${qbt_install_dir}/logs/${app_name}.log"

# post_command build

# cmake --install build |& tee -a "${qbt_install_dir}/logs/${app_name}.log"

# dot -Tpng -o "${qbt_install_dir}/completed/${app_name}-graph.png" "${qbt_install_dir}/graphs/${qbittorrent_github_tag}/dep-graph.dot"

cd qb
./configure --disable-gui --disable-debug
cmake -B ~/build -G Ninja -D SYSTEMD=OFF -D CMAKE_BUILD_TYPE=RelWithDebInfo -D CMAKE_INSTALL_PREFIX=/usr/local
cmake --build ~/build
cmake --install ~/build
