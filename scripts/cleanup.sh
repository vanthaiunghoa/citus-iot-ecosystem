#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[1;30m' # No Color

echo -e "${RED}DANGEROUS: Are you sure you want to destroy this device?${NC}"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
        	echo -e "${BLUE}INFO: Deactivating this device against platform...${NC}"
			sudo citus-device revoke
			echo -e "${BLUE}INFO: Removing device certificates and agents...${NC}" 
			sudo citus-device remove
			echo -e "${BLUE}INFO: Cleanup device successfully!${NC}" 
			break;;
        No ) exit;;
    esac
done
