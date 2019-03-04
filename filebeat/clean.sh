#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Filebeat cleanup"
kubectl delete -f ./k8s/service-account.yaml
kubectl delete -f ./k8s/cluster-role.yaml
kubectl delete -f ./k8s/cluster-role-binding.yaml
kubectl delete -f ./k8s/daemon.yaml
kubectl delete configmap filebeat-config
