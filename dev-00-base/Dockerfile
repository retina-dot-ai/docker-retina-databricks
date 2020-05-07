FROM ubuntu:16.04

MAINTAINER "Brad Ito" brad@retina.ai

# avoid interactive stops to installers
ENV DEBIAN_FRONTEND=noninteractive

# https://docs.databricks.com/clusters/custom-containers.html
# for base spark clusters: openjdk-8-jdk, iproute2, bash, sudo, coreutils procps
# for dbfs: fuse
# to access clusters: openssh-server
RUN apt-get update \
  && apt-get upgrade -y \
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
  && sed -i -e 's/mesg n .*true/tty -s \&\& mesg n/g' ~/.profile \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Make sure the USER env variable is set. The files exposed
# by dbfs-fuse will be owned by this user.
# Within the container, the USER is always root.
ENV USER root

# Warning: the created user has root permissions inside the container
# Warning: you still need to start the ssh process with `sudo service ssh start`
RUN useradd --create-home --shell /bin/bash --groups sudo ubuntu
