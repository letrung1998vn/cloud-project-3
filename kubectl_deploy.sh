#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Set vars
DOCKER_HUB_ID="letrung1998vn"
DOCKER_REPOSITORY="udagram-api-feed"
DEPLOYMENT_NAME=${DOCKER_REPOSITORY}
CONTAINER_PORT=8100
VERSION=lastest
dockerpath=${DOCKER_HUB_ID}/${DOCKER_REPOSITORY}:${VERSION}

# set aws configure
aws configure set aws_access_key_id AKIASPJPHRDZW7MGKX3C
aws configure set aws_secret_access_key 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
aws configure set region us-east-1
aws sts get-caller-identity
# Create config file
echo "Create config"
aws eks --region us-east-1 update-kubeconfig --name capstone-cluster
kubectl get svc
# Run the Docker Hub container with kubernetes
echo "Create deployment"
kubectl create deployment ${DEPLOYMENT_NAME} --image=${dockerpath}

kubectl expose deployment/${DEPLOYMENT_NAME} --type="LoadBalancer" --port ${CONTAINER_PORT}

# List kubernetes resources
echo
echo "Listing deployments"
kubectl get deployments -o wide --all-namespaces
echo
echo "Listing services"
kubectl get services -o wide --all-namespaces
echo
echo "Listing pods"
kubectl get pods -o wide --all-namespaces
kubectl get nodes -o wide --all-namespaces

