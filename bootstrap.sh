#!/bin/bash
set -e -x

cd /usr/share/citus-iot-ecosystem/production/
docker-compose down
docker rmi ($docker images -q)
docker-compose up -d