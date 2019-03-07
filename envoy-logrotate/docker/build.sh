#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../../set_env.sh

docker build . -t alonana/envoy-logrotate:1.0.0