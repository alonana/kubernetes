#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./set_env.sh

./securebeat/clean.sh
./filebeat/clean.sh
./logstash/clean.sh
./envoy/clean.sh
./envoy-logrotate/clean.sh
./elasticsearch/clean.sh
./nodejs/clean.sh

# echo "Minikube cleanup"
# sudo minikube delete
# sudo rm -rf ~/.kube/

