#!/usr/bin/env bash

SOURCED=$_
echo ${SOURCED}
FOLDER="."
if [[ "${SOURCED}" != "" ]]; then
    FOLDER=`dirname "${SOURCED}"`
fi

LOCAL_CONFIG=${FOLDER}/local.sh

if [[ -f  ${LOCAL_CONFIG} ]]; then
    source ${LOCAL_CONFIG}
fi

[ -z "${azureRegistryName}" ] && echo -e "need to run:\nexport azureRegistryName=X" && return
[ -z "${azureRegistryFqdn}" ] && echo -e "need to run:\nexport azureRegistryFqdn=X" && return


export AK8S_USE_MINIKUBE=false

AZ_LOGGED=`az account list | grep user | wc -l`
if [[ "${AZ_LOGGED}" == "0" ]]; then
    echo "Login to Azure"
    az login
fi

echo "Login to Azure container registry"

az acr login --name ${azureRegistryName}


export AK8S_USE_MINIKUBE=false
export AK8S_DOCKER_REPOSITORY=${azureRegistryFqdn}
