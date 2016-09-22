#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}INFO: Updating OS software packages...${NC}"
sudo apt update
sudo apt full-upgrade
echo -e "${GREEN}INFO: Installing Developer Tools...${NC}"
sudo apt-get install git python curl
echo -e "${GREEN}INFO: Installing Software Agents...${NC}"
git clone https://github.com/cuongquay/citus-iot-device-agents.git $HOME/citus-iot-device-agents/
cd $HOME/citus-iot-device-agents/ && sudo bash install.sh
cd $HOME; rm -rf $HOME/citus-iot-device-agents/
mkdir -p $HOME/.agent/
echo "${DEVICE_ID}" >> ${HOME}/.agent/.device-id
echo "${SECRET_KEY}" >> ${HOME}/.agent/.secret-key
