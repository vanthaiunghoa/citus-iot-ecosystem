#!/bin/sh
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

echo "Do you wish to install Citus IoT Device SDK for Javascript?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
        	echo "Installing NodeJS 6.x..."
			curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
			sudo apt install -y nodejs
			echo "Installing Citus IoT Device SDK..." 
			https://github.com/cuongquay/citus-iot-sdk-nodejs.git $HOME/citus-iot-sdk-nodejs/
			cd $HOME/citus-iot-sdk-nodejs/ && npm install && npm update
			echo "Try it out! Type 'npm run examples' on the console."
			cd $HOME; rm -rf $HOME/citus-iot-sdk-nodejs/
			echo "Installed SDK successfully!" 
			break;;
        No ) exit;;
    esac
done
