#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

export AK8S_ISTIO_WRAP=true

echo "Istio Deploy"
istioctl kube-inject -f  ./k8s/sleep-istio.yaml | kubectl create -f -
istioctl kube-inject -f  ./k8s/httpbin.yaml | kubectl create -f -
kubectl create -f ./k8s/sleep-legacy.yaml

kubectl create -f ./k8s/httpbin-authentication-policy.yaml
kubectl create -f ./k8s/httpbin-authentication-destination-rule.yaml
kubectl create -f ./k8s/es-authentication-policy.yaml
kubectl create -f ./k8s/es-authentication-destination-rule.yaml


../elasticsearch/build.sh

echo "Useful commands"
echo "==============="
echo "*** request httpbin service"
echo "kubectl exec -it sleep-istio- -- curl http://httpbin:8000"
echo "kubectl exec -it sleep-legacy- -- curl http://httpbin:8000"
echo "*** get Envoy actual config"
echo "curl http://127.0.0.1:15000/config_dump"
