FROM node:6.11.0-alpine

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

# s6 overlay
RUN apk add --no-cache curl coreutils tzdata shadow \
 && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz | tar xvzf - -C / \
 && apk del --no-cache curl

COPY rootfs /

# create user
RUN groupmod -g 911 users && \
  useradd -u 911 -U -d /config -s /bin/false abc && \
  usermod -G users abc && \

  # make folders
  mkdir -p \
   /app \
   /config \
   /defaults && \

  # clean up
  apk del --purge \
  rm -rf /tmp/*

ENTRYPOINT [ "/init" ]
