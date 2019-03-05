#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../../set_env.sh

echo "ElasticSearch Proxy Deploy"
mkdir target
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout target/proxy.key -out target/proxy.crt -subj "/CN=proxysvc/O=proxysvc"
kubectl create secret tls es-proxy-tls-secret --key ./target/proxy.key --cert ./target/proxy.crt
rm -rf target

kubectl create configmap es-proxy-config --from-file=./envoy.yaml
kubectl create -f ./k8s/deployment.yaml
kubectl create -f ./k8s/service.yaml



#echo "NGINX deploy"
#mkdir target
#openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout target/nginx.key -out target/nginx.crt -subj "/CN=nginxsvc/O=nginxsvc"
#htpasswd -c -b target/.htpasswd nginx "${AK8S_ELASTIC_PASSWORD}"
#kubectl create secret tls nginx-tls --key ./target/nginx.key --cert ./target/nginx.crt
#kubectl create secret generic nginx-auth --from-file ./target/.htpasswd
#rm -rf target
#kubectl create configmap nginx-config --from-file=./default.conf
