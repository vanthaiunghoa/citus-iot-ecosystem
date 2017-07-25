#!/bin/bash
KUBERNETES_VERSION="v1.6.4"
if [ -f /usr/bin/sw_vers ]; then
	echo "INFO: Installing Developer Tools for Mac OSX."
	brew install git python curl
	pip install requests
	curl -LO "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	
	curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin/ 
	sudo ln -s /usr/local/bin/kubectl /usr/bin/kubectl
	
	curl -LO minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
	sudo ln -s /usr/local/bin/minikube /usr/bin/minikube
else
	echo "INFO: Installing Developer Tools for Windows."
fi

minikube start --memory=5120
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
cp ~/.kube/kubeconfig ~/.kube/config

