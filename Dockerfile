FROM postgres:alpine
MAINTAINER Barrett Gay

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh

# Install Alpine Deps
RUN apk -U add ca-certificates fuse wget dcron tzdata curl unzip \
  && rm -rf /var/cache/apk/*
  
# Install rclone
RUN sh -c 'curl -sL https://rclone.org/install.sh | bash -'

ENV POSTGRES_HOSTNAME localhost
ENV POSTGRES_USER postgres
ENV POSTGRES_PASS postgres
ENV WEEKS_TO_KEEP 4
ENV DAYS_TO_KEEP 7
ENV DAY_OF_WEEK_TO_KEEP 6
ENV CRON_RUN_MINUTE 0
ENV CRON_RUN_HOUR=23
ENV CONFIG_FILE_PATH /config
ENV RCLONE_CONFIG_FILENAME rclone.conf
ENV RCLONE_REMOTE_NAME remote
ENV RCLONE_REMOTE_PATH /

VOLUME /backups
VOLUME /config

ENTRYPOINT ["top", "-b"]
#ENTRYPOINT ["/scripts/docker-entrypoint.sh"]
#CMD ["/scripts/docker-cmd.sh"]