#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

mode=$1

echo "Logstash Build"

if [[ "${AK8S_BUILD_LOGSTASH_DOCKER}" == "true" ]]; then
    ./docker/build.sh
fi

echo "Logstash Deploy"
kubectl create configmap logstash-pipeline --from-file=./pipeline.conf
kubectl create -f ./k8s/service.yaml
cat ./k8s/deployment.yaml | sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" | kubectl create -f -
