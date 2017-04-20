#! /bin/bash

cat > /tmp/recognition-toolkit.yaml <<EOF
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
      deployment.kubernetes.io/revision: "1"
  name: recognition-toolkit
  namespace: default
spec:
  replicas: 1
  selector:
      matchLabels:
        app: recognition-toolkit
        version: "latest"
  strategy:
      rollingUpdate:
        maxSurge: 1
        maxUnavailable: 1
      type: RollingUpdate
  template:
    metadata:
      name: recognition-toolkit
      labels:
        app: recognition-toolkit
        version: "latest"
    spec:
      containers:
      - name: recognition-toolkit
        image: cuongdd1/citus-recognition-service:latest
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
        - name: SECRET_KEY
          value: ${SECRET_KEY}
        - name: API_KEY
          value: ${API_KEY}
EOF

kubectl create -f /tmp/recognition-toolkit.yaml --kubeconfig=kubeconfig
rm -f /tmp/recognition-toolkit.yaml