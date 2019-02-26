#!/usr/bin/env bash

./fluentbit/clean.sh
./filebeat/clean.sh
./logstash/clean.sh
./envoy/clean.sh
elasticsearch/data_clean.sh
./elasticsearch/clean.sh
./nginx/clean.sh

echo "Minikube cleanup"
#sudo minikube delete

