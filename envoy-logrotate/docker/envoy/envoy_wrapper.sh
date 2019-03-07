#!/usr/bin/env bash
HOST=`hostname`
mkdir logs/${HOST}
chmod -R 700 logs/${HOST}
sed "s/REPLACE_WITH_HOSTNAME/${HOST}/g" /etc/envoy/envoy.yaml > /envoy_updated.yaml
/usr/local/bin/envoy -c /envoy_updated.yaml
