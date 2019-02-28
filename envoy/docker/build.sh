#!/usr/bin/env bash
cd "$(dirname "$0")"

eval $(sudo minikube docker-env)
docker build . -t alonana/envoy:1.0.0