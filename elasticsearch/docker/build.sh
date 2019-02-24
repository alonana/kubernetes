#!/usr/bin/env bash
cd "$(dirname "$0")"
docker build . -t alonana/elasticsearch:1.0.0