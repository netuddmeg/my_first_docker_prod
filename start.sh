#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export DEBIAN_FRONTEND=noninteractive;
DOCKERURL="https://github.com/docker/machine/releases/download/v0.15.0"
DOCKERMACHINE="docker-sandbox"


sudo -- sh -c 'apt-get update -y && apt-get upgrade -y && apt-get install curl -y';

curl -C - $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
sudo install /tmp/docker-machine /usr/local/bin/docker-machine;


echo -n  "Please, enter your token here [ENTER]:";
read token;

docker-machine create --driver digitalocean --digitalocean-access-token $token $DOCKERMACHINE;