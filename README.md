# citus-iot-ecosystem
This repository contains the Citus™ IoT Ecosystem bootstrap code which is used to provision an IoT Platform in Citus™ IoT Ecosystem.

Description
===========
Citus™ IoT Ecosystem (https://apps.citus.io/) is a complete IoT solution which allows consumers start to develop, integrate their IoT products, visualize sensors data in a centralized platform and rapidly building their own sharing economy business model through the Citus™ IoT Platform.

[![Docker Pulls](https://img.shields.io/docker/pulls/cuongquay/citus-iot-ecosystem-website.svg?maxAge=2592000)]()

![Citus IoT](https://raw.githubusercontent.com/cuongquay/citus-iot-device-agents/master/docs/images/citus-iot-ecosystem.png)

Features
========
1. A Web Portal that concentrates users, devices and applications together in one place with separated workspace for each consumer.
- User Groups/Roles Management using Auth0 (https://auth0.com)
- Secured application access by API Gateway through Key Authentication
2. A container-based application engine is designed for Microservices architecture which is built on top of Kubernetes Google Container Platform.
- Publish or consume a Docker-based application
- Continuous Delivery Support w/ Web Hook
3. A device lifecycle management process which cover device provisioning and communication security and maintain the OTA software of IoT devices.
- Device Provisioning/Registration/Management
- Device Software Update (OTA)
4. A set of data analytics services that allow user consuming their IoT telemetry data into business instances such as anomaly detection, face detection or plate recognition. 
- Sensor Anomaly Detection
- Plate Recognition/Face Detection
5. A real time dashboard uses to display, monitor and control IoT devices.
- Sensor Remote Dashboard
- Citus Sensor Analytics

Deployments
===========

**Installation**

1. Install Docker Engine and Docker Componse following this link https://docs.docker.com/compose/install/.
2. On Windows or Mac OSX Operating System: Launch Kitematic to start docker machine then run "$ eval '$(docker-machine env default)'" in your terminal.
3. On Ubuntu/RHEL/CentOS: execute shell command "$ docker-compose --version" to make sure it's running.
4. Checkout this repository **git clone https://github.com/cuongquay/citus-iot-ecosystem-bootstrap.git** or zipped package.
5. Start deploying by running this shell command "$ cd citus-iot-ecosystem && docker-compose up -d --force-recreate"
6. To terminate the system, run this shell command "$ docker-compose down"

<div class="LI-profile-badge"  data-version="v1" data-size="medium" data-locale="en_US" data-type="vertical" data-theme="dark" data-vanity="cuongquay"><a class="LI-simple-link" href='https://vn.linkedin.com/in/cuongquay?trk=profile-badge'>DUONG Dinh Cuong</a></div>
