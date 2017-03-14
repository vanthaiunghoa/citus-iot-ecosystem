# Citus™ IoT Ecosystem
This document introduce about the Citus™ IoT Ecosystem with bootstrap instructions which is used to provision the infrasutructure and applications for Citus™ IoT Ecosystem using Docker Compose and AWS CloudFormation on AWS.

<br><img src="https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/fpt-software-logo.png" width="150" height="120" />

*DUONG Dinh Cuong*
CLOUD INNOVATION

---

Description
===========
Citus™ IoT Ecosystem (https://apps.citus.io/) is a complete IoT solution which allows consumers start to develop, integrate their IoT products, visualize sensors data in a centralized platform and rapidly building their own sharing economy business model through Citus™ IoT Platform. It also supports to deploy on a dedicated infrastructure or a shared infrastructure.

---

| No. | Primary Service  | Hits  | Image Info |
|---|---|---|---|
| 1 | citus-iot-ecosystem-website | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-iot-ecosystem-website.svg?maxAge=2592000)]() | **`136 MB|7 layers`**|
| 2 | citus-application-gateway | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-application-gateway.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/citus-application-gateway.svg)](https://images.microbadger.com/badges/image/cuongdd1/citus-application-gateway.svg) |
| 3 | device-lifecycle-service | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/device-lifecycle-service.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/device-lifecycle-service.svg)](https://images.microbadger.com/badges/image/cuongdd1/device-lifecycle-service.svg) |
| 4 | citus-elasticsearch-svc | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/elasticsearch-logstash-dynamodb-streams.svg?maxAge=2592000)]() | **`370 MB|27 layers`**|
| 5 | sensor-remote-dashboard | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/sensor-remote-dashboard.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/sensor-remote-dashboard.svg)](https://images.microbadger.com/badges/image/cuongdd1/sensor-remote-dashboard.svg)|
| 6 | citus-sensor-analytics | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-sensor-analytics.svg?maxAge=2592000)]() | **`138 MB|11 layers`**|
| 7 | seniot-gateway | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/seniot-gateway.svg?maxAge=2592000)]() | [![image info](https://images.microbadger.com/badges/image/cuongdd1/seniot-gateway.svg)](https://images.microbadger.com/badges/image/cuongdd1/seniot-gateway.svg)|

---

Features
========

---

**Centralized Web Portal**

GUI Web Portal that concentrates users, devices and applications together in one place with separated workspace for each consumer or tenant user. *This feature is still in reviewing for multi-tenant security concern using kubernetes.*
 + User Identity/User Groups/Roles Management using Auth0 (https://auth0.com) as an external service.
 + Protect device/application accesses by API Gateway using API Secret Key Authentication feature.

---

**Application Platform**

Container-based application engine is designed for Microservices architecture which is easily to deploy on Docker-Compose, Docker Swarm or Kubernetes.
 + Publish or consume Docker-based applications across users.
 + Continuous Delivery Support w/ Docker Hub using Web Hook.

---

**Manage Your Device**

Device Lifecycle Management service and device security process that help you enhancing the device provisioning and communication security of the AWS IoT as well as providing Over-The-Air software update for IoT devices.
 + Device Provisioning/Activation/Management.
 + Device Software Update (OTA) with CI/CD.

---

**Data Analytics**

A set of featured (default) services that allow user consuming their IoT telemetry data into business instances such as anomaly detection, face detection or plate recognition. 
 + Statistical Anomaly Detection
 + Plate Recognition (3rd Party)
 + Face Detection (3rd Party)

---

**Monitoring & Control**

A set of featured Real-time Dashboards which is used to display, monitor and control your IoT devices directly using Web Portal.
 + Sensor Remote Dashboard
 + Citus Sensor Analytics

---

Architecture
============

---

![Citus IoT Architecture](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/citus-iot-ecosystem-system-architecture.png)

---

System Diagram
============

---

![Citus IoT Architecture](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/citus-iot-ecosystem-system-diagram.png)

---

Product Backlog
============

---


| No. | User Story Name |
|-----|------|
| 1 | As a User, I want to declare my device in the Citus™ IoT Platform so that I can activate it later on |
| 2 | As a User, I want my device be able to connect to Citus™ IoT Platform so that I can store  data in the cloud |
| 3 | As a User, I want to update my software over-the-air when there is a new upgraded version requested |
| 4 | As a Developer, I want to request my application with the Citus™ IoT Platform so that Administrator can review and approve it|
| 5 | As an Administrator, I want to approve the pending requested applications so that Developers can deploy it into the system|
| 6 | As a Developer, I want to deployed the approved applications so that I can test and share it to the other users|
| 7 | As a User, I want to ingest my telemetry data in the cloud to be view or analyse by the ecosystem's applications |
| 8 | As a User, I want to use a published application from others so that I can speed up my business|

---

![US-0001](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/backlog/US-0001.png)

---

![US-0002](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/backlog/US-0002.png)

---

![US-0003](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/backlog/US-0003.png)

---

![US-0004/5/6](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/backlog/US-0004.png)

---

![US-0007](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/backlog/US-0007.png)

------

![US-0008](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/backlog/US-0008.png)

---

Technology
============

---

**Platforms** 
 + AWS Cloud Computing Basic Services (VPC, EC2, Route53, Elastic IP, IAM, S3)
 + AWS IoT (Hub, Registry, Rule Engine, ThingShadow) 
 + Cassandra/DynamoDB w/Streamming
 + ElasticSearch/Logstash
 + Kong API Gateway
 + Docker/DockerHub
 + Docker-Compose
 + Docker Swarm
 + Kubernetes
 + Node-RED
 
---

**Languages** 
 
 + HTML5/CSS3
 + NodeJS 
 + AngularJS
 + D3JS
 + Nginx
 + Python
 + Bash Shell

---

Deployment
===========

---

<h2>Prerequisites</h2>

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

4. Create [AWS IoT DynamoDB Rule](http://docs.aws.amazon.com/iot/latest/developerguide/iot-ddb-rule.html) to forward telemetry sensor topic data into DynamoDB.
5. Create a [AWS S3 Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html) and named as *your-s3-certificate-bucket-name* to store temporary device certificates.
6. Create a VPC with (YOUR-VPC-ID) and at least one public subnet (YOUR-VPC-SUBNET-ID) to host your system.
7. Create a [Hosted Domain](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html) with YOUR-ROUTE53-DOMAIN-NAME and retrieve YOUR-ROUTE53-HOSTED-ZONE-ID

---

**II. Kubenetes Environment**

1. Setup [Container Cluster on AWS using kube-aws](https://coreos.com/kubernetes/docs/latest/kubernetes-on-aws.html)
2. Configure this cluster to use for Citus™ IoT Ecosystem (TBD)  

---

<h2>Step By Step</h2>

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

You need to setup a corrected AWS IoT environment for AWS IoT Policy, AWS IoT Rule, AWS DynamoDB (Stream Enabled) to use with this platform. For more information, please contact us by email: cuongdd1@fsoft.com.vn!

---

Author
======
<div class="LI-profile-badge"  data-version="v1" data-size="medium" data-locale="en_US" data-type="vertical" data-theme="dark" data-vanity="cuongquay"><a class="LI-simple-link" href='https://vn.linkedin.com/in/cuongquay?trk=profile-badge'>DUONG Dinh Cuong</a></div>
