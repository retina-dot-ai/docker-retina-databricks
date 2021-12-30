FROM retina/databricks-dev-20-r:latest

MAINTAINER "Brad Ito" brad@retina.ai

COPY standard_requirements.txt /databricks/standard_requirements.txt
RUN conda activate $DATABRICKS_ROOT_CONDA_ENV \
  && conda install --no-update-deps \
    --file /databricks/standard_requirements.txt \
  && pip install \
    ipython-genutils \
    jupyter-client \
    jupyter-core \
    ssh-import-id \
  && conda clean --all \
  && rm -rf /root/.cache /tmp/* /var/tmp/*

# install python-apt via apt
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    python-apt \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install other R packages to match databricks runtime
# https://docs.databricks.com/release-notes/runtime/9.1.html#installed-r-libraries
RUN install2.r --error --repos=$R_CRAN_REPO \
    askpass \
    assertthat \
    backports \
    bit \
    bit64 \
    blob \
    boot \
    brew \
    brio \
    broom \
    bslib \
    cachem \
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
    cpp11 \
    crayon \
    credentials \
    curl \
    data.table \
    dbplyr \
    DBI \
    desc \
    devtools \
    diffobj \
    digest \
    dplyr \
    dtplyr \
    ellipsis \
    evaluate \
    fansi \
    fastmap \
    forcats \
    foreach \
    foreign \
    forge \
    fs \
    future \
    future.apply \
    gargle \
    generics \
    gert \
    ggplot2 \
    gh \
    gitcreds \
    glmnet \
    globals \
    glue \
    googledrive \
    googlesheets4 \
    gower \
    gridExtra \
    gsubfn \
    gtable \
    haven \
    highr \
    hms \
    httpuv \
    httr \
    ids \
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
    parallelly \
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
    sass \
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
    uuid \
    vctrs \
    viridisLite \
    vroom \
    waldo \
    whisker \
    withr \
    xfun \
    xml2 \
    xopen \
    xtable \
    yaml \
    zip
