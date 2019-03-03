#!/usr/bin/env bash

if [[ "${AK8S_ENV_SET}" == "true" ]]; then
    return
fi



export AK8S_USE_MINIKUBE=${AK8S_USE_MINIKUBE:-true}
if [[ "${AK8S_USE_MINIKUBE}" == "true" ]]; then
    echo Using minikube as the kubernetes cluster
    eval $(sudo minikube docker-env)
    AK8S_KUBE_IP=`sudo minikube ip`
fi

export AK8S_DOCKER_REPOSITORY=${AK8S_DOCKER_REPOSITORY:-alonana}
echo Using docker repository ${AK8S_DOCKER_REPOSITORY}

export AK8S_BUILD_LOGSTASH_DOCKER=${AK8S_BUILD_LOGSTASH_DOCKER:-false}

export AK8S_ELASTIC_PASSWORD=${AK8S_ELASTIC_PASSWORD:-nginx}




export AK8S_ENV_SET=true
