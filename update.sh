#!/bin/bash

IMAGE_NAME="jointly/php"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for VERSION in *; do
    if [ -d "${VERSION}" ]; then
        echo "${VERSION}" # your processing here

        cd ${DIR}/${VERSION}/cli/
        docker build . -t ${IMAGE_NAME}:${VERSION}-cli
        docker push ${IMAGE_NAME}:${VERSION}-cli

        cd -
    fi
done