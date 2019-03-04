#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./../set_env.sh

echo "ElasticSearch data cleanup"
curl -XDELETE -k -u "nginx:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:30001/print*"
curl -XDELETE -k -u "nginx:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:30001/access*"
