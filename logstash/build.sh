#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

./docker/build.sh

echo "Logstash Deploy"
kubectl create configmap logstash-pipeline --from-file=./pipeline.conf
kubectl create configmap logstash-yml-config --from-file=./logstash.yml
kubectl create -f ./k8s/service.yaml
sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" ./k8s/deployment.yaml | kubectl create -f -
