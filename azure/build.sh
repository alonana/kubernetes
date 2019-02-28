#!/usr/bin/env bash

cd "$(dirname "$0")"

export AK8S_USE_MINIKUBE=false
source azure_env.sh
source ../set_env.sh


../build_all.sh

az acr login --name ${azureRegistryName}

docker tag alonana/elasticsearch:1.0.0 ${azureRegistryFqdn}/elasticsearch:1.0.0
docker push ${azureRegistryFqdn}/elasticsearch:1.0.0

docker tag alonana/logstash:1.0.0 ${azureRegistryFqdn}/logstash:1.0.0
docker push ${azureRegistryFqdn}/logstash:1.0.0

docker tag alonana/envoy:1.0.0 ${azureRegistryFqdn}/envoy:1.0.0
docker push ${azureRegistryFqdn}/envoy:1.0.0
