# docker-retina-databricks

Docker images for use with
[Databricks Container Services](https://docs.databricks.com/clusters/custom-containers.html)

This repo contains the code used to create a custom containers with full support for:

- Python (including pip and [conda](https://docs.conda.io/en/latest/miniconda.html))
- R (with default usage of [MRAN](https://mran.microsoft.com/documents/rro/reproducibility))
- Scala
- Java and Jar files
- DBFS mounts
- ssh

These containers are built upon ubuntu for practical extension, and try to use the latest versions of dependencies that will work with the Databricks Runtime 6.x.

# Images:

* [retina/databricks-minimal](https://hub.docker.com/r/retina/databricks-minimal) installs just the basics to be able to run notebooks.  For Python, this includes pandas and numpy.  For R, it includes the tidyverse.
* [retina/databricks-standard](https://hub.docker.com/r/retina/databricks-standard) adds basic dependencies aimed at bringing parity with the out-of-the-box Databricks Runtime 6.x

### Notes:

This builds upon the [Databricks example containers](https://github.com/databricks/containers) in order to standardize multi-language support, and use more current dependencies.


