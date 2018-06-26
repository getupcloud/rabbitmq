#!/bin/bash

if [ "${DEBUG}" == true ]; then
    set -x
fi

set -e

export $(cgroup-limits)
export RABBITMQ_MAX_MEMORY=$(($MEMORY_LIMIT_IN_BYTES / 1024 / 1024 / 100 * 90))

cp -fv /config/* /etc/rabbitmq/
for file in /etc/rabbitmq/*.in; do
    echo Generating ${file%.in}
    envsubst < $file > ${file%.in}
done

echo Starting rabbitmq
exec "$@"
