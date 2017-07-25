#!/bin/sh

export ECOSYSTEM_RELEASE_VERSION=latest

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_IOT_CERT_BUCKET=apps.citus.io/certs
export AWS_METADATA_TABLE_NAME=citus-iot-ecosystem.metadata
export AWS_SENSORS_TABLE_NAME=citus-iot-ecosystem.sensors
export AWS_SENSORS_STREAM_VIEW_TYPE=new_and_old_images

export ELASTIC_SEARCH_SERVICE=http://citus-elasticsearch-svc.default.svc.cluster.local/telemetry/sensors/_search
export DEVICE_LIFECYCLE_SERVICE=http://192.168.99.100/apisrv/device-management-service
export AUTH0_CLIENT_SECRET=
export OPENFPT_API_KEY=

export CITUS_CASSANDRA_REST=http://192.168.99.100:8020/api/v1/proxy/namespaces/default/services/citus-cassandra-rest:80
export CITUS_APPLICATION_GATEWAY=http://192.168.99.100:8020/api/v1/proxy/namespaces/default/services/citus-application-gateway:8001
