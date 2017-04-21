#! /bin/bash

cat > /tmp/sensor-analytics.yaml <<EOF
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
      deployment.kubernetes.io/revision: "1"
  name: sensor-analytics
  namespace: default
spec:
  replicas: 1
  selector:
      matchLabels:
        app: sensor-analytics
        version: "1.0.2"
  strategy:
      rollingUpdate:
        maxSurge: 1
        maxUnavailable: 1
      type: RollingUpdate
  template:
    metadata:
      name: sensor-analytics
      labels:
        app: sensor-analytics
        version: "1.0.2"
    spec:
      containers:
      - name: sensor-analytics
        image: cuongdd1/citus-sensor-analytics:1.0.2
        imagePullPolicy: IfNotPresent
        securityContext:
          privileged: false
        ports:
        - containerPort: 1880
        env:
        - name: AWS_DEFAULT_REGION
          value: ${AWS_DEFAULT_REGION}
        - name: AWS_ACCESS_KEY_ID
          value: ${AWS_ACCESS_KEY_ID}
        - name: AWS_SECRET_ACCESS_KEY
          value: ${AWS_SECRET_ACCESS_KEY}
        - name: ELASTIC_SEARCH_SERVICE
          value: ${ELASTIC_SEARCH_SERVICE}
        - name: DEVICE_LIFECYCLE_SERVICE
          value: ${DEVICE_LIFECYCLE_SERVICE}
        resources:
          requests:
            cpu: 100m
            memory: 256Mi
EOF

kubectl create -f /tmp/sensor-analytics.yaml --kubeconfig=kubeconfig
rm -f /tmp/sensor-analytics.yaml