#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../../set_env.sh

echo
docker build . -t alonana/logstash:1.0.0