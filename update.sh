#!/bin/bash
# TODO: improve this script

IMAGE_NAME="mattiabasone/php"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


cd ${DIR}/5.6/cli/
docker build . -t ${IMAGE_NAME}:5.6-cli
docker push ${IMAGE_NAME}:5.6-cli

cd ${DIR}/7.1/cli/
docker build . -t ${IMAGE_NAME}:7.1-cli
docker push ${IMAGE_NAME}:7.1-cli

cd ${DIR}/7.2/cli/
docker build . -t ${IMAGE_NAME}:7.2-cli
docker push ${IMAGE_NAME}:7.2-cli

cd ${DIR}/7.3/cli/
docker build . -t ${IMAGE_NAME}:7.3-cli
docker push ${IMAGE_NAME}:7.3-cli