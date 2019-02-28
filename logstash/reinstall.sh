#!/usr/bin/env bash

cd "$(dirname "$0")"

mode=$1

./clean.sh
./build.sh ${mode}
