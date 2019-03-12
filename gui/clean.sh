#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "GUI cleanup"
kubectl delete -f ./k8s/service.yaml
kubectl delete -f ./k8s/deployment.yaml
