FROM retina/databricks-dev-10-python:latest

MAINTAINER "Brad Ito" brad@retina.ai

ARG R_CRAN_REPO=https://mran.microsoft.com/snapshot/2020-04-07

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
    r-base-dev \
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
    htmltools \
    htmlwidgets \
    Rserve \
    sparklyr \
  && install2.r --error \
    --repos=https://mran.microsoft.com/snapshot/2017-02-26 hwriterPlus

# install other R packages to match databricks runtime
# https://docs.databricks.com/release-notes/runtime/7.0.html#installed-r-libraries
RUN install2.r --error --repos=$R_CRAN_REPO \
    askpass \
    assertthat \
    backports \
    BH \
    bit \
    bit64 \
    blob \
    boot \
    brew \
    broom \
    callr \
    caret \
    cellranger \
    chron \
    class \
    cli \
    clipr \
    cluster \
    codetools \
    colorspace \
    commonmark \
    compiler \
    config \
    covr \
    crayon \
    crosstalk \
    curl \
    data.table \
    datasets \
    dbplyr \
    DBI \
    desc \
    devtools \
    digest \
    dplyr \
    DT \
    ellipsis \
    evaluate \
    fansi \
    fastmap \
    forcats \
    foreach \
    foreign \
    forge \
    fs \
    generics \
    ggplot2 \
    gh \
    git2r \
    glmnet \
    globals \
    glue \
    gower \
    graphics \
    grDevices \
    grid \
    gridExtra \
    gsubfn \
    gtable \
    haven \
    highr \
    hms \
    httpuv \
    httr \
    hwriter \
    hwriterPlus \
    ini \
    ipred \
    isoband \
    iterators \
    jsonlite \
    KernSmooth \
    knitr \
    labeling \
    later \
    lattice \
    lava \
    lazyeval \
    lifecycle \
    lubridate \
    magrittr \
    markdown \
    MASS \
    Matrix \
    memoise \
    methods \
    mgcv \
    mime \
    ModelMetrics \
    modelr \
    munsell \
    nlme \
    nnet \
    numDeriv \
    openssl \
    parallel \
    pillar \
    pkgbuild \
    pkgconfig \
    pkgload \
    plogr \
    plyr \
    praise \
    prettyunits \
    pROC \
    processx \
    prodlim \
    progress \
    promises \
    proto \
    ps \
    purrr \
    r2d3 \
    R6 \
    randomForest \
    rappdirs \
    rcmdcheck \
    RColorBrewer \
    Rcpp \
    readr \
    readxl \
    recipes \
    rematch \
    rematch2 \
    remotes \
    reprex \
    reshape2 \
    rex \
    rjson \
    rlang \
    rmarkdown \
    RODBC \
    roxygen2 \
    rpart \
    rprojroot \
    RSQLite \
    rstudioapi \
    rversions \
    rvest \
    scales \
    selectr \
    shiny \
    sourcetools \
    spatial \
    splines \
    sqldf \
    SQUAREM \
    stats \
    stats4 \
    stringi \
    stringr \
    survival \
    sys \
    tcltk \
    TeachingDemos \
    testthat \
    tibble \
    tidyr \
    tidyselect \
    timeDate \
    tinytex \
    tools \
    usethis \
    utf8 \
    utils \
    vctrs \
    viridisLite \
    whisker \
    withr \
    xfun \
    xml2 \
    xopen \
    xtable \
    yaml
