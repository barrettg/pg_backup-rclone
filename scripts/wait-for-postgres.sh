#!/bin/bash
# wait-for-postgres.sh
# From https://docs.docker.com/compose/startup-order/

set -e

cmd="$@"

until psql -h "$POSTGRES_HOSTNAME" -U "$POSTGRES_USER" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd