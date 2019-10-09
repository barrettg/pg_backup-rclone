#!/bin/bash

###########################
####### LOAD CONFIG #######
###########################
 
while [ $# -gt 0 ]; do
        case $1 in
                -c)
                        CONFIG_FILE_PATH="$2"
                        shift 2
                        ;;
                *)
                        ${ECHO} "Unknown Option \"$1\"" 1>&2
                        exit 2
                        ;;
        esac
done
 
if [ -z $CONFIG_FILE_PATH ] ; then
        SCRIPTPATH=$(cd ${0%/*} && pwd -P)
        CONFIG_FILE_PATH="${SCRIPTPATH}/pg_backup.config"
fi
 
if [ ! -r ${CONFIG_FILE_PATH} ] ; then
        echo "Could not load config file from ${CONFIG_FILE_PATH}" 1>&2
        exit 1
fi
 
source "${CONFIG_FILE_PATH}"

echo "Config Path: " $CONFIG_FILE_PATH "Config Filename:" $RCLONE_CONFIG_FILENAME "Remote Name: " $RCLONE_REMOTE_NAME "Remote Path: " $RCLONE_REMOTE_PATH

rclone -v --config ${CONFIG_FILE_PATH}/${RCLONE_CONFIG_FILENAME} sync /backups ${RCLONE_REMOTE_NAME}:${RCLONE_REMOTE_PATH}