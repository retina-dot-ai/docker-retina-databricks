FROM ubuntu:20.04

MAINTAINER "Brad Ito" brad@retina.ai

# avoid interactive stops to installers
ENV DEBIAN_FRONTEND=noninteractive

# https://docs.databricks.com/clusters/custom-containers.html
# for base spark clusters: iproute2, bash, sudo, coreutils procps
# for dbfs: fuse
# to access clusters: openssh-server
# https://docs.azul.com/core/zulu-openjdk/install/debian#install-from-azul-apt-repository
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install --yes --no-install-recommends \
    bash \
    coreutils \
    curl \
    fuse \
    gnupg \
    iproute2 \
    openssh-server \
    procps \
    sudo \
  && apt-get install --yes wget \
  && apt-key adv \
    --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv-keys 0xB1998361219BD9C9 \
  && curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb \
  && apt-get install --yes ./zulu-repo_1.0.0-3_all.deb \
  && apt-get update --yes \
  && apt-get install --yes zulu8-jdk \
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
