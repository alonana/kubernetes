#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "ElasticSearch build"
./docker/build.sh

echo "ElasticSearch Deploy starting"
kubectl create -f ./k8s/persistent-volume.yaml
kubectl create -f ./k8s/persistent-volume-claim.yaml
kubectl create -f ./k8s/service_internal.yaml
kubectl create -f ./k8s/service_exposed.yaml
kubectl create -f ./k8s/deployment.yaml
echo "ElasticSearch Deploy done"
