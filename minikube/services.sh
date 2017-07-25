#!/bin/bash
kubectl apply -f default-services/kubernetes-dashboard.yaml
kubectl apply -f default-services/citus-iot-ecosystem.yaml
sh default-services/citus-iot-ecosystem.sh
sh default-services/citus-cassandra-database.sh