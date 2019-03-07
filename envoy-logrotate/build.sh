#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

./docker/envoy/build.sh
./docker/logrotate/build.sh

echo "Envoy Deploy"
kubectl create configmap envoy-config --from-file=./envoy.yaml
kubectl create -f ./k8s/service.yaml
cat ./k8s/deployment.yaml | sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" | kubectl create -f -
