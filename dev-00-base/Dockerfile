FROM ubuntu:16.04

MAINTAINER "Brad Ito" brad@retina.ai

# for base spark clusters: openjdk-8-jdk, iproute2, bash, sudo, coreutils procps
# for dbfs: fuse
# to access clusters: openssh-server
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    openjdk-8-jdk \
    iproute2 \
    bash \
    sudo \
    coreutils \
    procps \
    fuse \
    openssh-server \
  && /var/lib/dpkg/info/ca-certificates-java.postinst configure \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
