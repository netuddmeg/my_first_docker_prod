#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
DOCKERURL="https://github.com/docker/machine/releases/download/v0.15.0"

export DEBIAN_FRONTEND=noninteractive;

sudo -- sh -c 'apt-get install curl -y';

DOWNLOAD=$(curl -L $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine);

if [ $? != 0 ] ; then
	echo "There was a problem downloading the script! Check your internet connection!"
	exit 1;
else
	bash -c "$DOWNLOAD";

        clear;
        echo -n "Please, enter machine name here [ENTER]: ";
        read machine;
        DOCKERMACHINE=$machine;
	VALID=`docker-machine ls|cut -f1 -d " "|tail -1`;

	if [ $DOCKERMACHINE = $VALID ] ; then
		echo "INVALID machine name, its already exist! Choose another name!"
                exit 1;
        else

		clear;
        	echo -n "Please, enter your token here [ENTER]: ";
	        read token;
	        DOTOKEN=$token;
		clear;
		docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;
                rm /tmp/docker-machine;
	fi;


fi;
