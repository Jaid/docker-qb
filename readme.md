# docker-qbittorrent-nox

[![dockeri.co](https://dockeri.co/image/jaidchen/qbittorrent-nox)](https://hub.docker.com/r/jaidchen/qbittorrent-nox)

## Compiling benchmark

ubuntu
`qbt_optimise_strip=yes qbt_libtorrent_version=2.0 qbt_qt_version=6.3.1 qbittorrent-nox-static.sh all`
28405472
real    12m58.839s
user    60m7.392s
sys     6m35.980s

ubuntu
`qbt_libtorrent_version=2.0 qbt_qt_version=6.3.1 qbittorrent-nox-static.sh all`
38678712
real    12m54.808s
user    59m42.551s
sys     6m38.496s

debian:stable-slim
`qbt_optimise_strip=yes qbt_libtorrent_version=2.0 qbt_qt_version=6.3.1 qbittorrent-nox-static.sh all`
27693608
real    12m32.920s
user    56m57.138s
sys     6m37.262s

bash:5.2.15-alpine3.16
`qbt_libtorrent_version=2.0 qbt_qt_version=6.3.1 qbt_build_tool=cmake qbt_use_qt6=ON bash ~/qbStatic/qbittorrent-nox-static.sh all --libtorrent-tag v2.0.8 --qbittorrent-master --icu --no-delete --strip --cmake`
61009192
real    13m38.178s
user    68m0.923s
sys     11m55.495s

debian:stable-slim
`qbt_libtorrent_version=2.0 qbt_qt_version=6 bash ~/qbStatic/qbittorrent-nox-static.sh all --libtorrent-tag v2.0.8 --qbittorrent-master --icu --no-delete --strip`
61922408
real    13m20.343s
user    61m6.936s
sys     7m10.177s

debian:stable-slim
`qbt_libtorrent_version=2.0 qbt_qt_version=6 bash ~/qbStatic/qbittorrent-nox-static.sh all --libtorrent-tag v2.0.8 --qbittorrent-master --icu --cmake --strip`
61922408
real    13m15.600s
user    60m35.560s
sys     7m13.014s

debian:stable-slim
`bash ~/qbStatic/qbittorrent-nox-static.sh all --cmake --strip --build-directory $buildDirectory`
27515048
real    13m12.013s
user    56m16.540s
sys     6m34.325s