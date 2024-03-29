FROM ubuntu:20.04 as builder

ARG CONDA_VERSION=4.10.3

RUN apt-get update \
  && apt-get install --yes \
  wget \
  libdigest-sha-perl \
  bzip2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download miniconda, then upgrade it to the user-specified version
# https://docs.conda.io/en/latest/miniconda.html#linux-installers
# TODO upgrade python and pip and such to latest, to avoid deleting later
RUN wget --quiet --output-document miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh \
  && (echo '935d72deb16e42739d69644977290395561b7a6db059b316958d97939e9bdf3d  miniconda.sh' | shasum -a 256 -c) \
  # Conda must be installed at /databricks/conda
  && /bin/bash miniconda.sh -b -p /databricks/conda \
  && rm miniconda.sh \
  && /databricks/conda/bin/conda install --name base conda=${CONDA_VERSION} python=3.8.12 \
  && /databricks/conda/bin/conda update -n base -c defaults conda \
  && /databricks/conda/bin/conda clean --all

FROM retina/databricks-dev-00-base:latest

MAINTAINER "Brad Ito" brad@retina.ai

COPY --from=builder /databricks/conda /databricks/conda

# switch from /bin/sh to /bin/bash for following shell commands
SHELL ["/bin/bash", "-c", "-l"]

# This environment variable must be set to indicate the conda environment to activate.
# Note that currently, we have to set both of these environment variables. The first one is necessary to indicate that this runtime supports conda.
# The second one is necessary so that the python notebook/repl can be started (won't work without it)
ENV DEFAULT_DATABRICKS_ROOT_CONDA_ENV=retina-databricks
ENV DATABRICKS_ROOT_CONDA_ENV=retina-databricks

# Install conda environment and link it
COPY environment.yml /databricks/.conda-env-def/environment.yml
RUN /databricks/conda/bin/conda env create --file /databricks/.conda-env-def/environment.yml \
  # Source conda.sh for all login shells.
  && ln -s /databricks/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
  # Set always_yes to avoid needing -y flags, and improve conda experience in Databricks notebooks.
  && /databricks/conda/bin/conda config --system --set always_yes True \
  && /databricks/conda/bin/conda init bash \
  && source ~/.bashrc \
  && /databricks/conda/bin/conda clean --all \
  && rm -rf /root/.cache /tmp/* /var/tmp/*

RUN conda activate $DATABRICKS_ROOT_CONDA_ENV \
  && conda config --append channels conda-forge \
  && conda deactivate
