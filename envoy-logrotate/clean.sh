#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Envoy cleanup"
cat ./k8s/deployment.yaml | sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" | kubectl delete -f -
kubectl delete -f ./k8s/service.yaml
kubectl delete configmap envoy-logrotate-config
