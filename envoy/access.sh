#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "Accessing"
curl "http://${AK8S_KUBE_IP}:30004"
