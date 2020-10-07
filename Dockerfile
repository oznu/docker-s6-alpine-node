ARG BASE_IMAGE
FROM ${BASE_IMAGE:-library/alpine}:3.12

ARG QEMU_ARCH
ENV QEMU_ARCH=${QEMU_ARCH:-x86_64} S6_KEEP_ENV=1

COPY qemu/qemu-${QEMU_ARCH}-static /usr/bin/

RUN set -x && apk add --no-cache libgcc libstdc++ curl curl-dev coreutils tzdata shadow libstdc++ paxmark logrotate py3-pip \
  && case "${QEMU_ARCH}" in \
    x86_64) S6_ARCH='amd64';; \
    arm) S6_ARCH='armhf';; \
    aarch64) S6_ARCH='aarch64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.1.1/s6-overlay-${S6_ARCH}.tar.gz | tar xvzf - -C / \
  && groupmod -g 911 users \
  && useradd -u 911 -U -d /config -s /bin/false abc \
  && usermod -G users abc \
  && mkdir -p /app /config /defaults \
  && pip3 install tzupdate \
  && apk del --purge \
  && rm -rf /tmp/* \
  && sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

ENV NODE_VERSION 12.19.0

RUN set -x && curl -fLO https://github.com/oznu/alpine-node/releases/download/${NODE_VERSION}/node-v${NODE_VERSION}-linux-${QEMU_ARCH}-alpine.tar.gz \
  && tar -xzf node-v${NODE_VERSION}-linux-${QEMU_ARCH}-alpine.tar.gz -C /usr --strip-components=1 --no-same-owner \
  && rm -rf node-v${NODE_VERSION}-linux-${QEMU_ARCH}-alpine.tar.gz \
  && paxmark `which node` \
  && npm set prefix /usr/local \
  && npm config set unsafe-perm true

COPY rootfs /

ENTRYPOINT [ "/init" ]
