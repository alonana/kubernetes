#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./set_env.sh

#echo "Creating minikube"
#rm -rf ~/.kube/
#sudo minikube start --memory 4096


./elasticsearch/build.sh
./logstash/build.sh
./filebeat/build.sh
./envoy/build.sh

echo "Build complete"
