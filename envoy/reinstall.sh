#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

./clean.sh
./build.sh
