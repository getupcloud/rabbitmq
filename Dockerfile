FROM rabbitmq:management

WORKDIR /data

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/src/

ENTRYPOINT ["/usr/src/entrypoint.sh"]

CMD ["rabbitmq-server"]
