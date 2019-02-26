#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "NGINX Deploy"
kubectl create -f ./k8s/service.yaml
kubectl create -f ./k8s/deployment.yaml
