#!/usr/bin/env bash

set -x

cd "$(dirname "$0")"

echo "Minikube setup"
sudo minikube start --memory 4096
eval $(sudo minikube docker-env)
sudo minikube status

echo "ElasticSearch build"
./elasticsearch/docker/build.sh

echo "Deploy ElasticSearch"
kubectl create -f ./elasticsearch/service_internal.yaml
kubectl create -f ./elasticsearch/service_exposed.yaml
kubectl create -f ./elasticsearch/deployment.yaml
