#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
DOCKERURL="https://github.com/docker/machine/releases/download/v0.15.0"
DOCKERMACHINE="docker-sandbox"

export DEBIAN_FRONTEND=noninteractive;

sudo -- sh -c 'apt-get install curl -y';

DOWNLOAD=$(curl -L - $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine);

if [ $? != 0 ] ; then
    echo "There was a problem downloading the script"
    exit 1
else
    bash -c "$DOWNLOAD";
    echo -n "Please, enter your token here [ENTER]: ";
    read token;
    DOTOKEN=$token;

    docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;

fi
