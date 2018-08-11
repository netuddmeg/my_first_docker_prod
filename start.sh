#!/bin/sh

source config;
export DEBIAN_FRONTEND=noninteractive;

apt update -y && apt upgrade -y && apt install curl;

base=https://github.com/docker/machine/releases/download/v0.15.0 && \
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
sudo install /tmp/docker-machine /usr/local/bin/docker-machine;


#docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN docker-sandbox