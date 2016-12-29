# Citus™ IoT Ecosystem
This repository contains the Citus™ IoT Ecosystem bootstrap code which is used to provision an IoT Platform in Citus™ IoT Ecosystem using Docker Compose and AWS CloudFormation on AWS.

<img src="https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/fpt-software-logo.png" width="150" height="120" />

---

Description
===========
Citus™ IoT Ecosystem (https://apps.citus.io/) is a complete IoT solution which allows consumers start to develop, integrate their IoT products, visualize sensors data in a centralized platform and rapidly building their own sharing economy business model through the Citus™ IoT Platform. It also supports dedicated infrastructure and shared infrastructure deployment.

---

| No. | Micro-services  | Pulls  | Size |
|---|---|---|---|
| 1 | citus-iot-ecosystem-website | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-iot-ecosystem-website.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/citus-iot-ecosystem-website.svg)](https:/microbadger.com/images/cuongdd1/citus-iot-ecosystem-website) |
| 2 | citus-application-gateway | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-application-gateway.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/citus-application-gateway.svg)](https:/microbadger.com/images/cuongdd1/citus-application-gateway) |
| 3 | device-lifecycle-service | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/device-lifecycle-service.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/device-lifecycle-service.svg)](https:/microbadger.com/images/cuongdd1/device-lifecycle-service) |
| 4 | citus-elasticsearch-svc | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/elasticsearch-logstash-dynamodb-streams.svg?maxAge=2592000)]() | |
| 5 | sensor-remote-dashboard | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/sensor-remote-dashboard.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/sensor-remote-dashboard.svg)](https:/microbadger.com/images/cuongdd1/sensor-remote-dashboard)|
| 6 | citus-sensor-analytics | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-sensor-analytics.svg?maxAge=2592000)]() | |
| 7 | seniot-gateway | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/seniot-gateway.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/seniot-gateway.svg)](https:/microbadger.com/images/cuongdd1/seniot-gateway)|

---

![Citus IoT Architecture](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/citus-iot-ecosystem-system-architecture.png)

---

Features
========
**Web Portal**

GUI Web Portal that concentrates users, devices and applications together in one place with separated workspace for each consumer or tenant user. *This feature is still in reviewing for multi-tenant security concern using kubernetes.*
 + User Groups/Roles Management using Auth0 (https://auth0.com)
 + Secured application access by API Gateway through Key Authentication

---

**Application Platform**

Container-based application engine is designed for Microservices architecture which is easily to deploy on Docker-Compose, Docker Swarm or Kubernetes.
 + Publish or consume a Docker-based application
 + Continuous Delivery Support w/ Web Hook

---

**Manage Your Device**

Device lifecycle management service and device security process that help you enhancing the device provisioning and communication security of the AWS IoT as well as providing Over-The-Air software update for IoT devices.
 + Device Provisioning/Activation/Management
 + Device Software Update (OTA)

---

**Analytics**

Data analytics services that allow user consuming their IoT telemetry data into business instances such as anomaly detection, face detection or plate recognition. 
 + Statistical Anomaly Detection
 + Plate Recognition (3rd Party)
 + Face Detection (3rd Party)

---

**Monitoring & Control**

A set of featured Real-time Dashboards which is used to display, monitor and control your IoT devices directly using Web Portal.
 + Sensor Remote Dashboard
 + Citus Sensor Analytics

---

![Citus IoT Architecture](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/citus-iot-ecosystem-telemetry-flow.png)

---

Technologies
============
 + AWS Cloud Computing Basic Services (VPC, EC2, Route53, Elastic IP, IAM, S3)
 + AWS IoT (Hub, Registry, Rule Engine, ThingShadow) 
 + DynamoDB/Streamming
 + ElasticSearch/Logstash
 + Kong API Gateway
 + Docker/DockerHub
 + Docker-Compose
 + Docker Swarm
 
---

 + Kubernetes
 + Cassandra
 + Node-RED
 + NodeJS 
 + AngularJS
 + D3JS
 + Nginx
 + Python
 + Bash Shell

---

Prerequisites
=============
**I. AWS Environment**

(Supported Region: *ap-northeast-1* as default if using template)

1. Create [AWS IAM User](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html) and manage [Access Key](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)
2. Setup [DynamoDB Table](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/SampleData.CreateTables.html) with [Stream Enabled](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/StreamsConsole_DynamoDB.html)

	| Property | Value |
    |---|---|
	| Database name | your-dynamodb-table-name |
	| Table name | telemetry-sensors (default) |
	| Primary partition key | topic (String) |
	| Primary sort key | epoch (Number) |
	| Stream enabled | Yes (used for citus-elasticsearch-svc) |
	| View type | New and old images |
	
---

3. Create [AWS IoT Policy](http://docs.aws.amazon.com/iot/latest/developerguide/create-iot-policy.html) with at least iot:Publish, iot:Receive permissions for IoT devices sending and receiving MQTT topic messanges. Then named as *your-iot-thing-policy-name*

	```json
	{
	  "Version": "2012-10-17",
	  "Statement": [
	    {
	      "Effect": "Allow",
	      "Action": "iot:*",
	      "Resource": "*"
	    }
	  ]
	}
	```
	
---

4. Create [AWS IoT DynamoDB Rule](http://docs.aws.amazon.com/iot/latest/developerguide/iot-ddb-rule.html) to store telemetry sensor data into DynamoDB.
5. Create a [AWS S3 Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html) and named as *your-s3-certificate-bucket-name*
6. Launch a VPC with (YOUR-VPC-ID) and at least one public subnet (YOUR-VPC-SUBNET-ID)
7. Create a [Hosted Domain](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html) with YOUR-ROUTE53-DOMAIN-NAME and retrieve YOUR-ROUTE53-HOSTED-ZONE-ID

---

**II. Kubenetes Environment**

1. Setup [Container Cluster on AWS using kube-aws](https://coreos.com/kubernetes/docs/latest/kubernetes-on-aws.html)
2. Configure this cluster to use for Citus™ IoT Ecosystem (TBD)  

---

Deployments
===========

**I. Setup Development Environment**

1. Install Docker Engine and Docker Componse following this link https://docs.docker.com/compose/install/.
2. On Windows or Mac OSX Operating System: Launch Kitematic to start docker machine then run 
	
	```javascript
	$ eval "$(docker-machine env default)"
	```
	
---

3. On Ubuntu/RHEL/CentOS: execute shell command "$ docker-compose --version" to make sure it's running.
4. Checkout this repository **git clone https://github.com/cuongquay/citus-iot-ecosystem.git** or download the zipped package and extract to a folder.
5. Setup the shell environment variables which will be used by *docker-compose.yaml*
	
	```javascript
	export AWS_DEFAULT_REGION=ap-northeast-1
	export AWS_ACCESS_KEY_ID=your-s3-iot-hub-access-key-id
	export AWS_SECRET_ACCESS_KEY=your-s3-iot-hub-secret-key
	export AWS_IOT_CERT_BUCKET=your-s3-certificate-bucket-name
	export AWS_IOT_DEVICE_POLICY=your-iot-thing-policy-name
	export AWS_DYN_TABLE_NAME=your-dynamodb-table-name
	```
	
---

6. Start deploying by running this shell command 
	
	```javascript
	$ cd citus-iot-ecosystem-bootstrap
	$ docker-compose up -d --force-recreate
	```
	
7. Wait for cluster is initialied and stable. It takes about 5 minutes to pull docker images and initialize states. 
8. Access to the Web Portal at http://192.168.99.100/ on Windows/Mac OSX or http://127.0.0.1 on Ubuntu/RHEL/CentOS.
9. Terminate the system by running this shell command 

	```javascript
	$ docker-compose down
	```
---

**II. Run on AWS Cloud Formation Stack**

Download [Cloud Formation Stack Template](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/stack-template.json)

You need to change these parameters before applying the AWS CloudFormation template:

1. YOUR-ROUTE53-HOSTED-ZONE-ID
2. YOUR-AWS-EC2-SSH-KEYPAIR
3. YOUR-DNS-PREFIX-xxx1/2/3
4. YOUR-ROUTE53-DOMAIN-NAME
5. YOUR-VPC-SUBNET-ID
6. YOUR-VPC-ID

---

Update your AWS Credentials for your AWS IoT Hub by encoding the script below into into Base64 format 

```shell
#!/bin/bash
set -e -x 

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_ACCESS_KEY_ID=your-s3-iot-hub-access-key-id
export AWS_SECRET_ACCESS_KEY=your-s3-iot-hub-secret-key
export AWS_IOT_CERT_BUCKET=your-s3-certificate-bucket-name
export AWS_IOT_DEVICE_POLICY=your-iot-thing-policy-name
export AWS_DYN_TABLE_NAME=your-dynamodb-table-name

yum update -y
yum install git -y

git clone https://github.com/cuongquay/citus-iot-ecosystem-bootstrap.git /usr/share/citus-iot-ecosystem
cd /usr/share/citus-iot-ecosystem
chmod +x setup.sh
./setup.sh
```

---

Replace the **Base64UserData.Default** with the encoded value in the Cloud Formation template above.

```json
"Base64UserData": {
	"Type": "String",
	"Default": "IyEvYmluL2Jhc2gNCnNldCAtZSAteCANCg0KZXhwb3J0IEFXU19ERUZBVUxUX1JFR0lPTj1hcC1ub3J0aGVhc3QtMQ0KZXhwb3J0IEFXU19BQ0NFU1NfS0VZX0lEPQ0KZXhwb3J0IEFXU19TRUNSRVRfQUNDRVNTX0tFWT0NCmV4cG9ydCBBV1NfSU9UX0NFUlRfQlVDS0VUPQ0KDQp5dW0gdXBkYXRlIC15DQp5dW0gaW5zdGFsbCBnaXQgLXkNCg0KZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9jdW9uZ3F1YXkvY2l0dXMtaW90LWVjb3N5c3RlbS1ib290c3RyYXAuZ2l0IC91c3Ivc2hhcmUvY2l0dXMtaW90LWVjb3N5c3RlbQ0KY2QgL3Vzci9zaGFyZS9jaXR1cy1pb3QtZWNvc3lzdGVtDQpjaG1vZCAreCBzZXR1cC5zaA0KLi9zZXR1cC5zaA=="
}
```

---

You need to setup a corrected IoT environment with AWS IoT Policy, AWS IoT Rule, AWS DynamoDB with Stream Enabled to use with this platform. For more information, please contact us by email: cuongdd1@fsoft.com.vn!

---

Author
======
<div class="LI-profile-badge"  data-version="v1" data-size="medium" data-locale="en_US" data-type="vertical" data-theme="dark" data-vanity="cuongquay"><a class="LI-simple-link" href='https://vn.linkedin.com/in/cuongquay?trk=profile-badge'>DUONG Dinh Cuong</a></div>
