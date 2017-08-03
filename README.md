# Citus™ IoT Ecosystem
This document introduce about the Citus™ IoT Ecosystem with bootstrap instructions which is used to provision the infrasutructure and applications for Citus™ IoT Ecosystem using Docker Compose, Kubernetes and AWS CloudFormation on AWS.

<br><img src="https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem/master/pictures/fpt-software-logo.png" width="150" height="120" />

*DUONG Dinh Cuong*
CLOUD INNOVATION

---

Description
===========
Citus™ IoT Ecosystem (http://v1.apps.citus.io/) is a complete IoT solution which allows consumers start to develop, integrate their IoT products, visualize sensors data in a centralized platform and rapidly building their own sharing economy business model through Citus™ IoT Platform. It also supports to deploy on a dedicated infrastructure or a shared infrastructure.

---

| No. | Primary Service  | Hits  | Image Info |
|---|---|---|---|
| 1 | citus-iot-ecosystem-website | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-iot-ecosystem-website.svg?maxAge=2592000)]() | **`136 MB|7 layers`**|
| 2 | citus-application-gateway | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-application-gateway.svg?maxAge=2592000)]() | **`35 MB|23 layers`**|
| 3 | citus-cassandra-rest (API) | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-cassandra-rest.svg?maxAge=2592000)]() | **`110 MB|21 layers`**|
| 4 | citus-elasticsearch-service | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/elasticsearch-logstash-dynamodb-streams.svg?maxAge=2592000)]() | **`370 MB|27 layers`**|
| 5 | device-management-service | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/device-management-service.svg?maxAge=2592000)]() | **`31 MB|10 layers`**|
| 6 | sensor-remote-dashboard | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/sensor-remote-dashboard.svg?maxAge=2592000)]() | **`47 MB|11 layers`**|
| 7 | citus-sensor-analytics | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-sensor-analytics.svg?maxAge=2592000)]() | **`138 MB|11 layers`**|
| 8 | citus-recognition-service | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-sensor-analytics.svg?maxAge=2592000)]() | **`40 MB|7 layers`**|
| 9 | seniot-gateway (Node-RED) | [![Pulls](https://img.shields.io/docker/pulls/cuongdd1/seniot-gateway.svg?maxAge=2592000)]() | **`137 MB|13 layers`**|

---

Features
========

---

**Centralized Web Portal**

GUI Web Portal that concentrates users, devices and applications together in one place with separated workspace for each consumer or tenant user. *This feature is still in reviewing for multi-tenant security concern using kubernetes.*
 + User Identity/User Groups/Roles Management using Auth0 (https://auth0.com) as an external service.
 + Protect application accesses through API Gateway using API Key Authentication and RBAC.
 + Per-device key authentication for device installation process.

---

**Application Platform**

Container-based application engine is designed for Microservices architecture which is easily to deploy on Docker-Compose, Docker Swarm or Kubernetes.
 + Publish or consume Docker-based applications across users.
 + Continuous Delivery Support w/ Docker Hub using Web Hook.

---

**Manage Your Device**

Device Lifecycle Management service and device security process that help you enhancing the device provisioning and communication security of the AWS IoT as well as providing Over-The-Air software update for IoT devices.
 + Device provisioning/activation/state management.
 + Device's event stream to service API linker.
 + Device accessibility mode configuration.
 + Device Software Update (OTA).
 
---

**Shared Services**

A set of featured (default) services that allow user consuming their IoT telemetry data into business instances such as anomaly detection, face detection or plate recognition through RESTful API.
 + Device Management Service (Device Lifecycle and State)
 + Sensor Analytics Service (Statistical & Anomaly Detection)
 + Plate Recognition (ANPR OpenFPT)
 + Face Detection (AWS Rekognition)
 + Gateway Management (Docker-based)

---

**Standard Applications**

A set of featured applications which is used to display, monitor and control your IoT devices directly using a centralized web portal.
 + Sensor Dashboard
 + Sensor Analytics
 + Recognition Toolkit
 + File Manager

---

**Simulation Toolbox**

We exposed Seniot™ Gateway (Node-RED) solution with alternative versions such as Sensor Simulator for developers to develop/test their whole system without using a real connected hardware.
 + Seniot Gateway Latest (Original Node-RED) 
 + Sensor Simulator (Node-RED with AWS IoT)
 + Lennox Casestudy (Node-RED with Azure IoT)

**Embedded Hardware**

A preconfigured Raspbian OS that simulates your Raspberry Pi hardware for Windows. (user:**pi**, password:**cloud2016**)
+ [Raspbian for Windows](https://s3-ap-northeast-1.amazonaws.com/apps.citus.io/public/qemu-raspbian.zip)

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
| 1 | As a User, I want to declare my device in the Citus™ IoT Platform so that I can activate it later on.|
| 2 | As a User, I want my device be able to connect to Citus™ IoT Platform so that I can store  data in the cloud.|
| 3 | As a User, I want to update my software over-the-air when there is a new upgraded version requested.|
| 4 | As a Developer, I want to request my application with the Citus™ IoT Platform so that Administrator can review and approve my app before deploying.|
| 5 | As an Administrator, I want to approve the pending requested applications so that Developers can deploy my application into the Citus™ IoT Platform.|
---
| No. | User Story Name |
|-----|------|
| 6 | As a Developer, I want to deployed the approved applications so that I can test and share it to the other users.|
| 7 | As a User, I want to ingest my telemetry data in the cloud to be view or analyse by the ecosystem's applications.|
| 8 | As a User, I want to use a published application from others so that I can speed up my business.|

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
 + AWS IoT and BigData (Hub, Registry, Rule Engine, ThingShadow, Lambda, ML) 
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
 + Javascript/D3JS 
 + AngularJS 
 + NodeJS
 + Python
 + Linux/Shell

---

**DevOps Tools** 
 
 + Source Control (GitHub/Bitbucket)
 + Continuous Integration (Bitbucket Pipline)
 + Continuous Delivery (Docker Hub Repository/WebHook)
 + Orchestration (Kubernetes/Docker Compose/AWS Cloud Formation)
 
---

Deployment
===========

See [Deployment Guideline](https://insight.fsoft.com.vn/conf/display/FSBCLOUD/Citus+IoT+Ecosystem)

---

Author
======
<div class="LI-profile-badge"  data-version="v1" data-size="medium" data-locale="en_US" data-type="vertical" data-theme="dark" data-vanity="cuongquay"><a class="LI-simple-link" href='https://vn.linkedin.com/in/cuongquay?trk=profile-badge'>DUONG Dinh Cuong</a></div>
