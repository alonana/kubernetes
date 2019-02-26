#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Minikube setup"
#sudo minikube start --memory 4096
eval $(sudo minikube docker-env)
sudo minikube status

./elasticsearch/build.sh
./logstash/build.sh
#./fluentbit/build.sh
./filebeat/build.sh
./envoy/build.sh
#./nginx/build.sh


echo "Send data to Logstash"
KUBE_IP=`sudo minikube ip`
curl -H "content-type: application/json" -XPUT "http://${KUBE_IP}:30003/data" -d '{
    "timestamp" : "2009-12-29 14:12:13",
    "message" : "This is my message, please save it",
    "field1" : "more data",
    "field2" : "and some more"
}'


echo "Check data in ElasticSearch"
curl -XGET "http://${KUBE_IP}:30002/_cat/indices?v&pretty"
curl -XGET "http://${KUBE_IP}:30002/mydata-*/_search?size=1000&q=*:*&pretty"
curl -XGET "http://${KUBE_IP}:30002/fluentbit*/_search?size=1000&q=*:*&pretty"

echo "Check Envoy"
curl -XGET "http://${KUBE_IP}:30004"

echo "Check NGINX"
curl -XGET "http://${KUBE_IP}:30001"