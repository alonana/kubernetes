#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "ElasticSearch build"
./docker/build.sh

echo "ElasticSearch Deploy starting"
kubectl create configmap elastic-config --from-file=./elasticsearch.yml

if [[ "${AK8S_USE_MINIKUBE}" == "true" ]]; then
    kubectl create -f ./k8s/storage/minikube/persistent-volume.yaml
    kubectl create -f ./k8s/storage/minikube/persistent-volume-claim.yaml
else
    # see https://docs.microsoft.com/bs-latn-ba/azure/aks/azure-files-dynamic-pv?view=aps-pdw-2016-au7
    kubectl create -f ./k8s/storage/azure/cluster-role.yaml
    kubectl create -f ./k8s/storage/azure/cluster-role-binding.yaml
    kubectl create -f ./k8s/storage/azure/persistent-volume.yaml
    kubectl create -f ./k8s/storage/azure/persistent-volume-claim.yaml
fi

kubectl create -f ./k8s/service-discovery.yaml
kubectl create -f ./k8s/service-exposed.yaml
cat ./k8s/deployment.yaml | sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" | kubectl create -f -
echo "ElasticSearch Deploy done"
