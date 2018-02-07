# concourse-worker
This habitat package consumes the concourse binaries made available by core/concourse.

### Dependent Services

* concourse-web (bound as "web" `--bind web:concourse-web.default --peer 127.0.0.1`)

### Keys
**THERE ARE KEYS REQUIRED FOR THIS TO RUN**. These keys should be generated once and distributed into the cluster. For instructions on how to do this, please read https://github.com/habitat-sh/plan-ci/blob/master/concourse-web/README.md

### Notes
The concourse-worker package _must_ be run as root - the reason being that the worker process has to escape the habitat service dir to be able to spin up containers. It writes those runc processes and files into /opt/concourse and /opt/concourse/worker. The init hook will create these directories on the filesystem when the service starts.
