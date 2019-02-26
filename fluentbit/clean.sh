#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Fluent Bit cleanup"
kubectl delete -f ./k8s/fluent-bit-ds-minikube.yaml
kubectl delete -f ./k8s/fluent-bit-configmap.yaml
kubectl delete -f ./k8s/fluent-bit-role-binding.yaml
kubectl delete -f ./k8s/fluent-bit-role.yaml
kubectl delete -f ./k8s/fluent-bit-service-account.yaml

