#!/usr/bin/env bash

cd "$(dirname "$0")"

mode=$1

echo "Logstash Build"

if [[ "${mode}" == "full" ]]; then
    ./docker/build.sh
fi

echo "Logstash Deploy"
kubectl create configmap logstash-pipeline --from-file=./pipeline.conf
kubectl create -f ./k8s/service.yaml
kubectl create -f ./k8s/deployment.yaml
