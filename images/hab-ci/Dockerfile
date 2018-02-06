FROM alpine:3.6
MAINTAINER The Habitat Maintainers <humans@habitat.sh>
#ARG HAB_VERSION=
RUN set -ex \
  && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    gnupg \
    libressl \
    wget \
  \
  && cd /tmp \
  && wget https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh \
  && sh install.sh \
  && rm -rf install.sh /hab/cache \
  && apk del .build-deps \
  \
  && apk add --no-cache ncurses-terminfo-base \
  \
  && echo "hab:x:42:42:root:/:/bin/sh" >> /etc/passwd \
  && echo "hab:x:42:hab" >> /etc/group

RUN hab pkg install core/hab-launcher core/hab-sup core/cacerts
RUN hab pkg install --binlink core/bash

WORKDIR /src
VOLUME ["/src"]
CMD ["/bin/hab"]
