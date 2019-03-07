#!/usr/bin/env bash

HOST=`hostname`
sed -i "s/REPLACE_WITH_HOSTNAME/${HOST}/g" /rotate.conf

while :
do
    sleep 60
    logrotate /rotate.conf --verbose
done
