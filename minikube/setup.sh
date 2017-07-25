#!/bin/bash

OS_RELEASE=$(cat /etc/os-release)
KUBERNETES_VERSION="v1.6.4"

curl -LO "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin/ 
sudo ln -s /usr/local/bin/kubectl /usr/bin/kubectl

curl -LO minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
sudo ln -s /usr/local/bin/minikube /usr/bin/minikube

minikube start --memory=5120

git clone https://github.com/cuongquay/citus-iot-ecosystem.git

cd ~/citus-iot-ecosystem/minikube
cp ~/.minikube/apiserver.* ~/.kube/
cp ~/.minikube/ca.crt ~/.kube/

cat > ~/.kube/kubeconfig <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority: ca.crt
    server: https://192.168.99.100:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: apiserver.crt
    client-key: apiserver.key
    
EOF

kubectl apply -f default-services/kubernetes-dashboard.yaml
kubectl apply -f default-services/citus-iot-ecosystem.yaml
sh default-services/citus-iot-ecosystem.sh
sh default-services/citus-cassandra-database.sh

eval $(minikube docker-env)
docker-compose up -d --force-recreate