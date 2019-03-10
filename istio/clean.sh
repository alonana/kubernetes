#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

export AK8S_ISTIO_WRAP=true

../elasticsearch/clean.sh

echo "Istio cleanup"
kubectl delete -f ./k8s/es-authentication-destination-rule.yaml
kubectl delete -f ./k8s/es-authentication-policy.yaml
kubectl delete -f ./k8s/httpbin-authentication-destination-rule.yaml
kubectl delete -f ./k8s/httpbin-authentication-policy.yaml
kubectl delete -f ./k8s/httpbin.yaml
kubectl delete -f ./k8s/sleep-istio.yaml
kubectl delete -f ./k8s/sleep-legacy.yaml
