#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "NGINX cleanup"
kubectl delete -f ./k8s/stateless/service.yaml
kubectl delete -f ./k8s/stateless/deployment.yaml

kubectl delete -f ./k8s/stateful/service.yaml
kubectl delete -f ./k8s/stateful/deployment.yaml
kubectl delete -f ./k8s/stateful/persistent-volume.yaml
kubectl delete -f ./k8s/stateful/persistent-volume-claim.yaml
