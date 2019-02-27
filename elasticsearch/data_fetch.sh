#!/usr/bin/env bash

cd "$(dirname "$0")"

LOOP=$1

KUBE_IP=`sudo minikube ip`

fetch_once() {
    echo "Check data in ElasticSearch"
    curl -XGET "http://${KUBE_IP}:30002/_cat/indices?v&pretty"
    curl -XGET "http://${KUBE_IP}:30002/mydata-*/_search?size=1000&q=*:*&pretty"
    #curl -XGET "http://${KUBE_IP}:30002/fluentbit*/_search?size=1000&q=*:*&pretty"
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




