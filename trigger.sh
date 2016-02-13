#!/bin/bash

TAG=${1:-master}
DATA="'{\"docker_tag\": \"${TAG}\"}'"

if [ -z "$DOCKER_ASPACE_TRIGGER_TOKEN" ]; then
  echo "DOCKER_ASPACE_TRIGGER_TOKEN is unset"
  exit 1
fi

curl \
  -H "Content-Type: application/json" \
  --data $DATA \
  -X POST \
  https://registry.hub.docker.com/u/lyrasis/archivesspace/trigger/${DOCKER_ASPACE_TRIGGER_TOKEN}/
