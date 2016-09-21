#!/bin/bash
echo "Are you sure you want to destroy this device?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
        	echo "Deactivating this device against platform..."
			sudo citus-device revoke
			echo "Removing device certificates and agents..." 
			sudo citus-device remove
			echo "Cleanup device successfully!" 
			break;;
        No ) exit;;
    esac
done
