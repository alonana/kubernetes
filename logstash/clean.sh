#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Logstash cleanup"
kubectl delete configmap logstash-pipeline
kubectl delete -f ./k8s/service.yaml
kubectl delete -f ./k8s/deployment.yaml
