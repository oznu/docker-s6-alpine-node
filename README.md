[![Docker Automated buil](https://img.shields.io/docker/automated/oznu/homebridge.svg)](https://hub.docker.com/r/oznu/s6-node/)

# s6-node

This is a base Node.js image with the S6 Overlay and support for x86_64 and ARM (Raspberry Pi 1, 2, 3).

[Alpine Linux](https://alpinelinux.org/) + [S6 Overlay](https://github.com/just-containers/s6-overlay) + [Node](https://nodejs.org/en/)

## Usage

See the [S6 Overlay Documentation](https://github.com/just-containers/s6-overlay) for details on how to manage services.

x86_64:

```shell
docker run oznu/s6-node
```

ARM:

```shell
docker run oznu/s6-node:armhf
```
