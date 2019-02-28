#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "ElasticSearch build"
./docker/build.sh

echo "ElasticSearch Deploy starting"
kubectl create configmap elastic-config --from-file=./elasticsearch.yml
kubectl create -f ./k8s/persistent-volume.yaml
kubectl create -f ./k8s/persistent-volume-claim.yaml
kubectl create -f ./k8s/service-discovery.yaml
kubectl create -f ./k8s/service-exposed.yaml
cat ./k8s/deployment.yaml | sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" | kubectl create -f -
echo "ElasticSearch Deploy done"
