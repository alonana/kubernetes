#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../../set_env.sh

echo "Logstash docker build"
docker build . -t alonana/logstash:1.0.0