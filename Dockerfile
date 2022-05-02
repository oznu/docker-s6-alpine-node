ARG BASE_IMAGE
FROM ${BASE_IMAGE:-library/alpine}:3.15

ARG QEMU_ARCH
ENV QEMU_ARCH=${QEMU_ARCH:-x86_64} S6_KEEP_ENV=1

ARG NODE_VERSION
ENV NODE_VERSION=${NODE_VERSION:-16.14.2}

ENV S6_OVERLAY_VERSION=2.2.0.3
ENV S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0

COPY qemu/qemu-${QEMU_ARCH}-static /usr/bin/

RUN set -x && apk add --no-cache bash libgcc libstdc++ curl curl-dev coreutils tzdata shadow libstdc++ logrotate py3-pip \
  && groupmod -g 911 users \
  && useradd -u 911 -U -d /config -s /bin/false abc \
  && usermod -G users abc \
  && mkdir -p /app /config /defaults \
  && pip3 install tzupdate \
  && apk del --purge \
  && rm -rf /tmp/* \
  && sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

RUN case "${QEMU_ARCH}" in \
    x86_64) S6_ARCH='amd64';; \
    arm) S6_ARCH='armhf';; \
    aarch64) S6_ARCH='aarch64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && cd /tmp \
  && curl -SLO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCH}-installer \
  && chmod +x /tmp/s6-overlay-${S6_ARCH}-installer && /tmp/s6-overlay-${S6_ARCH}-installer /

RUN set -x && curl -fLO https://github.com/oznu/alpine-node/releases/download/${NODE_VERSION}/node-v${NODE_VERSION}-linux-${QEMU_ARCH}-alpine.tar.gz \
  && tar -xzf node-v${NODE_VERSION}-linux-${QEMU_ARCH}-alpine.tar.gz -C /usr --strip-components=1 --no-same-owner \
  && rm -rf node-v${NODE_VERSION}-linux-${QEMU_ARCH}-alpine.tar.gz \
  && npm set prefix /usr/local \
  && npm config set unsafe-perm true

COPY rootfs /

ENTRYPOINT [ "/init" ]
