#!/usr/bin/env bash

set -x

cd "$(dirname "$0")"

echo "Minikube setup"
sudo minikube start --memory 4096
eval $(sudo minikube docker-env)
sudo minikube status

echo "ElasticSearch build"
./elasticsearch/docker/build.sh

echo "ElasticSearch Deploy"
kubectl create -f ./elasticsearch/service_internal.yaml
kubectl create -f ./elasticsearch/service_exposed.yaml
kubectl create -f ./elasticsearch/deployment.yaml

echo "Logstash Build"
./logstash/docker/build.sh

echo "Logstash Deploy"
kubectl create configmap logstash-pipeline --from-file=./logstash/pipeline.conf
kubectl create -f ./logstash/service.yaml
kubectl create -f ./logstash/deployment.yaml

