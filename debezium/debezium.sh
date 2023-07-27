#!/usr/bin/env bash

docker run -d \
  --name debezium \
  -p 8083:8083 \
  -e GROUP_ID=1 \
  -e CONFIG_STORAGE_TOPIC=my-connect-configs  \
  -e OFFSET_STORAGE_TOPIC=my-connect-offsets \
  -e ADVERTISED_HOST_NAME="$(echo $DOCKER_HOST | cut -f3  -d'/' | cut -f1 -d':')" \
  -v /etc/localtime:/etc/localtime:ro \
  --restart=unless-stopped \
  --network my-services \
  debezium/connect:2.3

