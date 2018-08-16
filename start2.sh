#!/bin/bash -x
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
DMURL="https://github.com/docker/machine/releases/download/v0.15.0";
REPODIR="my_first_docker_prod";
DOCKERMACHINE="docker-sandbox-swarm";
REPO="https://github.com/netuddmeg/my_first_docker_prod.git";
PROJECTNAME="my_first_docker_project";
DPATH="/usr/local/bin/";

export DEBIAN_FRONTEND=noninteractive && sudo apt install curl -y;

if [ ! -f "/usr/local/bin/docker-machine"  ] ; then
        sudo curl -L $DMURL/docker-machine-$(uname -s)-$(uname -m) > $DPATH/docker-machine && sudo chmod +x $DPATH/docker-machine;
fi;

if [ ! -f "/usr/local/bin/docker-compose"  ] ; then
		sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) > $DPATH/docker-compose;sudo chmod +x $DPATH/docker-compose";
fi;


#        	echo -n "Please, enter your token here [ENTER]: ";
#	        read token;
	        DOTOKEN="4a90749f56a92dcc7f8f77a5690c21e492631386bf440786b742ea5f8f28393e";
		docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;

		docker-machine ssh $DOCKERMACHINE "export DEBIAN_FRONTEND=noninteractive && sudo apt-get install git -y";
		docker-machine ssh $DOCKERMACHINE "curl -L $DMURL/docker-machine-$(uname -s)-$(uname -m) > $DPATH/docker-machine && chmod +x $DPATH/docker-machine";
		eval $(docker-machine env $DOCKERMACHINE);

		if [ ! -f "/usr/local/bin/docker-compose" ] ; then
			docker-machine ssh $DOCKERMACHINE "curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) > $DPATH/docker-compose;sudo chmod +x $DPATH/docker-compose";
		fi;

		git clone $REPO;
		cd $REPODIR; docker-compose up --build;


