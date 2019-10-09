#!/bin/sh
set -e

#crond -s /etc/crontabs -f "$@"

echo "Executing Postgres Backup Script"
/scripts/pg_backup_rotated.sh

echo "Executing rclone Upload"
/scripts/rclone-upload.sh