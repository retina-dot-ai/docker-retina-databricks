R_CRAN_REPO <- Sys.getenv("R_CRAN_REPO")
print(paste0("R_CRAN_REPO=", R_CRAN_REPO))

install.packages(
  c(
    "tidyverse",
    "htmltools",      # used by databricks notebooks
    "htmlwidgets",    # used by databricks notebooks
    "Rserve"          # used by databricks
  ),
  repos=R_CRAN_REPO,
  dependencies=c("Depends", "Imports", "LinkingTo"),
  clean=TRUE)

# install a specific version of this
install.packages(
  "hwriterPlus",
  repos="https://mran.microsoft.com/snapshot/2017-02-26",
  dependencies=c("Depends", "Imports", "LinkingTo"),
  clean=TRUE)
