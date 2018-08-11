#!/bin/bash
set -x

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
DOCKERURL="https://github.com/docker/machine/releases/download/v0.15.0"
DOCKERMACHINE="docker-sandbox"

export DEBIAN_FRONTEND=noninteractive;

sudo -- sh -c 'apt-get install curl -y';

curl -L -C - $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
sudo install /tmp/docker-machine /usr/local/bin/docker-machine;

echo -n "Please, enter your token here [ENTER]: ";
read -n 1 -s -r -p token;
DOTOKEN=$token;

docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;