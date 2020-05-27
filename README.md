# docker-retina-databricks

Docker images for use with
[Databricks Container Services](https://docs.databricks.com/clusters/custom-containers.html)

This repo contains the code used to create a custom containers with full support for:

- Python
  * with [conda](https://docs.conda.io/en/latest/miniconda.html) configured to use the default and [conda-forge](https://anaconda.org/conda-forge) channels
- R
  * with [MRAN](https://mran.microsoft.com/documents/rro/reproducibility) to lock package versions by date
  * with [littler](https://cran.r-project.org/web/packages/littler/vignettes/littler-examples.html) for simpler command-line installation of R packages
- Scala
- Java and Jar files
- DBFS mounts
- ssh

These containers are built upon ubuntu, and try to use the latest versions of dependencies that will work with the Databricks Runtime 6.x.  Note that the "ML" versions of the databricks runtime do not currently work with custom
docker containers such as these.

Not yet implemented:

- Ganglia

# Images:

* [retina/databricks-minimal](https://hub.docker.com/r/retina/databricks-minimal) installs just the basics to be able to run notebooks.  For Python, this includes pandas and numpy.  For R, it includes the tidyverse.
* [retina/databricks-standard](https://hub.docker.com/r/retina/databricks-standard) adds standard dependencies aimed at bringing parity with the out-of-the-box Databricks Runtime 6.x

### Notes:

- This builds upon the [Databricks example containers](https://github.com/databricks/containers) in order to standardize multi-language support (install R by default), and use more current dependencies.
- when installing Python packages in child containers, be sure to use `conda activate $DATABRICKS_ROOT_CONDA_ENV` in your Dockerfile
- Spark 2.x is not compatible with Python 3.8, so these images use Python 3.7

