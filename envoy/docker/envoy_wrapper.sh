#!/usr/bin/env bash
/usr/local/bin/envoy -c  /etc/envoy/envoy.yaml &

sequence=0
while :
do
    let "sequence++"
    time=`date --iso-8601=seconds`
    data=`echo -e '{"enforcer-version":"1", "desc":"Data with new lines included \nand another line\nwith single '"'"' and double \" quotes\nlast line", "timestamp":"'${time}'", "sequence":"'${sequence}'"}'`
    json=`echo ${data} | base64 --wrap=0`
    if [ ! -f /tmp/printout ]; then
        echo "enforcer output${json}"
    fi
    sleep 10
done
