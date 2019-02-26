#!/usr/bin/env bash
/docker-entrypoint.sh &

sequence=0
while :
do
    let "sequence++"
    time=` date --iso-8601=seconds`
    echo "{'enforcer-version': 1, 'desc':'Are you trying to break in??', 'timestamp':'${time}', 'sequence':'${sequence}'}"
    sleep 1
done