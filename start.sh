#!/bin/bash

source vars/config
export DEBIAN_FRONTEND=noninteractive;

sudo -- sh -c 'apt-get install curl -y';

DOWNLOAD=$(sudo curl -L $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine);

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

	IPADDR=`docker-machine ip docker-sandbox`;
	if [ ! -z $IPADDR ]; then

		docker-machine ssh $DOCKERMACHINE "export DEBIAN_FRONTEND=noninteractive && sudo apt-get install git -y";
		docker-machine ssh $DOCKERMACHINE "git clone $REPO && cd $REPO";
                eval $(docker-mashine env $DOCKERMACHINE);
		docker build -t $PROJECTNAME:latest $REPO/";
		docker run --rm -p 80:80 -d -t $PROJECTNAME:latest";

	else
		echo "Cannot find IP address!";
		exit 1;
	fi;




fi;
