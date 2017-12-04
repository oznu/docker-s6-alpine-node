FROM library/node:8.9.1-alpine

ENV ARCH=amd64

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

# s6 overlay
RUN apk add --no-cache curl coreutils tzdata shadow \
  && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.1.1/s6-overlay-${ARCH}.tar.gz | tar xvzf - -C / \
  && apk del --no-cache curl

COPY rootfs /

# create user
RUN groupmod -g 911 users && \
  useradd -u 911 -U -d /config -s /bin/false abc && \
  usermod -G users abc && \
  mkdir -p \
    /app \
    /config \
    /defaults && \
  apk del --purge \
  rm -rf /tmp/*

ENTRYPOINT [ "/init" ]
