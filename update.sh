#!/bin/bash
# TODO: improve this script

IMAGE_NAME="jointly/php"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


cd ${DIR}/7.3/cli/
docker build . -t ${IMAGE_NAME}:7.3-cli
docker push ${IMAGE_NAME}:7.3-cli

docker push ${IMAGE_NAME}:7.4-cli
cd ${DIR}/7.4/cli/
docker build . -t ${IMAGE_NAME}:7.4-cli

docker push ${IMAGE_NAME}:8.0-cli
cd ${DIR}/8.0/cli/
docker build . -t ${IMAGE_NAME}:8.0-cli
