#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "NGINX cleanup"
kubectl delete -f ./k8s/service.yaml
kubectl delete -f ./k8s/deployment.yaml
