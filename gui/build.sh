#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "GUI docker build"
docker build . -t alonana/gui:1.0.0

echo "GUI Deploy"
sed "s/AK8S_GLOBAL_PORT_GUI/${AK8S_GLOBAL_PORT_GUI}/g" ./k8s/service.yaml | kubectl create -f -
sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" ./k8s/deployment.yaml | kubectl create -f -
