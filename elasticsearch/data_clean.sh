#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./../set_env.sh

echo "ElasticSearch data cleanup for https://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_ES}"
curl -XDELETE -k -u "${AK8S_ELASTIC_USER}:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_ES}/print*"
curl -XDELETE -k -u "${AK8S_ELASTIC_USER}:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_ES}/access*"
