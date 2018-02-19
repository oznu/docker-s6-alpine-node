[![Docker Build Status](https://img.shields.io/docker/build/oznu/s6-node.svg?label=x64%20build&style=for-the-badge)](https://hub.docker.com/r/oznu/s6-node/) [![Travis](https://img.shields.io/travis/oznu/docker-s6-alpine-node.svg?label=arm%20build&style=for-the-badge)](https://travis-ci.org/oznu/docker-s6-alpine-node)

# s6-node

This is a base Node.js image with the S6 Overlay and support for x86_64 and ARMv7 (Raspberry Pi 2 or 3).

[Debian Linux](https://hub.docker.com/_/debian/) + [S6 Overlay](https://github.com/just-containers/s6-overlay) + [Node](https://nodejs.org/en/)

## Usage

See the [S6 Overlay Documentation](https://github.com/just-containers/s6-overlay) for details on how to manage services.

x86_64:

```shell
docker run oznu/s6-node:debian
```

ARM:

```shell
docker run oznu/s6-node:debian-armhf
```
