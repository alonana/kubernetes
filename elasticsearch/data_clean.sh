#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./../set_env.sh

echo "ElasticSearch data cleanup"
curl -XDELETE "http://${AK8S_KUBE_IP}:30002/mydata*"
curl -XDELETE "http://${AK8S_KUBE_IP}:30002/fluentbit*"
