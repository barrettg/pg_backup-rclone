#!/bin/sh
set -e

echo "Generating Cron Tab"
/scripts/crontab_gen.sh

echo "Generating Config"
/scripts/config_gen.sh

exec "$@"
