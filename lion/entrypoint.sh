#!/bin/bash
#

sleep 5s
while [ "$(curl -I -m 10 -o /dev/null -s -w %{http_code} ${CORE_HOST}/api/health/)" != "200" ]
do
    echo "wait for jms_core $CORE_HOST ready"
    sleep 2
done

if [ ! $GUACD_LOG_LEVEL ]; then
    export GUACD_LOG_LEVEL=debug
else
    export GUACD_LOG_LEVEL=${GUACD_LOG_LEVEL,,}
fi

exec /usr/bin/supervisord