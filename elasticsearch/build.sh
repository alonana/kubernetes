#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "ElasticSearch build"
./docker/build.sh

echo "ElasticSearch Deploy"
kubectl create -f ./k8s/service_internal.yaml
kubectl create -f ./k8s/service_exposed.yaml
kubectl create -f ./k8s/deployment.yaml
