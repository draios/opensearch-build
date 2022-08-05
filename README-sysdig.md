1. install docker: `apt update && apt install docker.io`
2. `git clone https://github.com/draios/opensearch-build.git`
3. `git checkout feat/local_builder-1.3.5` (or other branch)
4. `cd ~/opensearch-build`
2. build image: `docker build -f ./docker/ci/dockerfiles/current/sysdig-builder.dockerfile . -t docker.internal.sysdig.com/utils/opensearch-builder:sysdig -t
 builder:test`
3. build with `cd sysdig ; ./buildall.sh`
