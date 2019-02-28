#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../set_env.sh

mode=$1

./clean.sh
./build.sh ${mode}
