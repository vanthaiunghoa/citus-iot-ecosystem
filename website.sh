#!/bin/bash
source ./set-env.sh
eval $(minikube docker-env)
docker-compose up -d --force-recreate