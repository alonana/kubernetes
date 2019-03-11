#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../../set_env.sh

echo "NGINX cleanup"
kubectl delete configmap nginx-config
kubectl delete secret nginx-tls
kubectl delete secret nginx-auth
kubectl delete secret elasticsearch-password-secret

