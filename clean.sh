#!/usr/bin/env bash

set -x

cd "$(dirname "$0")"

echo "Logstash cleanup"
kubectl delete configmap logstash-pipeline
kubectl delete -f ./logstash/service.yaml
kubectl delete -f ./logstash/deployment.yaml

echo "ElasticSearch cleanup"
kubectl delete -f ./elasticsearch/service_internal.yaml
kubectl delete -f ./elasticsearch/service_exposed.yaml
kubectl delete -f ./elasticsearch/deployment.yaml

echo "Minikube cleanup"
sudo minikube delete

