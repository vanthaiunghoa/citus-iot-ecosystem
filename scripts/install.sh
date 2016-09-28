#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[1;30m' # No Color
DEF='\033[0m' # Default Color
CURRENT_USER=$(whoami)

echo -e "${GREEN}INFO: Updating OS software packages...${NC}"
if [ -r /etc/debian_version ] && [ "$lsb_dist" != "ubuntu" ] && [ "$lsb_dist" != "raspbian" ]; then
	# We're Debian and don't even know it!
	sudo apt update
	sudo apt full-upgrade
	echo -e "${GREEN}INFO: Installing Developer Tools...${NC}"
	sudo apt-get install git python curl
else	
	echo -e "${GREEN}INFO: Installing Developer Tools...${NC}"
	sudo yum install git python curl -y
fi

echo -e "${GREEN}INFO: Installing Software Agents...${NC}"
git clone https://github.com/cuongquay/citus-iot-device-agents.git $HOME/citus-iot-device-agents/
cd $HOME/citus-iot-device-agents/
if [ "${CURRENT_USER}" == "root" ]; then 
	sh install.sh
else
	sudo sh install.sh
fi
cd $HOME; rm -rf $HOME/citus-iot-device-agents/
mkdir -p $HOME/.agent/
echo "${DEVICE_ID}" >> ${HOME}/.agent/.device-id
echo "${SECRET_KEY}" >> ${HOME}/.agent/.secret-key
echo -e "${DEF}"