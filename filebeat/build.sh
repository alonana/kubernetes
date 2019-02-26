#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Filebeat Deploy"
kubectl create -f ./k8s/filebeat-service-account.yaml
kubectl create -f ./k8s/filebeat-cluster-role.yaml
kubectl create -f ./k8s/filebeat-cluster-role-binding.yaml
kubectl create -f ./k8s/filebeat-config.yaml
kubectl create -f ./k8s/filebeat-inputs.yaml
kubectl create -f ./k8s/filebeat-daemon.yaml
