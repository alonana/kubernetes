#!/usr/bin/env bash

set -x

cd "$(dirname "$0")"

echo "ElasticSearch data cleanup"
KUBE_IP=`sudo minikube ip`
curl -XDELETE "http://${KUBE_IP}:30002/mydata*"
curl -XDELETE "http://${KUBE_IP}:30002/fluentbit*"

echo "Fluent Bit cleanup"
kubectl delete -f ./fluentbit/fluent-bit-ds-minikube.yaml
kubectl delete -f ./fluentbit/fluent-bit-configmap.yaml
kubectl delete -f ./fluentbit/fluent-bit-role-binding.yaml
kubectl delete -f ./fluentbit/fluent-bit-role.yaml
kubectl delete -f ./fluentbit/fluent-bit-service-account.yaml

echo "Filebeat cleanup"
kubectl delete -f ./filebeat/filebeat-service-account.yaml
kubectl delete -f ./filebeat/filebeat-cluster-role.yaml
kubectl delete -f ./filebeat/filebeat-cluster-role-binding.yaml
kubectl delete -f ./filebeat/filebeat-config.yaml
kubectl delete -f ./filebeat/filebeat-inputs.yaml
kubectl delete -f ./filebeat/filebeat-daemon.yaml

echo "Logstash cleanup"
kubectl delete configmap logstash-pipeline
kubectl delete -f ./logstash/service.yaml
kubectl delete -f ./logstash/deployment.yaml

echo "ElasticSearch cleanup"
kubectl delete -f ./elasticsearch/service_internal.yaml
kubectl delete -f ./elasticsearch/service_exposed.yaml
kubectl delete -f ./elasticsearch/deployment.yaml

echo "Envoy cleanup"
kubectl delete -f ./envoy/service.yaml
kubectl delete -f ./envoy/deployment.yaml

echo "Minikube cleanup"
sudo minikube delete

