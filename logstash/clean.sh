#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Logstash cleanup"
kubectl delete configmap logstash-pipeline
kubectl delete -f ./k8s/service.yaml
cat ./k8s/deployment.yaml | sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" | kubectl delete -f -
