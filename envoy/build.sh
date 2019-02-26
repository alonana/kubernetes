#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Envoy Build"
./docker/build.sh

echo "Envoy Deploy"
kubectl create -f ./k8s/service.yaml
kubectl create -f ./k8s/deployment.yaml
