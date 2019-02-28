#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Filebeat cleanup"
kubectl delete -f ./k8s/filebeat-service-account.yaml
kubectl delete -f ./k8s/filebeat-cluster-role.yaml
kubectl delete -f ./k8s/filebeat-cluster-role-binding.yaml
kubectl delete -f ./k8s/filebeat-daemon.yaml
kubectl delete configmap filebeat-config
