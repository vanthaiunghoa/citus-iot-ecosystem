#!/bin/bash
set -e -x

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_IOT_CERT_BUCKET=apps.citus.io/certs
export AWS_IOT_DEVICE_POLICY=CitusSensorPolicy
export AWS_METADATA_TABLE_NAME=citus-iot-ecosystem.metadata
export AWS_SENSORS_TABLE_NAME=citus-iot-ecosystem.sensors
export AWS_SENSORS_STREAM_VIEW_TYPE=new_and_old_images

cd /usr/share/citus-iot-ecosystem/production/
docker-compose down
docker rmi $(docker images -q)
docker system prune
docker-compose up -d