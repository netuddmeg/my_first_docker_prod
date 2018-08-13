#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
DOCKERURL="https://github.com/docker/machine/releases/download/v0.15.0";
REPODIR="my_first_docker_prod";
REPO="https://github.com/netuddmeg/my_first_docker_prod.git";
PROJECTNAME="my_first_docker_project";
PORTS="80";

export DEBIAN_FRONTEND=noninteractive;

sudo -- sh -c 'apt-get install curl -y';

curl -L $DOCKERURL/docker-machine-$(uname -s)-$(uname -m) > /tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine;

if [ $? != 0 ] ; then
	echo "There was a problem downloading the script! Check your internet connection!"
	exit 1;
else
#        clear;
        echo -n "Please, enter machine name here [ENTER]: ";
        read machine;
        DOCKERMACHINE=$machine;
	VALID=`docker-machine ls|cut -f1 -d " "|tail -1`;

	if [ $DOCKERMACHINE = $VALID ] ; then
		echo "INVALID machine name, its already exist! Choose another name!";
                exit 1;
        else

#		clear;
        	echo -n "Please, enter your token here [ENTER]: ";
	        read token;
	        DOTOKEN=$token;
#		clear;
		docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;
                rm /tmp/docker-machine;
	fi;

	IPADDR=`docker-machine ip docker-sandbox`;
	if [ ! -z $IPADDR ]; then

		docker-machine ssh $DOCKERMACHINE "export DEBIAN_FRONTEND=noninteractive && sudo apt-get install git -y";
		docker-machine ssh $DOCKERMACHINE "git clone $REPO && cd $REPODIR";
                eval $(docker-machine env $DOCKERMACHINE);
		docker-machine ssh $DOCKERMACHINE "curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) > ./docker-compose;chmod +x ./docker-compose";
		docker-machine ssh $DOCKERMACHINE "./docker-compose up --build";
#		docker-machine ssh $DOCKERMACHINE "docker build -t $PROJECTNAME $REPODIR";
#		docker-machine ssh $DOCKERMACHINE "docker run --rm -p 80:$PORTS -d -t $PROJECTNAME";
		echo "---------------------------------------------";
		echo "Check the result at: ---> http://$IPADDR:$PORTS <---";
		echo "---------------------------------------------";

	else
		echo "Cannot find IP address!";
		exit 1;
	fi;




fi;

