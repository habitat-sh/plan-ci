# concourse-web

This habitat package consumes the concourse binaries made available by core/concourse.

### Dependent services:

* Postgresql (bound as "concoursedb": --bind concoursedb:postgresql.default --peer f.o.o.i.p)
* concourse-worker (No binding from web -> worker however concourse web cannot function without workers)


### Keys
The concourse cluster requires a subset of keys to be created and distributed amongst the cluster. As the keys are used for signing interactions between the web node and the worker nodes some of the keys need to be upload to both service groups. For local testing or other test deployments you can generate the keys by hand and upload them to the cluster like so:

```
  mkdir -p keys/web keys/worker
  ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
  ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''
  ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''
  cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
  cp ./keys/web/tsa_host_key.pub ./keys/worker

  sudo hab file upload concourse-web.default $(date +%s) ~/keys/web/authorized_worker_keys
  sudo hab file upload concourse-web.default $(date +%s) ~/keys/web/session_signing_key
  sudo hab file upload concourse-web.default $(date +%s) ~/keys/web/session_signing_key.pub
  sudo hab file upload concourse-web.default $(date +%s) ~/keys/web/tsa_host_key
  sudo hab file upload concourse-web.default $(date +%s) ~/keys/web/tsa_host_key.pub
  sudo hab file upload concourse-worker.default $(date +%s) ~/keys/worker/worker_key.pub
  sudo hab file upload concourse-worker.default $(date +%s) ~/keys/worker/worker_key
  sudo hab file upload concourse-worker.default $(date +%s) ~/keys/worker/tsa_host_key.pub
```

