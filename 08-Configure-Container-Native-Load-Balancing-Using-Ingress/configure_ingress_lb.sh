#!/bin/bash
# Script to configure container-native load balancing using Ingress in GKE
# Usage: ./configure-ingress-lb.sh [create|verify|cleanup]

set -e

# Configuration
CLUSTER_NAME="gke-deep-dive"
SUBNET_NAME="gke-deep-dive-subnet"
SUBNET_RANGE="10.10.0.0/24"
DEPLOYMENT_FILE="gke-deep-dive-app.yaml"
SERVICE_FILE="gke-deep-dive-svc.yaml"
INGRESS_FILE="gke-deep-dive-ing.yaml"
APP_NAME="gke-deep-dive-app"
SERVICE_NAME="gke-deep-dive-svc"
INGRESS_NAME="gke-deep-dive-ing"
REGION="me-central1" # Qatar region | Dammam region=me-central2 

function create_resources() {
    echo "Creating subnet in default VPC..."
    gcloud compute networks subnets create $SUBNET_NAME \
        --network=default \
        --range=$SUBNET_RANGE
    
    echo "Creating VPC-native cluster..."
    gcloud container clusters create $CLUSTER_NAME \
        --num-nodes=1 \
        --disk-type=pd-standard \
        --disk-size=12 \
        --enable-ip-alias \
        --subnetwork=$SUBNET_NAME
    
    echo "Generating Kubernetes manifest files..."
    cat > $DEPLOYMENT_FILE <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: $APP_NAME
  name: $APP_NAME
spec:
  selector:
    matchLabels:
      app: $APP_NAME
  template:
    metadata:
      labels:
        app: $APP_NAME
    spec:
      containers:
      - image: gcr.io/google-containers/serve_hostname
        name: $APP_NAME
        ports:
        - containerPort: 9376
          protocol: TCP
EOF

    cat > $SERVICE_FILE <<EOF
apiVersion: v1
kind: Service
metadata:
  name: $SERVICE_NAME
  annotations:
    cloud.google.com/neg: '{"ingress": true}'
spec:
  type: ClusterIP
  selector:
    app: $APP_NAME
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 9376
EOF

    cat > $INGRESS_FILE <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $INGRESS_NAME
spec:
  defaultBackend:
    service:
      name: $SERVICE_NAME
      port:
        number: 80
EOF

    echo "Deploying application..."
    kubectl apply -f $DEPLOYMENT_FILE
    kubectl apply -f $SERVICE_FILE
    kubectl apply -f $INGRESS_FILE
}

function verify_resources() {
    echo "Verifying deployment..."
    kubectl get deployments
    kubectl describe deployment $APP_NAME
    
    echo -e "\nVerifying service..."
    kubectl get services
    kubectl describe service $SERVICE_NAME
    
    echo -e "\nVerifying ingress..."
    kubectl get ingress
    INGRESS_IP=$(kubectl get ingress $INGRESS_NAME -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    echo "Ingress IP: $INGRESS_IP"
    echo "Waiting for load balancer to be ready..."
    sleep 60
    echo "Test the load balancer by visiting: http://$INGRESS_IP"
    
    echo -e "\nScaling deployment to test load balancing..."
    kubectl scale deployment $APP_NAME --replicas=2
    kubectl rollout status deployment $APP_NAME
    echo "Refresh the page multiple times to see different backend responses"
}

function cleanup_resources() {
    echo "Cleaning up resources..."
    kubectl delete -f $INGRESS_FILE
    kubectl delete -f $SERVICE_FILE
    kubectl delete -f $DEPLOYMENT_FILE
    rm -f $DEPLOYMENT_FILE $SERVICE_FILE $INGRESS_FILE
    
    echo "Deleting cluster..."
    gcloud container clusters delete $CLUSTER_NAME -q
    
    echo "Deleting subnet..."
    gcloud compute networks subnets delete $SUBNET_NAME -q
}

case "$1" in
    create)
        create_resources
        ;;
    verify)
        verify_resources
        ;;
    cleanup)
        cleanup_resources
        ;;
    *)
        echo "Usage: $0 [create|verify|cleanup]"
        exit 1
        ;;
esac