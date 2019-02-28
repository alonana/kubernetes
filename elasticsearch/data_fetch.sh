#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./../set_env.sh

LOOP=$1


fetch_once() {
    echo "Check data in ElasticSearch"
    curl -XGET "http://${AK8S_KUBE_IP}:30002/_cat/indices?v&pretty"
    curl -XGET "http://${AK8S_KUBE_IP}:30002/mydata-*/_search?size=1000&q=*:*&pretty"
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




