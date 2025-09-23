# Archived Repository

This repository has been archived and will no longer receive updates. 
It was archived as part of the [Repository Standardization Initiative](https://github.com/chef-boneyard/oss-repo-standardization-2025).
If you are a Chef customer and need support for this repository, please contact your Chef account team.

# Plan-CI
This repo holds most of the image definitions used in the Habitat team's Concourse CI instance for testing core-plans as well as the habitat plans for the concourse front end and worker services.


## Images
The images in this repository and their functions are listed below.

### Hab-Delmo
The `hab-delmo` image is the container definition for the "Test" phase of the Habitat team's functional testing pipeline for core-plans. This definition contains a single script: "entrypoint" that handles both the execution of the test harness and creation of notification messages concourse can consume with a slack resource.

### Hab-CI
The `hab-ci` image is the container definition for a generic/lightweight docker container that is built from alpine linux and contains the habitat binary. This image is consumed by any CI driven test harness in the Habitat team's functional testing pipeline and is intended to be usable for any functional testing of habitat packages. Consuming this image in your habitat package's test harness is done via docker-compose.yml and might look like so:

```
services:
  standalone:
    image: habitat/hab-ci
    command: "hab start eeyun/consul"
    expose:
      - "52"
      - "4443"
      - "8400"
    environment:
      HAB_CONSUL: |
        bootstrap_expect=1
      HAB_BLDR_CHANNEL: "unstable"
  consul1:
    image: habiat/hab-ci
    command: "hab start eeyun/consul --group cluster --peer standalone"
    expose:
      - "52"
      - "4443"
      - "8400"
    environment:
      HAB_CONSUL: |
        bootstrap_expect=3
```
### Docker-Machine-Setup
The `docker-machine-setup` image is consumed by the Habitat team's functional testing pipeline for core-plans. It is used to spin up and destroy a docker API in AWS for use in the 'Test' phase of the pipeline. The docker-api it creates is then used by delmo when it spins up clusters of services to test.


## Plans
The plans used to start the concourse services and their functions are listed below

### concourse-web
The `concourse web` package wraps the core/concourse package and uses the binary to turn on the front end of a concourse cluster. For more information view the README.md in the `concourse-web` directory.

### concourse-worker
The `concourse-worker` package wraps the core/concourse package and uses the binary to turn on worker nodes of a concourse cluster. For more information view the README.md in the `concourse-worker` directory.
