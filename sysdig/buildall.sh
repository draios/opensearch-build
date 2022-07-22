#!/bin/bash
CONTAINER=builder:test
VERSION="1.3.4"

echo "<=== Removing old containers"
docker rm -f builder assembler
echo "<=== Start build phase"
mkdir -p $HOME/.gradle $HOME/.m2 $HOME/dist
docker run --name builder -ti -v $HOME/dist:/app/tar -v $(pwd)/../:/app/opensearch-build -v $HOME/.m2:/root/.m2 -v $HOME/.gradle:/root/.gradle ${CONTAINER} -- opensearch-build/build.sh opensearch-build/manifests/${VERSION}/opensearch-${VERSION}.yml --component=OpenSearch
echo "<=== Start assmebly phase"
docker run --name assembler -ti -v $(pwd)/../:/app/opensearch-build -v $HOME/.gradle:/root/.gradle -v $HOME/.m2:/root/.m2 ${CONTAINER} -- opensearch-build/assemble.sh opensearch-build/tar/builds/opensearch/manifest.yml
echo "<=== Exporting target files"
docker cp assembler:/app/tar/dist/opensearch/opensearch-${VERSION}-linux-x64.tar.gz .
echo "<=== Cleanup"
docker rm -f assembler builder