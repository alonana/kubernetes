#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "ElasticSearch data cleanup"
KUBE_IP=`sudo minikube ip`
curl -XDELETE "http://${KUBE_IP}:30002/mydata*"
curl -XDELETE "http://${KUBE_IP}:30002/fluentbit*"
