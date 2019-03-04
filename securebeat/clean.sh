#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Cleanup secure beat resources"
rm -rf target
kubectl delete configmap securebeat-ca-config
kubectl delete secret securebeat-client-secret
kubectl delete secret securebeat-server-secret

