#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

./docker/build.sh

echo "NodeJS Deploy"
sed "s/AK8S_GLOBAL_PORT_NODEJS/${AK8S_GLOBAL_PORT_NODEJS}/g" ./k8s/service.yaml | kubectl create -f -
sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" ./k8s/deployment.yaml | kubectl create -f -
