#!/bin/sh

set -x

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export DEBIAN_FRONTEND=noninteractive;
DOCKERURL="https://github.com/docker/machine/releases/download/v0.15.0"


sudo -- sh -c 'apt-get update -y && apt-get upgrade -y && apt-get install curl -y';

curl -O -C - $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
sudo install /tmp/docker-machine /usr/local/bin/docker-machine;


read -p "Please, enter your token here:";
DOTOKEN=$answer;

docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN docker-sandbox