#!/usr/bin/env bash

cd "$(dirname "$0")"

KUBE_IP=`sudo minikube ip`

echo "Check data in ElasticSearch"
curl -XGET "http://${KUBE_IP}:30002/_cat/indices?v&pretty"
curl -XGET "http://${KUBE_IP}:30002/mydata-*/_search?size=1000&q=*:*&pretty"
#curl -XGET "http://${KUBE_IP}:30002/fluentbit*/_search?size=1000&q=*:*&pretty"
