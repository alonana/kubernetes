#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./../set_env.sh

echo "ElasticSearch data cleanup"
curl -XDELETE "http://${AK8S_KUBE_IP}:30002/mydata*"
curl -XDELETE "http://${AK8S_KUBE_IP}:30002/fluentbit*"

echo "ElasticSearch cleanup start"
kubectl delete -f ./k8s/service-discovery.yaml
kubectl delete -f ./k8s/service-exposed.yaml
cat ./k8s/deployment.yaml | sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" | kubectl delete -f -
kubectl delete -f ./k8s/persistent-volume-claim.yaml
kubectl delete -f ./k8s/persistent-volume.yaml
kubectl delete configmap elastic-config
echo "ElasticSearch cleanup done"
