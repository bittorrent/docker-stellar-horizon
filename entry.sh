#!/usr/bin/env bash
set -ue

: ${DATA_DIR:=/data}
: ${DB_PORT:=5432}

# Wait for postgres
export PGPASSWORD=${DB_PASS}
while ! psql -h "${DB_HOST}" -U "${DB_USER}" -p "${DB_PORT}" -c 'select 1' "${DB_NAME}" &> /dev/null ; do
  echo "Waiting for postgres to be available..."
  sleep 5
done

# Wait 3 more seconds for postgres to restart itself
sleep 5


# Wait for stellar-core
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' ${STELLAR_CORE_URL}/info)" != "200" ]]; do
  echo "Waiting for stellar-core to be available..."
  sleep 1
done


# Check if DB needs to be initialized
DB_INITIALIZED_MARKER="${DATA_DIR}/horizon/.db-initialized"
if [ ! -f ${DB_INITIALIZED_MARKER} ]; then
    echo "initializing horizon db..."
    horizon db init
    mkdir -p ${DATA_DIR}/horizon
    touch ${DB_INITIALIZED_MARKER}
fi


echo "starting horizon..."
exec "$@"
