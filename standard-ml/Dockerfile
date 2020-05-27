FROM retina/databricks-dev-20-r:latest
MAINTAINER "Brad Ito" brad@retina.ai

# this container mimics the packages available in
# Databricks Runtime 7.0 ML
# https://docs.databricks.com/release-notes/runtime/7.0ml.html

COPY ml-environment.yml /databricks/.conda-env-def/ml-environment.yml
RUN /databricks/conda/bin/conda env create --file /databricks/.conda-env-def/ml-environment.yml \
  && /databricks/conda/bin/conda clean --all \
  && rm -rf /root/.cache /tmp/* /var/tmp/*

# override the environment variables for the anaconda env name
ENV DEFAULT_DATABRICKS_ROOT_CONDA_ENV=databricks-ml
ENV DATABRICKS_ROOT_CONDA_ENV=databricks-ml

RUN conda activate $DATABRICKS_ROOT_CONDA_ENV \
  && conda config --append channels conda-forge \
  && conda config --append channels pytorch \
  && conda deactivate
