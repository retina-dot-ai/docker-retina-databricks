FROM retina/databricks-dev-10-python:latest

ARG R_CRAN_REPO=https://mran.microsoft.com/snapshot/2020-04-01

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
  && gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add - \
  && add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/' \
  && apt-get update \
  && apt-get install --yes --no-install-recommends \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    littler \
    r-base \
  && add-apt-repository -r 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/' \
  && apt-key del E298A3A825C0D65DFD57CBB651716619E084DAB9 \
  && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
  && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
  && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
  && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
  && install.r docopt \
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
RUN install2.r --error --repos=$R_CRAN_REPO \
    tidyverse \
    htmlwidgets \
    Rserve \
    sparklyr \
  && install2.r --error \
    --repos=https://mran.microsoft.com/snapshot/2017-02-26 hwriterPlus \
  && install2.r --error \
    --repos=$R_CRAN_REPO htmltools
