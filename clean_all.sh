#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./set_env.sh

./filebeat/clean.sh
./logstash/clean.sh
./envoy/clean.sh
elasticsearch/data_clean.sh
./elasticsearch/clean.sh

#echo "Minikube cleanup"
#sudo minikube delete
