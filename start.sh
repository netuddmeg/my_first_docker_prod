#!/bin/sh

source conf/vars;
export DEBIAN_FRONTEND=noninteractive;

sudo -c 'apt-get update -y && apt-get upgrade -y && apt-get install curl -y';

DOCKERURL=https://github.com/docker/machine/releases/download/v0.15.0 && \
curl -L $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
sudo install /tmp/docker-machine /usr/local/bin/docker-machine;


#docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN docker-sandbox