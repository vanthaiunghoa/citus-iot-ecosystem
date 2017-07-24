#! /bin/bash
mkdir -p ~/tmp/ 
cat > ~/tmp/citus-iot-ecosystem.yaml <<EOF
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
        version: "latest"
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
        version: "latest"
    spec:
      containers:
      - name: sensor-analytics
        image: cuongdd1/citus-sensor-analytics:latest
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
        - name: AUTH0_CLIENT_SECRET
          value: ${AUTH0_CLIENT_SECRET}
        - name: API_SECRET_KEY
          value: ${API_SECRET_KEY}
        resources:
          requests:
            cpu: 100m
            memory: 256Mi
---
apiVersion: v1
kind: Service
metadata:
  name: sensor-analytics
  labels:
    app: sensor-analytics
spec:
  ports:
  - port: 80
    name: tcp-1880
    protocol: TCP
    targetPort: 1880
  selector:
    app: sensor-analytics
---
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
        version: "0.1.4"
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
        version: "0.1.4"
    spec:
      containers:
      - name: recognition-toolkit
        image: cuongdd1/citus-recognition-service:0.1.4
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
        - name: AUTH0_CLIENT_SECRET
          value: ${AUTH0_CLIENT_SECRET}
        - name: OPENFPT_API_KEY
          value: ${OPENFPT_API_KEY}
        resources:
          requests:
            cpu: 100m
            memory: 256Mi
---
apiVersion: v1
kind: Service
metadata:
  name: recognition-toolkit
  labels:
    app: recognition-toolkit
spec:
  ports:
  - port: 80
    name: tcp-3000
    protocol: TCP
    targetPort: 3000
  selector:
    app: recognition-toolkit
---
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
        resources:
          requests:
            cpu: 100m
            memory: 512Mi
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
---
apiVersion: v1
kind: Service
metadata:
  name: citus-elasticsearch-svc
  labels:
    app: citus-elasticsearch-svc
spec:
  ports:
  - port: 80
    name: tcp-9200
    protocol: TCP
    targetPort: 9200
  selector:
    app: citus-elasticsearch-svc
---
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
---
apiVersion: v1
kind: Service
metadata:
  name: device-management-service
  labels:
    app: device-management-service
spec:
  ports:
  - port: 80
    name: tcp-3000
    protocol: TCP
    targetPort: 3000
  selector:
    app: device-management-service
    
EOF

kubectl apply -f ~/tmp/citus-iot-ecosystem.yaml
rm -f ~/tmp/citus-iot-ecosystem.yaml