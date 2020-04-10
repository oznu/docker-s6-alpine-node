[![Build](https://github.com/oznu/docker-s6-alpine-node/workflows/Build/badge.svg)](https://github.com/oznu/docker-s6-alpine-node/actions)

# s6-node

This is a base Node.js image with the S6 Overlay and support for x86_64 and ARM (Raspberry Pi 1, 2, 3).

Alpine/Debian Linux + [S6 Overlay](https://github.com/just-containers/s6-overlay) + [Node](https://nodejs.org/en/)

## Usage

See the [S6 Overlay Documentation](https://github.com/just-containers/s6-overlay) for details on how to manage services.

x86_64:

```shell
docker run oznu/s6-node:amd64
docker run oznu/s6-node:debian-amd64
```

ARM:

```shell
docker run oznu/s6-node:armhf
docker run oznu/s6-node:debian-armhf
```