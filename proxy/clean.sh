#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "ElasticSearch Proxy cleanup"
kubectl delete -f ./k8s/deployment.yaml
kubectl delete -f ./k8s/service.yaml
kubectl delete configmap es-proxy-config
kubectl delete secret es-proxy-tls-secret

