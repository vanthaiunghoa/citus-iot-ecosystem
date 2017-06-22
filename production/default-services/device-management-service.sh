#! /bin/bash

cat > /tmp/device-management-service.yaml <<EOF
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
      deployment.kubernetes.io/revision: "1"
  name: device-management-service
  namespace: default
spec:
  replicas: 1
  selector:
      matchLabels:
        app: device-management-service
        version: "latest"
  strategy:
      rollingUpdate:
        maxSurge: 1
        maxUnavailable: 1
      type: RollingUpdate
  template:
    metadata:
      name: device-management-service
      labels:
        app: device-management-service
        version: "latest"
    spec:
      containers:
      - name: device-management-service
        image: cuongdd1/device-management-service:latest
        imagePullPolicy: IfNotPresent
        securityContext:
          privileged: false
        ports:
        - containerPort: 3000
        env:
        - name: AWS_DEFAULT_REGION
          value: ${AWS_DEFAULT_REGION}
        - name: AWS_ACCESS_KEY_ID
          value: ${AWS_ACCESS_KEY_ID}
        - name: AWS_SECRET_ACCESS_KEY
          value: ${AWS_SECRET_ACCESS_KEY}
        - name: AWS_IOT_DEVICE_POLICY
          value: ${AWS_IOT_DEVICE_POLICY}
        - name: AWS_METADATA_TABLE_NAME
          value: ${AWS_METADATA_TABLE_NAME}
        resources:
          requests:
            cpu: 100m
            memory: 256Mi
EOF

kubectl create -f /tmp/device-management-service.yaml --kubeconfig=kubeconfig
rm -f /tmp/device-management-service.yaml