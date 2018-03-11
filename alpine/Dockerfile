ARG S6_ARCH
FROM multiarch/alpine:${S6_ARCH}-v3.7

ARG S6_ARCH
ENV S6_ARCH=${S6_ARCH} S6_KEEP_ENV=1

ENV NODE_VERSION 8.10.0
ENV YARN_VERSION 1.5.1

RUN set -x && echo http://dl-cdn.alpinelinux.org/alpine/edge/main > /etc/apk/repositories \
  && echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
  && apk add --no-cache --upgrade apk-tools \
  && apk add --no-cache \
    curl coreutils tzdata shadow libstdc++ \
    nodejs=${NODE_VERSION}-r0 nodejs-npm=${NODE_VERSION}-r0 yarn=${YARN_VERSION}-r0 \
  && npm set prefix /usr/local \
  && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.1.1/s6-overlay-${S6_ARCH}.tar.gz | tar xvzf - -C / \
  && apk del --no-cache curl \
  && groupmod -g 911 users && \
  useradd -u 911 -U -d /config -s /bin/false abc && \
  usermod -G users abc && \
  mkdir -p /app /config /defaults && \
  apk del --purge \
  rm -rf /tmp/*

COPY rootfs /

ENTRYPOINT [ "/init" ]
