#!/bin/bash

if [ "${DEBUG}" == true ]; then
    set -x
fi

set -e

export $(cgroup-limits)
export RABBITMQ_MAX_MEMORY=$(($MEMORY_LIMIT_IN_BYTES / 100 * 40))
export RABBITMQ_DISK_FREE_LIMIT_ABSOLUTE=1GB

cp -fv /config/* /etc/rabbitmq/
for file in /etc/rabbitmq/*.in; do
    echo === Generating ${file%.in}
    envsubst < $file > ${file%.in}
    cat ${file%.in}
    echo -e "\n=== End of ${file%.in}"
done

RABBIT_COOKIE=${RABBIT_COOKIE:-rabbitmqcookie}
echo ${RABBIT_COOKIE} > /var/lib/rabbitmq/.erlang.cookie
chmod 600 /var/lib/rabbitmq/.erlang.cookie

echo Starting rabbitmq
exec "$@"
