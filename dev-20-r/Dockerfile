FROM retina/databricks-dev-10-python:latest

MAINTAINER "Brad Ito" brad@retina.ai

ENV R_CRAN_REPO=https://mran.microsoft.com/snapshot/2021-09-08

# Install R 4.x
# https://cran.rstudio.com/bin/linux/ubuntu/#secure-apt
# - docopt used by littler
# - libxml2-dev libcurl4-openssl-dev libssl-dev libv8-dev used by tidyverse
# - netbase fixes https://github.com/snoyberg/http-client/issues/292
# - pandoc used for rmarkdown
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    software-properties-common \
    apt-transport-https \
  && apt-get install --yes --install-recommends \
    dirmngr \
  && wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
  && add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
  && apt-get update \
  && apt-get install --yes --no-install-recommends \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libv8-dev \
    libxml2-dev \
    littler \
    r-base \
    r-base-dev \
  && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
  && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
  && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
  && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
  && rm /usr/lib/R/etc/Rprofile.site \
  && echo "" > /usr/lib/R/etc/Rprofile.site \
  && echo "options(repos=c(CRAN='$R_CRAN_REPO'))" >> /usr/lib/R/etc/Rprofile.site \
  && echo "" >> /usr/lib/R/etc/Rprofile.site \
  && R -e "install.packages(c('docopt', 'remotes'))" \
  && add-apt-repository ppa:c2d4u.team/c2d4u4.0+ \
  && apt-get update \
  && apt-get install --yes --no-install-recommends r-cran-tidyverse \
  && apt-get install --yes --no-install-recommends r-cran-rstan \
  && apt-get install --yes \
    netbase \
    pandoc \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install basic and commonly-used R packages from a recent MRAN snapshot
# as well as spark/databricks dependencies
# - Rserve (allows Spark to communicate with a local R process)
# - hwriterPlus is used by databricks to render html
#   but the package was removed by its author from CRAN
#   so we install it from an old MRAN snapshot
# - htmltools (used by databricks notebooks to render html)
#  install a specific version of htmltools
# SparkR will be loaded by databricks in /databricks/spark/R/lib
RUN install2.r --error \
    htmltools \
    htmlwidgets \
    Rserve \
  && install2.r --error \
    --repos=https://mran.microsoft.com/snapshot/2017-02-26 hwriterPlus \
  && rm -rf /tmp/* /var/tmp/*
