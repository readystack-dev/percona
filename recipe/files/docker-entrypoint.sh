#!/usr/bin/env bash
# ReadyStack MySQL entrypoint. Runs as the non-root mysql user.
#
# First start (no /var/lib/mysql/mysql directory): refuses to initialise unless MYSQL_ROOT_PASSWORD
# (or MYSQL_ROOT_PASSWORD_FILE) is at least 8 characters and not a well-known example password;
# MYSQL_ALLOW_EMPTY_PASSWORD and MYSQL_RANDOM_ROOT_PASSWORD are refused. It runs
# mysqld --initialize-insecure, starts a bootstrap server with no TCP listener (--skip-networking,
# X Plugin off) and sets the root password over the Unix socket before the real server opens a port.
# A marker file covers the bootstrap: if it is interrupted, every later start refuses to run, because
# the data directory may then hold a root account with no password.
# Arguments after the image name go to mysqld; a first argument that is not an option is run instead.
set -Eeuo pipefail
export PATH="/usr/local/mysql/bin:$PATH"
DATADIR=/var/lib/mysql
MARKER="$DATADIR/.readystack-init-incomplete"

die() { echo "readystack: $*" >&2; exit 1; }

if [ "${1:-}" = mysqld ]; then shift; fi
if [ -n "${1:-}" ] && [ "${1#-}" = "$1" ]; then exec "$@"; fi

file_env() {
  local var="$1" fvar="${1}_FILE"
  if [ -n "${!var:-}" ] && [ -n "${!fvar:-}" ]; then die "set $var or $fvar, not both"; fi
  if [ -n "${!fvar:-}" ]; then
    [ -r "${!fvar}" ] || die "$fvar names ${!fvar}, which is not a readable file"
    export "$var=$(< "${!fvar}")"
  fi
}

# Succeeds (password refused) when it is shorter than 8 characters or a well-known example value.
weak_password() {
  local lc
  [ "${#1}" -ge 8 ] || return 0
  lc="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
  case "$lc" in
    password|passw0rd|password1|12345678|123456789|1234567890|changeme|change-me|changeit|my-secret-pw|mysecretpassword|rootpassword|your_password|your_root_password|your_secret) return 0 ;;
  esac
  return 1
}

sql_string() { local s="${1//\\/\\\\}"; s="${s//\'/\\\'}"; printf "'%s'" "$s"; }
sql_ident() { printf '`%s`' "${1//\`/\`\`}"; }

if [ -e "$MARKER" ]; then
  die "the first-start initialisation of $DATADIR did not finish ($MARKER exists), so the data directory may hold a root account with no password. Remove this data directory (the volume) and start again."
fi

if [ ! -d "$DATADIR/mysql" ]; then
  file_env MYSQL_ROOT_PASSWORD
  file_env MYSQL_PASSWORD
  if [ -n "${MYSQL_ALLOW_EMPTY_PASSWORD:-}" ] || [ -n "${MYSQL_RANDOM_ROOT_PASSWORD:-}" ]; then
    die "MYSQL_ALLOW_EMPTY_PASSWORD and MYSQL_RANDOM_ROOT_PASSWORD are not supported by this image; set MYSQL_ROOT_PASSWORD."
  fi
  [ -n "${MYSQL_ROOT_PASSWORD:-}" ] || die "MYSQL_ROOT_PASSWORD is not set. This image does not create a root account without a password: set MYSQL_ROOT_PASSWORD (or MYSQL_ROOT_PASSWORD_FILE) to a password of at least 8 characters."
  if weak_password "$MYSQL_ROOT_PASSWORD"; then
    die "MYSQL_ROOT_PASSWORD is shorter than 8 characters or is a well-known example password; choose another one."
  fi
  if [ -n "${MYSQL_USER:-}" ]; then
    [ "$MYSQL_USER" != root ] || die "MYSQL_USER=root is not allowed: the root account is created from MYSQL_ROOT_PASSWORD."
    [ -n "${MYSQL_PASSWORD:-}" ] || die "MYSQL_USER is set but MYSQL_PASSWORD is not."
    if weak_password "$MYSQL_PASSWORD"; then
      die "MYSQL_PASSWORD is shorter than 8 characters or is a well-known example password; choose another one."
    fi
  elif [ -n "${MYSQL_PASSWORD:-}" ]; then
    die "MYSQL_PASSWORD is set but MYSQL_USER is not."
  fi
  [ -w "$DATADIR" ] || die "$DATADIR is not writable by uid $(id -u) ($(id -un)); a host directory mounted there must belong to that uid."
  root_host="${MYSQL_ROOT_HOST:-%}"

  : > "$MARKER"
  echo "readystack: initialising a new data directory in $DATADIR"
  mysqld --initialize-insecure --datadir="$DATADIR" "$@"
  mysqld --datadir="$DATADIR" --skip-networking --mysqlx=OFF "$@" &
  pid=$!
  ready=
  for _ in $(seq 1 120); do
    if mysqladmin -uroot --silent ping >/dev/null 2>&1; then ready=1; break; fi
    kill -0 "$pid" 2>/dev/null || die "the bootstrap server exited during initialisation (see the log above)"
    sleep 1
  done
  [ -n "$ready" ] || die "the bootstrap server did not answer within 120 seconds"

  {
    echo "SET @@SESSION.SQL_LOG_BIN=0;"
    echo "SET @@SESSION.SQL_MODE=REPLACE(@@SESSION.SQL_MODE,'NO_BACKSLASH_ESCAPES','');"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY $(sql_string "$MYSQL_ROOT_PASSWORD");"
    if [ "$root_host" != localhost ]; then
      echo "CREATE USER 'root'@$(sql_string "$root_host") IDENTIFIED BY $(sql_string "$MYSQL_ROOT_PASSWORD");"
      echo "GRANT ALL ON *.* TO 'root'@$(sql_string "$root_host") WITH GRANT OPTION;"
      echo "GRANT PROXY ON ''@'' TO 'root'@$(sql_string "$root_host") WITH GRANT OPTION;"
    fi
    if [ -n "${MYSQL_DATABASE:-}" ]; then
      echo "CREATE DATABASE IF NOT EXISTS $(sql_ident "$MYSQL_DATABASE");"
    fi
    if [ -n "${MYSQL_USER:-}" ]; then
      echo "CREATE USER $(sql_string "$MYSQL_USER")@'%' IDENTIFIED BY $(sql_string "$MYSQL_PASSWORD");"
      if [ -n "${MYSQL_DATABASE:-}" ]; then
        echo "GRANT ALL ON $(sql_ident "$MYSQL_DATABASE").* TO $(sql_string "$MYSQL_USER")@'%';"
      fi
    fi
  } | mysql -uroot

  export MYSQL_PWD="$MYSQL_ROOT_PASSWORD"
  for f in /docker-entrypoint-initdb.d/*; do
    [ -e "$f" ] || continue
    case "$f" in
      *.sh)  echo "readystack: running $f"; . "$f" ;;
      *.sql) echo "readystack: running $f"; mysql -uroot ${MYSQL_DATABASE:+"--database=$MYSQL_DATABASE"} < "$f" ;;
      *)     echo "readystack: ignoring $f" ;;
    esac
  done
  mysqladmin -uroot shutdown
  wait "$pid"
  unset MYSQL_PWD
  rm -f "$MARKER"
  echo "readystack: initialisation complete"
fi

exec mysqld --datadir="$DATADIR" "$@"
