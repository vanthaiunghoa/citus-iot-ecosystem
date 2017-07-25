#!/bin/bash
set -e -x
OS_RELEASE=$(cat /etc/os-release)
AMAZON_AMI="Amazon Linux AMI"
CENTOS_AMI="CentOS Linux"
KUBE_AWS_VERSION="v0.9.4-rc.2"
KUBERNETES_VERSION="v1.5.0"

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
curl -L https://github.com/coreos/kube-aws/releases/download/${KUBE_AWS_VERSION}/kube-aws-linux-amd64.tar.gz -o /tmp/kube-aws-linux-amd64.tar.gz	
tar -zxvf /tmp/kube-aws-linux-amd64.tar.gz
mv linux-amd64/kube-aws /usr/bin
rm -f /tmp/kube-aws-linux-amd64.tar.gz
rm -rf linux-amd64/

cd /usr/share/citus-iot-ecosystem/production
rm -rf cluster.yaml credentials/ userdata/ kubeconfig
kube-aws init \
	--cluster-name=citus-iot-kubernetes \
	--external-dns-name=cluster.citus.io \
	--region=ap-northeast-1 \
	--availability-zone=ap-northeast-1a \
	--key-name=CLOUD-Bastion-Development-KeyPair \
	--kms-key-arn="arn:aws:kms:ap-northeast-1:217793734226:key/e3bfb84f-cf43-4468-99f7-b9cef20dc2ea"
kube-aws render && kube-aws validate --s3-uri s3://apps.citus.io/stacks
kube-aws up --s3-uri s3://apps.citus.io/stacks

cd /usr/share/citus-iot-ecosystem/production
docker-compose up -d --force-recreate