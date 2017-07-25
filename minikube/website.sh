#!/bin/bash
eval $(minikube docker-env)
docker-compose up -d --force-recreate