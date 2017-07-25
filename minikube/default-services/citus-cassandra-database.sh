#!/bin/sh

export CITUS_CASSANDRA_REST=http://192.168.99.100:8020/api/v1/proxy/namespaces/default/services/citus-cassandra-rest:80
export CITUS_APPLICATION_GATEWAY=http://192.168.99.100:8020/api/v1/proxy/namespaces/default/services/citus-application-gateway:8001

curl "${CITUS_CASSANDRA_REST}/browser/citus" -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace_name":"citus","replication":{"class":"SimpleStrategy","replication_factor":1}}' --compressed
curl "${CITUS_CASSANDRA_REST}/query" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":" create table citus.apps (\n\tid uuid,\n\tname varchar,\n\timage varchar,\n\ttype varchar,\n\townerid ascii,\n\tauthor text,\n\tlinks list<varchar>,\n\tservice varchar,\n\tstatus ascii,\n\tdescription text,\n\tcolor varchar,\n\tenv varchar,\n\ttarget varchar,\t\n\tcreated bigint,\n\tmodified bigint,\n\tPRIMARY KEY (id, ownerid)\n\t);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.apps (status);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.apps (links);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"create table citus.types (\n\tid uuid primary key,\n\tname varchar,\n\tvalue varchar\n\t); "}' --compressed
curl "${CITUS_CASSANDRA_REST}/query" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"create table citus.users (\t\n\tid varchar primary key,\n\tname varchar,\n\temail varchar,\n\tgiven_name varchar,\n\tfamily_name varchar,\t\n\tpicture varchar,\n\tsubscription_type varchar,\n\tstatus ascii\n\t);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.users (subscription_type);"}' --compressed
curl "${CITUS_CASSANDRA_REST}/query" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"keyspace":"","query":"CREATE INDEX ON citus.users (status);"}' --compressed

curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "citus-cassandra-rest","request_path": "\/citus-cassandra-rest","upstream_url": "http:\/\/citus-cassandra-rest.default.svc.cluster.local\/","strip_request_path": true,"preserve_host": false}' --compressed
curl "${CITUS_APPLICATION_GATEWAY}/apis/" -X PUT -H 'Content-Type: application/json;charset=UTF-8' --data-binary $'{"name": "device-management-service","request_path": "\/device-management-service","upstream_url": "http:\/\/device-management-service.default.svc.cluster.local\/","strip_request_path": true,"preserve_host": false}' --compressed