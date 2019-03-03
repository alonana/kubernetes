#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../../set_env.sh

echo "NGINX deploy"
mkdir target
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout target/nginx.key -out target/nginx.crt -subj "/CN=nginxsvc/O=nginxsvc"
htpasswd -c -b target/.htpasswd nginx "${AK8S_ELASTIC_PASSWORD}"
kubectl create secret tls nginx-tls --key ./target/nginx.key --cert ./target/nginx.crt
kubectl create secret generic nginx-auth --from-file ./target/.htpasswd
rm -rf target
kubectl create configmap nginx-config --from-file=./default.conf
