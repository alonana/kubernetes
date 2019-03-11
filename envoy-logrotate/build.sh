#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

./docker/envoy/build.sh
./docker/logrotate/build.sh

echo "Envoy Deploy"
kubectl create configmap envoy-logrotate-config --from-file=./envoy.yaml
sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" ./k8s/deployment.yaml | kubectl create -f -
sed "s/AK8S_GLOBAL_PORT_ENVOY_LOGROTATE/${AK8S_GLOBAL_PORT_ENVOY_LOGROTATE}/g" ./k8s/service.yaml | kubectl create -f -
