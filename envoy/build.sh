#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Envoy Build"
./docker/build.sh

echo "Envoy Deploy"
kubectl create configmap envoy-config --from-file=./envoy.yaml
sed "s/AK8S_GLOBAL_PORT_ENVOY/${AK8S_GLOBAL_PORT_ENVOY}/g" ./k8s/service.yaml | kubectl create -f -
sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" ./k8s/deployment.yaml | kubectl create -f -
