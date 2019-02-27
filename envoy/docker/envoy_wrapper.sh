#!/usr/bin/env bash
/docker-entrypoint.sh &

sequence=0
while :
do
    let "sequence++"
    time=`date --iso-8601=seconds`
    data=`echo -e '{"enforcer-version":"1", "desc":"Data with new lines included \nand another line\nwith single '"'"' and double \" quotes\nlast line", "timestamp":"'${time}'", "sequence":"'${sequence}'"}'`
    json=`echo ${data} | base64 --wrap=0`
    echo "enforcer output${json}"
    sleep 1
done
