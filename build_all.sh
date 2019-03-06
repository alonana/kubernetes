#!/usr/bin/env bash

cd "$(dirname "$0")"
source ./set_env.sh

if [[ "${AK8S_NEW_MINIKUBE}" == "true" ]]; then
    echo "Creating minikube"
    sudo rm -rf ~/.kube/
    set -e
    sudo minikube start --memory 4096
    set +e
    sudo chmod -R 777 ~/.kube/config
    export AK8S_BUILD_LOGSTASH_DOCKER=true
fi

./elasticsearch/build.sh
./securebeat/build.sh
./logstash/build.sh
./filebeat/build.sh
./envoy/build.sh

echo "Build complete"
