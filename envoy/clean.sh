#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Envoy cleanup"
kubectl delete -f ./k8s/deployment.yaml
kubectl delete -f ./k8s/service.yaml
