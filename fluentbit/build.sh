#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Fluent Bit Deploy"
# see https://docs.fluentbit.io/manual/installation/kubernetes
kubectl create -f ./k8s/fluent-bit-service-account.yaml
kubectl create -f ./k8s/fluent-bit-role.yaml
kubectl create -f ./k8s/fluent-bit-role-binding.yaml
kubectl create -f ./k8s/fluent-bit-configmap.yaml
# this is for minikube, for regular kubernetes cluster, use:
# kubectl create -f ./fluentbit/fluent-bit-ds.yaml
kubectl create -f ./k8s/fluent-bit-ds-minikube.yaml

