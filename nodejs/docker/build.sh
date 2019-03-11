#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../../set_env.sh

echo "NodeJS docker build"
rm -rf target
mkdir target
cp -r ../src/package.json target
cp -r ../src/main target
docker build . -t alonana/nodejs:1.0.0
rm -rf target
