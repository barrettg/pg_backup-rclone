FROM postgres:alpine
MAINTAINER Barrett Gay

COPY /scripts /

RUN apk -U add ca-certificates fuse wget dcron tzdata curl unzip \
  && rm -rf /var/cache/apk/*
  
RUN sh -c 'curl -sL https://rclone.org/install.sh | bash -'

VOLUME /backups

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/docker-cmd.sh"]