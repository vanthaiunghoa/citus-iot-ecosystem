#! /bin/bash

cat > /tmp/citus-elasticsearch-svc.yaml <<EOF
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
      deployment.kubernetes.io/revision: "1"
  name: citus-elasticsearch-svc
  namespace: default
spec:
  replicas: 1
  selector:
      matchLabels:
        app: citus-elasticsearch-svc
        version: "latest"
  strategy:
      rollingUpdate:
        maxSurge: 1
        maxUnavailable: 1
      type: RollingUpdate
  template:
    metadata:
      name: citus-elasticsearch-svc
      labels:
        app: citus-elasticsearch-svc
        version: "latest"
    spec:
      containers:
      - name: citus-elasticsearch-svc
        image: cuongdd1/elasticsearch-logstash-dynamodb-streams:latest
        imagePullPolicy: IfNotPresent
        securityContext:
          privileged: false
        ports:
        - containerPort: 9200
        env:
        - name: AWS_DEFAULT_REGION
          value: ${AWS_DEFAULT_REGION}
        - name: AWS_ACCESS_KEY_ID
          value: ${AWS_ACCESS_KEY_ID}
        - name: AWS_SECRET_ACCESS_KEY
          value: ${AWS_SECRET_ACCESS_KEY}
        - name: AWS_SENSORS_TABLE_NAME
          value: ${AWS_SENSORS_TABLE_NAME}
        - name: AWS_SENSORS_STREAM_VIEW_TYPE
          value: ${AWS_SENSORS_STREAM_VIEW_TYPE}
EOF

kubectl create -f /tmp/citus-elasticsearch-svc.yaml --kubeconfig=kubeconfig
rm -f /tmp/citus-elasticsearch-svc.yaml