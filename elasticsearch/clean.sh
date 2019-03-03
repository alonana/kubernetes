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

if [[ "${AK8S_USE_MINIKUBE}" == "true" ]]; then
    kubectl delete -f ./k8s/storage/minikube/persistent-volume.yaml
    kubectl delete -f ./k8s/storage/minikube/persistent-volume-claim.yaml
else
    kubectl delete -f ./k8s/storage/azure/persistent-volume.yaml
    kubectl delete -f ./k8s/storage/azure/persistent-volume-claim.yaml
    kubectl delete -f ./k8s/storage/azure/cluster-role-binding.yaml
    kubectl delete -f ./k8s/storage/azure/cluster-role.yaml
fi

kubectl delete configmap elastic-config
echo "ElasticSearch cleanup done"
