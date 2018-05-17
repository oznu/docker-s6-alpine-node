ARG BASE_IMAGE
FROM ${BASE_IMAGE:-library/alpine}:3.7

ARG S6_ARCH
ENV S6_ARCH=${S6_ARCH:-amd64} S6_KEEP_ENV=1

COPY qemu /usr/bin/

ENV NODE_VERSION 8.11.1

RUN set -x && echo http://dl-cdn.alpinelinux.org/alpine/edge/main > /etc/apk/repositories \
  && echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
  && apk add --no-cache --upgrade apk-tools \
  && apk add --no-cache \
    curl curl-dev coreutils tzdata shadow libstdc++ paxctl \
    nodejs nodejs-npm yarn \
  && paxctl -cm `which node` \
  && npm set prefix /usr/local \
  && npm config set unsafe-perm true \
  && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.1.1/s6-overlay-${S6_ARCH}.tar.gz | tar xvzf - -C / \
  && groupmod -g 911 users && \
  useradd -u 911 -U -d /config -s /bin/false abc && \
  usermod -G users abc && \
  mkdir -p /app /config /defaults && \
  apk del --purge \
  rm -rf /tmp/*

COPY rootfs /

ENTRYPOINT [ "/init" ]
