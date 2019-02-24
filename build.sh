#!/usr/bin/env bash

set -x

cd "$(dirname "$0")"

echo "Minikube setup"
sudo minikube start --memory 4096
eval $(sudo minikube docker-env)
sudo minikube status

echo "ElasticSearch build"
./elasticsearch/docker/build.sh

echo "ElasticSearch Deploy"
kubectl create -f ./elasticsearch/service_internal.yaml
kubectl create -f ./elasticsearch/service_exposed.yaml
kubectl create -f ./elasticsearch/deployment.yaml

echo "Logstash Build"
./logstash/docker/build.sh

echo "Logstash Deploy"
kubectl create configmap logstash-pipeline --from-file=./logstash/pipeline.conf
kubectl create -f ./logstash/service.yaml
kubectl create -f ./logstash/deployment.yaml


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

