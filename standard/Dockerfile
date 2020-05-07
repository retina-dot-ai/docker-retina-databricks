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
  && rm -rf /tmp/* /var/tmp/*

# install python-apt via apt
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    python-apt \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY standard_install_packages.R /databricks/standard_install_packages.R
RUN R --no-save < /databricks/standard_install_packages.R \
  && rm -rf /tmp/* /var/tmp/*
