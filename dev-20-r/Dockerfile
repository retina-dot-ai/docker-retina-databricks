FROM retina/databricks-dev-10-python:latest

MAINTAINER "Brad Ito" brad@retina.ai

ENV R_CRAN_REPO=https://mran.microsoft.com/snapshot/2020-04-07

# Ubuntu 16.04.3 LTS installs R version 3.2.3 by default. This is fairly out dated.
# We add RStudio's debian source to install the latest r-base version (3.6.0)
# We are using the more secure long form of pgp key ID of marutter@gmail.com
# based on these instructions (avoiding firewall issue for some users):
# https://cran.rstudio.com/bin/linux/ubuntu/#secure-apt
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    software-properties-common \
    apt-transport-https \
  && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
  && gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | apt-key add - \
  && add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/' \
  && apt-get install --yes --no-install-recommends \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    r-base \
    r-base-dev \
  && add-apt-repository -r 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/' \
  && apt-key del E298A3A825C0D65DFD57CBB651716619E084DAB9 \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY install_packages.R /databricks/install_packages.R

RUN R --no-save < /databricks/install_packages.R \
  && rm -rf /tmp/* /var/tmp/*
