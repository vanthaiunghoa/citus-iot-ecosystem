#!/bin/bash
echo "Updating OS software packages..."
sudo apt update
sudo apt full-upgrade
echo "Installing Developer Tools..."
sudo apt-get install git python curl
echo "Installing Software Agents..."
git clone https://github.com/cuongquay/citus-iot-device-agents.git $HOME/citus-iot-device-agents/
cd $HOME/citus-iot-device-agents/ && sudo bash install.sh
cd $HOME; rm -rf $HOME/citus-iot-device-agents/
echo "Installed Software Agents successfully!"
