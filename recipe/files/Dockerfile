# GENERATED L-009 hermetic C build (--network=none, SBOM+SLSA-attestation-producing).
# Pinned bases; vendored source (in-tree deps) + extra build debs + runtime debs from Dockerfile.vendor.
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS cbuild
# dpkg-install the vendored EXTRA build debs (pkg-config/libssl-dev/...) — gcc/make are in the builder.
RUN --mount=type=bind,source=vendored/build-debs,target=/tmp/bdebs \
    set --; for f in /tmp/bdebs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; }
WORKDIR /src
COPY vendored/percona-src/ .
ARG SOURCE_DATE_EPOCH=1795672795
ENV SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH}
ENV DEB_BUILD_MAINT_OPTIONS=optimize=-lto
RUN cmake -S . -B build -DBUILD_CONFIG=mysql_release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DINSTALL_LAYOUT=STANDALONE -DREPRODUCIBLE_BUILD=ON '-DCOMPILATION_COMMENT=ReadyStack build of Percona Server (GPL)' '-DCOMPILATION_COMMENT_SERVER=ReadyStack build of Percona Server (GPL)' -DWITH_SSL=system -DWITH_ZLIB=system -DWITH_ZSTD=system -DWITH_LZ4=system -DWITH_ICU=system -DWITH_PROTOBUF=bundled -DWITH_EDITLINE=bundled -DWITH_TIRPC=bundled -DWITH_CURL=system -DWITH_FIDO=none -DWITH_AUTHENTICATION_LDAP=OFF -DWITH_AUTHENTICATION_KERBEROS=OFF -DWITH_AUTHENTICATION_WEBAUTHN=OFF -DWITH_AUTHENTICATION_CLIENT_PLUGINS=OFF -DWITH_ROUTER=OFF -DWITH_UNIT_TESTS=OFF -DWITH_ROCKSDB=ON -DROCKSDB_DISABLE_AVX2=1 -DROCKSDB_DISABLE_MARCH_NATIVE=1 -DWITH_PAM=ON -DWITH_PERCONA_TELEMETRY=OFF -DWITH_JS_LANG=OFF -DWITH_NDB=OFF -DWITHOUT_NDBCLUSTER_STORAGE_ENGINE=ON -DWITH_SYSTEMD=OFF -DWITH_NUMA=OFF -DWITHOUT_THREAD_POOL=1 -DINSTALL_MYSQLTESTDIR= -DINSTALL_STATIC_LIBRARIES=OFF
RUN J=$(nproc); M=$(awk '/MemAvailable/ {print int($2/2097152)}' /proc/meminfo); [ "$M" -ge 1 ] || M=1; [ "$M" -lt "$J" ] && J=$M; echo "compiling with $J parallel jobs"; cmake --build build --parallel "$J"
RUN cmake --install build --strip
RUN cmake --install build --component Test --prefix /tmp/test-component && (cd /tmp/test-component && find . \( -type f -o -type l \) -print0) | (cd /usr/local/mysql && xargs -0 -r rm -f) && rm -rf /tmp/test-component
RUN rm -f /usr/local/mysql/docs/INFO_BIN /usr/local/mysql/docs/INFO_SRC
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289
ENV DEBIAN_FRONTEND=noninteractive PATH=/usr/local/mysql/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin LANG=C.UTF-8
RUN --mount=type=bind,source=vendored/debs,target=/tmp/debs \
    set --; for f in /tmp/debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    rm -rf /var/lib/apt/lists/* \
           /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /var/cache/ldconfig/aux-cache /var/cache/fontconfig
ARG SOURCE_DATE_EPOCH=1795672795
RUN groupadd -r -g 1001 mysql && useradd -r -u 1001 -g mysql -d /home/mysql -m mysql && \
    mkdir -p /var/lib/mysql /var/log/mysql /var/run/mysqld /docker-entrypoint-initdb.d && chown -R mysql:mysql /var/lib/mysql /var/log/mysql /var/run/mysqld /docker-entrypoint-initdb.d && \
    : "${SOURCE_DATE_EPOCH:?SOURCE_DATE_EPOCH must be set for a reproducible build}" && \
    sed -ri "s/^([^:]*:[^:]*):[0-9]*:/\1:$((SOURCE_DATE_EPOCH/86400)):/" /etc/shadow && \
    rm -f /etc/passwd- /etc/shadow- /etc/group- /etc/gshadow-
COPY --from=cbuild /usr/local/mysql /usr/local/mysql
COPY my.cnf /etc/mysql/my.cnf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh
RUN mkdir -p /etc/mysql/conf.d
LABEL org.opencontainers.image.title="Percona"
LABEL org.opencontainers.image.version="9.7.2-3-CE-ubuntu24.04-r2"
LABEL org.opencontainers.image.source="https://github.com/readystack-dev/percona"
LABEL org.opencontainers.image.description="Percona Server for MySQL 9.7.2-3 (9.7 LTS) compiled from source (CE, non-root, offline-rebuildable)"
LABEL org.opencontainers.image.licenses="GPL-2.0-only"
LABEL org.opencontainers.image.revision="45d3d00fefeeda215229e834e43d60a08bd0bf6c"
LABEL readystack.upstream.source="https://github.com/percona/percona-server"
LABEL org.opencontainers.image.url="https://readystack.dev/products/percona"
LABEL org.opencontainers.image.documentation="https://github.com/readystack-dev/percona#readme"
LABEL org.opencontainers.image.authors="ReadyStack <contact@readystack.dev>"
LABEL org.opencontainers.image.vendor="ReadyStack.dev"
HEALTHCHECK --interval=5s --timeout=180s --start-period=90s \
  CMD mysqladmin --protocol=tcp --host=127.0.0.1 --port=3306 --connect-timeout=5 --silent ping || exit 1
USER mysql
EXPOSE 3306 33060
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
