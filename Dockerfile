FROM rabbitmq:3

WORKDIR /data

RUN apt-get update \
    && apt-get install -y curl gettext erlang-base-hipe \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/src/
COPY cgroup-limits  /usr/bin/cgroup-limits 

ENTRYPOINT ["/usr/src/entrypoint.sh"]
