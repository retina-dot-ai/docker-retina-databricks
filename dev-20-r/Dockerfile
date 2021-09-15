FROM retina/databricks-dev-10-python:latest

MAINTAINER "Brad Ito" brad@retina.ai

ENV R_CRAN_REPO=https://mran.microsoft.com/snapshot/2020-07-14

# We add RStudio's debian source to install the latest r-base version (3.6.0)
# We are using the more secure long form of pgp key ID of marutter@gmail.com
# based on these instructions (avoiding firewall issue for some users):
# https://cran.rstudio.com/bin/linux/ubuntu/#secure-apt
# https://cran.r-project.org/bin/linux/ubuntu/README.html
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    software-properties-common \
    apt-transport-https \
  && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
  && gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | apt-key add - \
  && add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' \
  && apt-get upgrade --yes \
  && apt-get install --yes \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    r-base \
    r-base-core \
    r-base-dev \
    r-recommended \
    r-base-html \
    littler \
    r-cran-littler \
  && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
  && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
  && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
  && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
  && rm /usr/lib/R/etc/Rprofile.site \
  && echo "" > /usr/lib/R/etc/Rprofile.site \
  && echo "options(repos=c(CRAN='$R_CRAN_REPO'))" >> /usr/lib/R/etc/Rprofile.site \
  && echo "" >> /usr/lib/R/etc/Rprofile.site \
  && R -e "install.packages(c('docopt', 'remotes'))" \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install basic and commonly-used R packages from a recent MRAN snapshot
# as well as spark/databricks dependencies
# - docopt used by littler
# - Rserve (allows Spark to communicate with a local R process)
# - hwriterPlus is used by databricks to render html
#   but the package was removed by its author from CRAN
#   so we install it from an old MRAN snapshot
# - htmltools (used by databricks notebooks to render html)
#  install a specific version of htmltools
# SparkR will be loaded by databricks in /databricks/spark/R/lib
RUN install2.r --error \
    tidyverse \
    htmltools \
    htmlwidgets \
    Rserve \
  && install2.r --error \
    --repos=https://mran.microsoft.com/snapshot/2017-02-26 hwriterPlus \
  && rm -rf /tmp/* /var/tmp/*
