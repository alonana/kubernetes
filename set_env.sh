#!/usr/bin/env bash

if [[ "${AK8S_ENV_SET}" == "true" ]]; then
    return
fi



export AK8S_USE_MINIKUBE=${AK8S_USE_MINIKUBE:-true}
if [[ "${AK8S_USE_MINIKUBE}" == "true" ]]; then
    echo Using minikube as the kubernetes cluster
    eval $(sudo minikube docker-env)
    export AK8S_KUBE_IP=`sudo minikube ip`
fi

export AK8S_DOCKER_REPOSITORY=${AK8S_DOCKER_REPOSITORY:-alonana}
echo Using docker repository ${AK8S_DOCKER_REPOSITORY}

export AK8S_ELASTIC_USER=${AK8S_ELASTIC_USER:-esuser}
export AK8S_ELASTIC_PASSWORD=${AK8S_ELASTIC_PASSWORD:-espass}

export AK8S_ISTIO_WRAP=${AK8S_ISTIO_WRAP:-false}

export AK8S_GLOBAL_PORT_ES=30001
export AK8S_GLOBAL_PORT_ENVOY=30002
export AK8S_GLOBAL_PORT_ENVOY_LOGROTATE=30003
export AK8S_GLOBAL_PORT_NODEJS=30004
export AK8S_GLOBAL_PORT_GUI=30005




export AK8S_ENV_SET=true
