#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Logstash Build"
./docker/build.sh

echo "Logstash Deploy"
kubectl create configmap logstash-pipeline --from-file=./pipeline.conf
kubectl create -f ./k8s/service.yaml
kubectl create -f ./k8s/deployment.yaml
