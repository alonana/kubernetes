#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

./nginx/build.sh
./docker/build.sh

echo "ElasticSearch Deploy"
kubectl create configmap elastic-config --from-file=./elasticsearch.yml


rm -rf target
mkdir target
sed "s/AK8S_DOCKER_REPOSITORY/${AK8S_DOCKER_REPOSITORY}/g" ./k8s/deployment.yaml > target/deployment.yaml

if [[ "${AK8S_USE_MINIKUBE}" == "true" ]]; then
    kubectl create -f ./k8s/storage/minikube/persistent-volume.yaml
    kubectl create -f ./k8s/storage/minikube/persistent-volume-claim.yaml
    cat ./k8s/storage/minikube/deployment.yaml_append >> target/deployment.yaml
else
    kubectl create -f ./k8s/storage/azure/cluster-role.yaml
    kubectl create -f ./k8s/storage/azure/cluster-role-binding.yaml
    kubectl create -f ./k8s/storage/azure/storage-class.yaml
    cat ./k8s/storage/azure/deployment.yaml_append >> target/deployment.yaml
fi


if [[ "${AK8S_ISTIO_WRAP}" == "true" ]]; then
    istioctl kube-inject -f  target/deployment.yaml | kubectl create -f -
else
    kubectl create -f target/deployment.yaml
fi
rm -rf target

kubectl create -f ./k8s/service-discovery.yaml
kubectl create -f ./k8s/service-exposed.yaml
