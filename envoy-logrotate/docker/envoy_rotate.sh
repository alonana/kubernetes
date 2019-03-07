#!/usr/bin/env bash
while :
do
    sleep 10
    logrotate /rotate.conf --verbose
done
