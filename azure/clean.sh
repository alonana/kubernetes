#!/usr/bin/env bash

cd "$(dirname "$0")"

export AK8S_USE_MINIKUBE=false
source azure_env.sh
source ../set_env.sh

../clean_all.sh
