#!/bin/bash
set -e -x
OS_RELEASE=$(cat /etc/os-release)
AMAZON_AMI="Amazon Linux AMI"
CENTOS_AMI="CentOS Linux"

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
	yum install docker-engine -y
	systemctl enable docker.service
	systemctl start docker
	usermod -aG docker centos	
	setsebool httpd_can_network_connect on -P
	getsebool -a | grep httpd
	yum clean all
fi

curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
cd /usr/share/citus-iot-ecosystem/
docker-compose up -d --force-recreate