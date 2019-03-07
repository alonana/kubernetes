#!/usr/bin/env bash
chmod -R 700 /tmp
while :
do
    sleep 10
    logrotate /rotate.conf --verbose
done
