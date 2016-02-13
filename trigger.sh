#!/bin/bash

TAG=${1:-latest}

if [ -z "$DOCKER_ASPACE_TRIGGER_TOKEN" ]; then
  echo "DOCKER_ASPACE_TRIGGER_TOKEN is unset"
  exit 1
fi

curl \
  -H "Content-Type: application/json" \
  --data '{"docker_tag": "'"${TAG}"'"}' \
  -X POST \
  https://registry.hub.docker.com/u/lyrasis/archivesspace/trigger/${DOCKER_ASPACE_TRIGGER_TOKEN}/
