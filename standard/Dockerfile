FROM retina/databricks-dev-20-r:latest

MAINTAINER "Brad Ito" brad@retina.ai

COPY standard_requirements.txt /databricks/standard_requirements.txt
RUN conda activate $DATABRICKS_ROOT_CONDA_ENV \
  && conda install --no-update-deps -c conda-forge --no-channel-priority \
    --file /databricks/standard_requirements.txt \
  && pip install \
    ipython-genutils \
    jupyter-client \
    jupyter-core \
    ssh-import-id \
  && conda clean --all -f -y \
  && rm -rf /root/.cache /tmp/* /var/tmp/*

# install python-apt via apt
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    python-apt \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
    config \
    covr \
    crayon \
    crosstalk \
    curl \
    data.table \
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
    gridExtra \
    gsubfn \
    gtable \
    haven \
    highr \
    hms \
    httpuv \
    httr \
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
    mgcv \
    mime \
    ModelMetrics \
    modelr \
    munsell \
    nlme \
    nnet \
    numDeriv \
    openssl \
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
    # RODBC \
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
    sparklyr \
    spatial \
    sqldf \
    SQUAREM \
    stringi \
    stringr \
    survival \
    sys \
    TeachingDemos \
    testthat \
    tibble \
    tidyr \
    tidyselect \
    timeDate \
    tinytex \
    usethis \
    utf8 \
    vctrs \
    viridisLite \
    whisker \
    withr \
    xfun \
    xml2 \
    xopen \
    xtable \
    yaml
