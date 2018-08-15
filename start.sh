#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
DMURL="https://github.com/docker/machine/releases/download/v0.15.0";
REPODIR="my_first_docker_prod";
DOCKERMACHINE="docker-sandbox-swarm";
REPO="https://github.com/netuddmeg/my_first_docker_prod.git";
PROJECTNAME="my_first_docker_project";
PORTS="80";
DM=~/docker-machine;

export DEBIAN_FRONTEND=noninteractive && apt update && apt install curl -y;

if [ ! -f $DM  ] ; then
        curl -L $DMURL/docker-machine-$(uname -s)-$(uname -m) > ~/docker-machine && chmod +x $DM;

fi;

        	echo -n "Please, enter your token here [ENTER]: ";
	        read token;
	        DOTOKEN=$token;
		~/docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;

		~/docker-machine ssh $DOCKERMACHINE "export DEBIAN_FRONTEND=noninteractive && sudo apt-get install git -y";
		~/docker-machine ssh $DOCKERMACHINE "git clone $REPO";
		eval $(~/docker-machine env $DOCKERMACHINE);
		~/docker-machine ssh $DOCKERMACHINE "curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) > ~/docker-compose;chmod +x ~/docker-compose";
		~/docker-machine ssh $DOCKERMACHINE "cd $REPODIR && ~/docker-compose up --build";
		echo "---------------------------------------------";
		IPADDR=`$DM ip $DOCKERMACHINE`;
		echo "Check the result at: ---> http://$IPADDR:$PORTS <---";
		echo "---------------------------------------------";

