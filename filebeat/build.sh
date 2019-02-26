#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Filebeat Deploy"
# see https://raw.githubusercontent.com/elastic/beats/master/deploy/kubernetes/filebeat-kubernetes.yaml
kubectl create configmap filebeat-config --from-file=./filebeat.yml
kubectl create -f ./k8s/filebeat-service-account.yaml
kubectl create -f ./k8s/filebeat-cluster-role.yaml
kubectl create -f ./k8s/filebeat-cluster-role-binding.yaml
kubectl create -f ./k8s/filebeat-daemon.yaml
