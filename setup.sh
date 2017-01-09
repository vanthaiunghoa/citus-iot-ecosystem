#!/bin/bash
set -e -x
OS_RELEASE=$(cat /etc/os-release)
AMAZON_AMI="Amazon Linux AMI"
CENTOS_AMI="CentOS Linux"
KUBE_AWS_VERSION="0.9.3-rc.2"

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
	yum install docker-engine python27 -y
	curl -O https://bootstrap.pypa.io/get-pip.py
	python27 get-pip.py	
	pip install awscli
	pip install --upgrade awscli
	systemctl enable docker.service
	systemctl start docker
	usermod -aG docker centos	
	setsebool httpd_can_network_connect on -P
	getsebool -a | grep httpd
	yum clean all
fi

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl    
curl -L https://github.com/coreos/kube-aws/releases/download/v${KUBE_AWS_VERSION}/kube-aws-linux-amd64.tar.gz -o /tmp/kube-aws-linux-amd64.tar.gz	
tar -zxvf /tmp/kube-aws-linux-amd64.tar.gz
mv linux-amd64/kube-aws /usr/local/bin
rm -f /tmp/kube-aws-linux-amd64.tar.gz

curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
cd /usr/share/citus-iot-ecosystem/
docker-compose up -d --force-recreate