#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Filebeat Deploy"
# see https://raw.githubusercontent.com/elastic/beats/master/deploy/kubernetes/filebeat-kubernetes.yaml
kubectl create configmap filebeat-config --from-file=./filebeat.yml
kubectl create -f ./k8s/service-account.yaml
kubectl create -f ./k8s/cluster-role.yaml
kubectl create -f ./k8s/cluster-role-binding.yaml
kubectl create -f ./k8s/daemon.yaml
