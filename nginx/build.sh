#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "NGINX Deploy"
kubectl create -f ./k8s/stateless/service.yaml
kubectl create -f ./k8s/stateless/deployment.yaml

kubectl create -f ./k8s/stateful/persistent-volume.yaml
kubectl create -f ./k8s/stateful/persistent-volume-claim.yaml
kubectl create -f ./k8s/stateful/service.yaml
kubectl create -f ./k8s/stateful/deployment.yaml
