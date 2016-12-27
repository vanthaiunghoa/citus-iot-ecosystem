# Citus™ IoT Ecosystem
This repository contains the Citus™ IoT Ecosystem bootstrap code which is used to provision an IoT Platform in Citus™ IoT Ecosystem using Docker Compose or AWS CloudFormation.

<img src="https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem-bootstrap/master/pictures/fpt-software-logo.png" width="150" height="120" />

Description
===========
Citus™ IoT Ecosystem (https://apps.citus.io/) is a complete IoT solution which allows consumers start to develop, integrate their IoT products, visualize sensors data in a centralized platform and rapidly building their own sharing economy business model through the Citus™ IoT Platform.

[![Docker Pulls](https://img.shields.io/docker/pulls/cuongdd1/citus-iot-ecosystem-website.svg?maxAge=2592000)]()

![Citus IoT Architecture](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem-bootstrap/master/pictures/citus-iot-ecosystem-system-architecture.png)

Features
========
1. A Web Portal that concentrates users, devices and applications together in one place with separated workspace for each consumer or tenant space.
 + User Groups/Roles Management using Auth0 (https://auth0.com)
 + Secured application access by API Gateway through Key Authentication
2. A container-based application engine is designed for Microservices architecture which is built on top of Kubernetes Google Container Platform.
 + Publish or consume a Docker-based application
 + Continuous Delivery Support w/ Web Hook
3. A device lifecycle management process which cover device provisioning and communication security and maintain the OTA software of IoT devices.
 + Device Provisioning/Registration/Management
 + Device Software Update (OTA)
4. A set of data analytics services that allow user consuming their IoT telemetry data into business instances such as anomaly detection, face detection or plate recognition. 
 + Statistical Anomaly Detection
 + Plate Recognition (3rd Party)
 + Face Detection (3rd Party)
5. A real time dashboard uses to display, monitor and control IoT devices.
 + Sensor Remote Dashboard
 + Citus Sensor Analytics

![Citus IoT Architecture](https://raw.githubusercontent.com/cuongquay/citus-iot-ecosystem-bootstrap/master/pictures/citus-iot-ecosystem-telemetry-flow.png)

Technologies
============
 + AWS Cloud Computing Services (EC2, Route53, EIP, CloudFormation)
 + AWS IoT (Hub, Registry, Rule Engine, ThingShadow) 
 + DynamoDB/Streamming
 + ElasticSearch/Logstash
 + Kong API Gateway
 + Docker/DockerHub
 + Docker-Compose
 + Kubernetes
 + Cassandra
 + Node-RED
 + NodeJS 
 + AngularJS
 + D3JS
 + Nginx
 + Python
 + Bash Shell

Deployments
===========

**Local Deployment**

1. Install Docker Engine and Docker Componse following this link https://docs.docker.com/compose/install/.
2. On Windows or Mac OSX Operating System: Launch Kitematic to start docker machine then run "$ eval '$(docker-machine env default)'" in your PC terminal.
3. On Ubuntu/RHEL/CentOS: execute shell command "$ docker-compose --version" to make sure it's running.
4. Checkout this repository **git clone https://github.com/cuongquay/citus-iot-ecosystem-bootstrap.git** or download the zipped package and extract to a folder.
5. Setup the shell environment variables

```javascript
export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_ACCESS_KEY_ID=your-s3-iot-hub-access-key-id
export AWS_SECRET_ACCESS_KEY=your-s3-iot-hub-secret-key
export AWS_IOT_CERT_BUCKET=your-s3-certificate-bucket-name
export AWS_IOT_DEVICE_POLICY=your-iot-thing-policy-name
export AWS_DYN_TABLE_NAME=your-dynamodb-table-name
```

6. Start deploying by running this shell command "$ cd citus-iot-ecosystem && docker-compose up -d --force-recreate"
7. Wait for cluster is initialied and stable. It takes about 5 minutes to initialize Cassandra Database and API Gateway. 
8. Accessing the Web Portal at http://192.168.99.100/ on Windows/Mac OSX or http://127.0.0.1 on Ubuntu/RHEL/CentOS.
9. To terminate the system, run this shell command "$ docker-compose down"

**AWS Cloud Formation**

```json
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Description": "Citus IoT Ecosystem (Prototype)",
  "Parameters": {
	"KeyName": {
		"Type": "String",
		"MinLength": "1",
		"MaxLength": "64",
		"AllowedPattern": "[-_ a-zA-Z0-9]*",
		"ConstraintDescription": "can contain only alphanumeric characters, spaces, dashes and underscores.",
		"Default": "YOUR-AWS-EC2-SSH-KEYPAIR"
	},
	"Version": {
		"Type": "String",
		"Default": "Prototype",
		"AllowedValues": ["Prototype", "Stagging", "Production"]
	},
	"InstanceType": {
		"Type": "String",
		"Default": "t2.medium",
		"AllowedValues": ["t2.medium", "c1.xlarge"],
		"ConstraintDescription": "must be a valid EC2 instance type."
	},
	"ImageName": {
		"Type": "String",
		"Default": "CentOS-7.x64-HVM",
		"AllowedPattern": "[-_. a-zA-Z0-9]*",
		"AllowedValues": ["CentOS-7.x64-HVM", "Amazon-RHEL.x64-HVM"],
		"ConstraintDescription": "can contain only alphanumeric characters, spaces, dashes, dots and underscores."
	},
	"Base64UserData": {
		"Type": "String",
		"Default": "IyEvYmluL2Jhc2gNCnNldCAtZSAteCANCg0KZXhwb3J0IEFXU19ERUZBVUxUX1JFR0lPTj1hcC1ub3J0aGVhc3QtMQ0KZXhwb3J0IEFXU19BQ0NFU1NfS0VZX0lEPQ0KZXhwb3J0IEFXU19TRUNSRVRfQUNDRVNTX0tFWT0NCmV4cG9ydCBBV1NfSU9UX0NFUlRfQlVDS0VUPQ0KDQp5dW0gdXBkYXRlIC15DQp5dW0gaW5zdGFsbCBnaXQgLXkNCg0KZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9jdW9uZ3F1YXkvY2l0dXMtaW90LWVjb3N5c3RlbS1ib290c3RyYXAuZ2l0IC91c3Ivc2hhcmUvY2l0dXMtaW90LWVjb3N5c3RlbQ0KY2QgL3Vzci9zaGFyZS9jaXR1cy1pb3QtZWNvc3lzdGVtDQpjaG1vZCAreCBzZXR1cC5zaA0KLi9zZXR1cC5zaA=="
	}
  },
  "Mappings": {	
	"AWSImageName2Type": {
		"CentOS-7.x64-HVM": {
			"Type": "CentOS"
		},
		"Amazon-RHEL.x64-HVM": {
			"Type": "Amazon"
		}
	},
	"AWSRegionImageType2AMI": {
		"ap-northeast-1": {
			"CentOS": "ami-eec1c380",
			"Amazon": "ami-0c11b26d"
		},
		"ap-southeast-1": {
			"CentOS": "ami-f068a193",
			"Amazon": "ami-b953f2da"
		},
		"ap-southeast-2": {
			"CentOS": "ami-fedafc9d",
			"Amazon": "ami-db704cb8"
		}
	},
	"Version2DNS": {
		"Prototype": {
			"Prefix": "YOUR-DNS-PREFIX-xxx1"
		},
		"Stagging": {
			"Prefix": "YOUR-DNS-PREFIX-xxx2"
		},
		"Production": {
			"Prefix": "YOUR-DNS-PREFIX-xxx3"
		}
	}
  },
  "Resources": {
    "AlarmControllerRecover": {
      "Properties": {
        "AlarmActions": [
          {
            "Fn::Join": [
              "",
              [
                "arn:aws:automate:",
                {
                  "Ref": "AWS::Region"
                },
                ":ec2:recover"
              ]
            ]
          }
        ],
        "AlarmDescription": "Trigger a recovery when system check fails for 5 consecutive minutes.",
        "ComparisonOperator": "GreaterThanThreshold",
        "Dimensions": [
          {
            "Name": "InstanceId",
            "Value": {
              "Ref": "InstanceController"
            }
          }
        ],
        "EvaluationPeriods": "5",
        "MetricName": "StatusCheckFailed_System",
        "Namespace": "AWS/EC2",
        "Period": "60",
        "Statistic": "Minimum",
        "Threshold": "0"
      },
      "Type": "AWS::CloudWatch::Alarm",
      "Metadata": {
        "AWS::CloudFormation::Designer": {
          "id": "43f3bc04-9997-4a51-b25d-318f482dc846"
        }
      }
    },
    "EIPController": {
      "Properties": {
        "Domain": "vpc",
        "InstanceId": {
          "Ref": "InstanceController"
        }
      },
      "Type": "AWS::EC2::EIP",
      "Metadata": {
        "AWS::CloudFormation::Designer": {
          "id": "d67105b0-4c26-4009-ba61-a938d556f99c"
        }
      }
    },
    "ExternalDNS": {
      "Type": "AWS::Route53::RecordSet",
      "Properties": {
        "HostedZoneId": "/hostedzone/YOUR-ROUTE53-HOSTED-ZONE-ID",
        "Name": {
        	"Fn::Join": ["", [
				{
					"Fn::FindInMap": ["Version2DNS", {
							"Ref": "Version"
						}, "Prefix"]
					
				}, ".YOUR-ROUTE53-DOMAIN-NAME"]
			]
        },
        "TTL": 300,
        "ResourceRecords": [
          {
            "Ref": "EIPController"
          }
        ],
        "Type": "A"
      },
      "Metadata": {
        "AWS::CloudFormation::Designer": {
          "id": "5119bdb4-410f-4c5a-b4dd-eb1134ccfc68"
        }
      }
    },
    "IAMInstanceProfileController": {
      "Properties": {
        "Path": "/",
        "Roles": [
          {
            "Ref": "IAMRoleController"
          }
        ]
      },
      "Type": "AWS::IAM::InstanceProfile",
      "Metadata": {
        "AWS::CloudFormation::Designer": {
          "id": "65d25548-1ebb-4594-b095-4f4bed4135e0"
        }
      }
    },
    "IAMRoleController": {
      "Properties": {
        "AssumeRolePolicyDocument": {
          "Statement": [
            {
              "Action": [
                "sts:AssumeRole"
              ],
              "Effect": "Allow",
              "Principal": {
                "Service": [
                  "ec2.amazonaws.com"
                ]
              }
            }
          ],
          "Version": "2012-10-17"
        },
        "Path": "/",
        "Policies": [
          {
            "PolicyDocument": {
              "Statement": [
                {
                  "Action": "ec2:*",
                  "Effect": "Allow",
                  "Resource": "*"
                }
              ],
              "Version": "2012-10-17"
            },
            "PolicyName": "root"
          }
        ]
      },
      "Type": "AWS::IAM::Role",
      "Metadata": {
        "AWS::CloudFormation::Designer": {
          "id": "43805f86-cf98-43b5-908d-6251c6be8e80"
        }
      }
    },
    "InstanceController": {
      "Properties": {
        "AvailabilityZone": "ap-northeast-1a",
        "BlockDeviceMappings": [
          {
            "DeviceName": "/dev/xvda",
            "Ebs": {
              "VolumeSize": "10",
              "VolumeType": "gp2"
            }
          }
        ],
        "IamInstanceProfile": {
          "Ref": "IAMInstanceProfileController"
        },
        "ImageId": {
			"Fn::FindInMap": ["AWSRegionImageType2AMI", {
				"Ref": "AWS::Region"
			}, {
				"Fn::FindInMap": ["AWSImageName2Type", {
						"Ref": "ImageName"
					}, "Type"
				]
			}]
		},
		"InstanceType": {
			"Ref": "InstanceType"
		},
        "KeyName": {
			"Ref": "KeyName"
		},
        "NetworkInterfaces": [
          {
            "AssociatePublicIpAddress": false,
            "DeleteOnTermination": true,
            "DeviceIndex": "0",
            "GroupSet": [
              {
                "Ref": "SecurityGroupController"
              }
            ],
            "SubnetId": "YOUR-VPC-SUBNET-ID"
          }
        ],
        "Tags": [
          {
            "Key": "Group",
            "Value": "CLOUD-DEMO-PACKS"
          },
          {
            "Key": "Name",
            "Value": "citus-iot-ecosystem-prototype"
          }
        ],
        "UserData": {
        	"Ref": "Base64UserData"
        }
      },
      "Type": "AWS::EC2::Instance",
      "Metadata": {
        "AWS::CloudFormation::Designer": {
          "id": "69f312a8-73f3-4ed8-b231-d1762771a177"
        }
      }
    },
    "SecurityGroupController": {
      "Properties": {
        "GroupDescription": {
          "Ref": "AWS::StackName"
        },
        "SecurityGroupEgress": [
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": -1,
            "IpProtocol": "icmp",
            "ToPort": -1
          },
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": 0,
            "IpProtocol": "tcp",
            "ToPort": 65535
          },
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": 0,
            "IpProtocol": "udp",
            "ToPort": 65535
          }
        ],
        "SecurityGroupIngress": [
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": -1,
            "IpProtocol": "icmp",
            "ToPort": -1
          },
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": 22,
            "IpProtocol": "tcp",
            "ToPort": 22
          },
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": 80,
            "IpProtocol": "tcp",
            "ToPort": 80
          },
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": 443,
            "IpProtocol": "tcp",
            "ToPort": 443
          }
        ],
        "Tags": [
          {
            "Key": "Group",
            "Value": "CLOUD-DEMO-PACKS"
          }
        ],
        "VpcId": "YOUR-VPC-ID"
      },
      "Type": "AWS::EC2::SecurityGroup",
      "Metadata": {
        "AWS::CloudFormation::Designer": {
          "id": "9ae9028e-e6f5-4a69-9794-42242da7a063"
        }
      }
    }
  }
}
```

You need to change these parameters before applying the AWS CloudFormation template:

1. YOUR-ROUTE53-HOSTED-ZONE-ID
2. YOUR-AWS-EC2-SSH-KEYPAIR
3. YOUR-DNS-PREFIX-xxx1/2/3
4. YOUR-ROUTE53-DOMAIN-NAME
5. YOUR-VPC-SUBNET-ID
6. YOUR-VPC-ID

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

Replace the **Base64UserData.Default** with the encoded value in the Cloud Formation template above.

```json
"Base64UserData": {
	"Type": "String",
	"Default": "IyEvYmluL2Jhc2gNCnNldCAtZSAteCANCg0KZXhwb3J0IEFXU19ERUZBVUxUX1JFR0lPTj1hcC1ub3J0aGVhc3QtMQ0KZXhwb3J0IEFXU19BQ0NFU1NfS0VZX0lEPQ0KZXhwb3J0IEFXU19TRUNSRVRfQUNDRVNTX0tFWT0NCmV4cG9ydCBBV1NfSU9UX0NFUlRfQlVDS0VUPQ0KDQp5dW0gdXBkYXRlIC15DQp5dW0gaW5zdGFsbCBnaXQgLXkNCg0KZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9jdW9uZ3F1YXkvY2l0dXMtaW90LWVjb3N5c3RlbS1ib290c3RyYXAuZ2l0IC91c3Ivc2hhcmUvY2l0dXMtaW90LWVjb3N5c3RlbQ0KY2QgL3Vzci9zaGFyZS9jaXR1cy1pb3QtZWNvc3lzdGVtDQpjaG1vZCAreCBzZXR1cC5zaA0KLi9zZXR1cC5zaA=="
}
```

You need to setup a corrected IoT environment with AWS IoT Policy, AWS IoT Rule, AWS DynamoDB with Stream Enabled to use with this platform. For more information, please contact us by email: cuongdd1@fsoft.com.vn!

Author
======
<div class="LI-profile-badge"  data-version="v1" data-size="medium" data-locale="en_US" data-type="vertical" data-theme="dark" data-vanity="cuongquay"><a class="LI-simple-link" href='https://vn.linkedin.com/in/cuongquay?trk=profile-badge'>DUONG Dinh Cuong</a></div>
