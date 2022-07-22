#!/bin/bash
CONTAINER=docker.internal.sysdig.com/utils/opensearch-builder:sysdig
VERSION="1.3.4"

echo "<=== Removing old containers"
docker rm -f builder assembler
echo "<=== Start build phase"
mkdir -p $HOME/.gradle $HOME/.m2 $HOME/dist
docker run --name builder -ti -v $HOME/dist:/app/tar -v $(pwd)/../:/app/opensearch-build -v $HOME/.m2:/root/.m2 -v $HOME/.gradle:/root/.gradle ${CONTAINER} -- opensearch-build/build.sh opensearch-build/manifests/${VERSION}/opensearch-${VERSION}.yml --component=OpenSearch
echo "<=== Copy target files"
docker cp builder:/app/tar/builds/opensearch/maven/org/opensearch/opensearch/${VERSION}/opensearch-${VERSION}.jar .
echo "<=== Cleanup"
#docker rm -f assembler builder