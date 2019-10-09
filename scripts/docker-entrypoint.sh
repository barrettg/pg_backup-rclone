#!/bin/sh
set -e

echo "Generating Cron Tab"
/scripts/crontab_gen.sh

echo "Generating Config"
/scripts/config_gen.sh

echo ${POSTGRES_HOSTNAME}:5432:*:${POSTGRES_USERNAME}:${POSTGRES_PASSWORD} > ~/.pgpass
chmod 0600 ~/.pgpass
cat ~/.pgpass

exec "$@"
