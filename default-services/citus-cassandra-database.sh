#!/bin/sh

curl "${CITUS_CASSANDRA_REST}/browser/citus" -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace_name":"citus","replication":{"class":"SimpleStrategy","replication_factor":1}}' --compressed
curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":" create table citus.apps (\n\tid uuid,\n\tname varchar,\n\timage varchar,\n\ttype varchar,\n\townerid ascii,\n\tauthor text,\n\tlinks list<varchar>,\n\tservice varchar,\n\tstatus ascii,\n\tdescription text,\n\tcolor varchar,\n\tenv varchar,\n\ttarget varchar,\t\n\tcreated bigint,\n\tmodified bigint,\n\tbaseuri boolean,\n\tPRIMARY KEY (id, ownerid)\n\t);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.apps (status);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.apps (links);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"create table citus.types (\n\tid uuid primary key,\n\tname varchar,\n\tvalue varchar\n\t); "}' --compressed
curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"create table citus.users (\t\n\tid varchar primary key,\n\tname varchar,\n\temail varchar,\n\tgiven_name varchar,\n\tfamily_name varchar,\t\n\tpicture varchar,\n\tsubscription_type varchar,\n\tstatus ascii\n\t);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.users (subscription_type);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.users (status);"}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "citus-cassandra-rest","request_path": "\/citus-cassandra-rest","upstream_url": "http:\/\/citus-cassandra-rest.default.svc.cluster.local\/","strip_request_path": true,"preserve_host": false}' --compressed

JSON_OBJECT=$(curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "device-management-service","request_path": "\/device-management-service","upstream_url": "http:\/\/device-management-service.default.svc.cluster.local\/","strip_request_path": true,"preserve_host": false}' --compressed)
OBJECT_ID=$(echo ${JSON_OBJECT} | python -c "import sys, json; print json.load(sys.stdin)['id']" 2> /dev/null)
curl "${CITUS_APPLICATION_GATEWAY}/plugins" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"api_id":"'${OBJECT_ID}'","name":"key-auth","config":{"hide_credentials":false,"key_names":"secret_key"}}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "device-management-service-docs","request_path": "\/device-management-service/docs","upstream_url": "http:\/\/device-management-service.default.svc.cluster.local\/docs","strip_request_path": true,"preserve_host": false}' --compressed

curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"keyspace":"","query":" insert into citus.apps (id, name, image, type, ownerid, author, service, status, description, color, env, target, created, baseuri) values (uuid(), \'Sensor Dashboard\', \'cuongdd1/sensor-remote-dashboard\', \'dashboard\', \'auth0|system-default-account\', \'system\', \'sensor-dashboard\', \'approved\', \'A Sensor Remote Dashboard application that allows you monitoring your sensor data over device network.\', \'yellow\', \'AUTH0_CLIENT_SECRET=Auth0ClientSecret,AWS_ACCESS_KEY_ID=AWSIoTThingShadowID,AWS_SECRET_ACCESS_KEY=AWSIoTThingShadowKey,AWS_DEFAULT_REGION=ap-northeast-1,ELASTIC_SEARCH_SERVICE=http://citus-elasticsearch-svc.default.svc.cluster.local/telemetry/sensors/_search,DEVICE_LIFECYCLE_SERVICE=http://v1.apps.citus.io/apisrv/device-lifecycle-service\', \'1880/TCP\' , 1487047059582, false)"}' --compressed

curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"keyspace":"","query":"insert into citus.apps (id, name, image, type, ownerid, author, service, status, description, color, env, target, created, baseuri) values (uuid(), \'Seniot Dataflow\', \'cuongdd1/seniot-gateway\', \'gateway\', \'auth0|system-default-account\', \'system\', \'seniot-dataflow\', \'approved\', \'A Data Processing, Data Visualization and Application Routing that allows you process data betwwen IoT Device and Cloud Services.\', \'gray\', \'AWS_ACCESS_KEY_ID=AWSIoTThingShadowID,AWS_SECRET_ACCESS_KEY=AWSIoTThingShadowKey,AWS_DEFAULT_REGION=ap-northeast-1\', \'1880/TCP\' , 1501749625129, false)"}' --compressed

curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"keyspace":"","query":"insert into citus.apps (id, name, image, type, ownerid, author, service, status, description, color, env, target, created, baseuri) values (uuid(), \'Sensor Analytics\', \'cuongdd1/citus-sensor-analytics\', \'analytics\', \'auth0|system-default-account\', \'system\', \'sensor-analytics\', \'published\', \'A Sensor Analytics application that allows you discovering your sensor data over devices.\', \'gray\', \'ELASTIC_SEARCH_SERVICE=http://citus-elasticsearch-svc.default.svc.cluster.local/telemetry/sensors/_search,DEVICE_LIFECYCLE_SERVICE=http://device-lifecycle-service.default.svc.cluster.local\', \'1880/TCP\' , 1487047170101, false)"}' --compressed

curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"keyspace":"","query":"insert into citus.apps (id, name, image, type, ownerid, author, service, status, description, color, env, target, created, baseuri) values (uuid(), \'Recognition Toolkit\', \'cuongdd1/citus-recognition-service\', \'analytics\', \'auth0|system-default-account\', \'system\', \'recognition-toolkit\', \'published\', \'A set of Citus Recognition Services that allow to detect your face or your car plate number.\', \'gray\', \'AWS_ACCESS_KEY_ID=AWSIoTThingShadowID,AWS_SECRET_ACCESS_KEY=AWSIoTThingShadowKey,AWS_DEFAULT_REGION=ap-northeast-1,API_KEY=,SECRET_KEY=\', \'3000/TCP\' , 1492418866126, false)"}' --compressed

curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"keyspace":"","query":"insert into citus.apps (id, name, image, type, ownerid, author, service, status, description, color, env, target, created, baseuri) values (uuid(), \'Tensorflow (Notebook)\', \'cuongdd1/tensorflow\', \'analytics\', \'auth0|system-default-account\', \'system\', \'tensorflow-toolkit\', \'approved\', \'A customized docker images for deep learning framework TensorFlow with Notebook (http://www.tensorflow.org).\', \'gray\', \'PASSWORD=tensorflow\', \'8888/TCP\' , 1501657039192, true)"}' --compressed

curl "${CITUS_CASSANDRA_REST}/query?secret_key=${SECRET_KEY}" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"keyspace":"","query":"insert into citus.apps (id, name, image, type, ownerid, author, service, status, description, color, env, target, created, baseuri) values (uuid(), \'Tensorflow (Service)\', \'cuongdd1/tensorflow-service\', \'analytics\', \'auth0|system-default-account\', \'system\', \'tensorflow-service\', \'approved\', \'A customized docker images for deep learning framework TensorFlow with REST API service.\', \'gray\', \'CLUSTER_IP=127.0.0.1\', \'8888/TCP\' , 1501735907153, false)"}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "sensor-analytics-website","request_path": "\/sensor-analytics~auth0-system-default-account","upstream_url": "http:\/\/sensor-analytics.default.svc.cluster.local\/","strip_request_path": true,"preserve_host": false}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "sensor-analytics-service","request_path": "\/sensor-analytics-service","upstream_url": "http:\/\/sensor-analytics.default.svc.cluster.local\/","strip_request_path": true,"preserve_host": false}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "sensor-analytics-docs","request_path": "\/sensor-analytics/docs","upstream_url": "http:\/\/sensor-analytics.default.svc.cluster.local\/docs","strip_request_path": true,"preserve_host": false}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "recognition-toolkit-website","request_path": "\/recognition-toolkit~auth0-system-default-account","upstream_url": "http:\/\/recognition-toolkit.default.svc.cluster.local\/","strip_request_path": true,"preserve_host": false}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "recognition-toolkit-docs","request_path": "\/recognition-toolkit/docs","upstream_url": "http:\/\/recognition-toolkit.default.svc.cluster.local\/docs","strip_request_path": true,"preserve_host": false}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "recognition-toolkit-plate","request_path": "\/plate-recognition","upstream_url": "http:\/\/recognition-toolkit.default.svc.cluster.local\/plate-recognition","strip_request_path": true,"preserve_host": false}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "recognition-toolkit-face","request_path": "\/face-detection","upstream_url": "http:\/\/recognition-toolkit.default.svc.cluster.local\/face-detection","strip_request_path": true,"preserve_host": false}' --compressed
