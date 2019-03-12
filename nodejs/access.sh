#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

echo "NodeJS health"
curl "http://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_NODEJS}"
echo -e "\n"

echo "NodeJS DB access"
curl -XPOST  "http://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_NODEJS}/api/db/ping"
echo -e "\n"

echo "NodeJS events list"
curl -XPOST  "http://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_NODEJS}/api/events/list"
echo -e "\n"

echo "NodeJS with parameters"
curl -XPOST  -H "Content-type: application/json" "http://${AK8S_KUBE_IP}:${AK8S_GLOBAL_PORT_NODEJS}/api/events/details" --data '{"id":1}'
echo -e "\n"

