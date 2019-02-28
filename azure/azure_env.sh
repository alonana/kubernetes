#!/usr/bin/env bash

export AK8S_USE_MINIKUBE=false

[ -z "${azureRegistryName}" ] && echo "Missing azureRegistryName" && exit
[ -z "${azureRegistryFqdn}" ] && echo "Missing azureRegistryFqdn" && exit


export AK8S_DOCKER_REPOSITORY=${azureRegistryFqdn}

AZ_LOGGED=`az account list | grep user | wc -l`
if [[ "${AZ_LOGGED}" == "0" ]]; then
    az login
fi

az acr login --name ${azureRegistryName}

