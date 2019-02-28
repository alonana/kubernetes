#!/usr/bin/env bash

export AK8S_USE_MINIKUBE=false

[ -z "${azureRegistryName}" ] && echo -e "need to run:\nexport azureRegistryName=X" && exit
[ -z "${azureRegistryFqdn}" ] && echo -e "need to run:\nexport azureRegistryFqdn=X" && exit


export AK8S_DOCKER_REPOSITORY=${azureRegistryFqdn}

AZ_LOGGED=`az account list | grep user | wc -l`
if [[ "${AZ_LOGGED}" == "0" ]]; then
    az login
fi

az acr login --name ${azureRegistryName}

