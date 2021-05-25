#!/bin/bash
# 
sleep 5 
while ! nc -z $DB_HOST $DB_PORT;
do
    echo "wait for jms_mysql ready"
    sleep 2s
done

while ! nc -z $REDIS_HOST $REDIS_PORT;
do
    echo "wait for jms_redis ready"
    sleep 2s
done

function cleanup()
{
    local pids=`jobs -p`
    if [[ "${pids}" != ""  ]]; then
        kill ${pids} >/dev/null 2>/dev/null
    fi
}

if [ ! -f "/opt/jumpserver/config.yml" ]; then
    echo > /opt/jumpserver/config.yml
fi

action="${1-start}"
service="${2-all}"

trap cleanup EXIT
if [[ "$action" == "bash" || "$action" == "sh" ]];then
    bash
else
    python /opt/jumpserver/jms "${action}" "${service}"
fi
