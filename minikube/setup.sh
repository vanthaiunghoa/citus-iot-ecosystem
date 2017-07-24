#!/bin/bash

OS_RELEASE=$(cat /etc/os-release)
AMAZON_AMI="Amazon Linux AMI"
CENTOS_AMI="CentOS Linux"
KUBE_AWS_VERSION="v0.9.4-rc.2"
KUBERNETES_VERSION="v1.6.4"

if [ -z "${OS_RELEASE##*$AMAZON_AMI*}" ]; then
	yum install docker -y
	chkconfig --add docker
	chkconfig docker on
	service docker start
	usermod -aG docker ec2-user	
else	
	tee /etc/yum.repos.d/docker.repo <<-'EOF'
	[dockerrepo]
	name=Docker Repository
	baseurl=https://yum.dockerproject.org/repo/main/centos/7/
	enabled=1
	gpgcheck=1
	gpgkey=https://yum.dockerproject.org/gpg
	EOF
	yum install docker-engine python -y
	curl -O https://bootstrap.pypa.io/get-pip.py
	python get-pip.py
	pip install awscli
	pip install --upgrade awscli
	systemctl enable docker.service
	systemctl start docker
	usermod -aG docker centos	
	setsebool httpd_can_network_connect on -P
	getsebool -a | grep httpd
	rm -f get-pip.py
	yum clean all
fi

curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl
chmod +x ./kubectl && mv ./kubectl /usr/bin/kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

minikube start

git clone https://github.com/cuongquay/citus-iot-ecosystem.git

cd ~/citus-iot-ecosystem/minikube

kubectl apply -f default-services/citus-iot-ecosystem.yaml
sh default-services/citus-iot-ecosystem.sh

docker-compose up -d --force-recreate