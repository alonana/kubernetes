#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./../set_env.sh

LOOP=$1


fetch_once() {
    echo "Check data in ElasticSearch"
    curl -XGET -k -u "${AK8S_ELASTIC_USER}:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_ES}/print-*/_search?size=100&q=*:*&pretty"
    curl -XGET -k -u "${AK8S_ELASTIC_USER}:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_ES}/access-*/_search?size=100&q=*:*&pretty"
    curl -XGET -k -u "${AK8S_ELASTIC_USER}:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_ES}/_cat/indices?v&pretty"
    curl -XGET -k -u "${AK8S_ELASTIC_USER}:${AK8S_ELASTIC_PASSWORD}" "https://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_ES}/_cat/health?v&pretty"
}

if [[ "${LOOP}" == "loop" ]]; then
while :
    do
        fetch_once
        sleep 1
    done
else
    fetch_once
fi




