FROM retina/databricks-dev-00-base:latest

MAINTAINER "Brad Ito" brad@retina.ai

RUN mkdir -p /databricks/python/bin \
  && apt-get update \
  && apt-get install --yes --no-install-recommends \
    python3-pip \
    software-properties-common \
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt-get update \
  && apt-get install --yes --no-install-recommends \
    python3.7 \
  && python3.7 -m pip install --upgrade pip \
  && update-alternatives --install /usr/local/bin/python python /usr/bin/python3.7 1 \
  && ln -s /usr/local/bin/python /databricks/python/bin/python \
  && ln -s /usr/local/bin/pip /databricks/python/bin/pip \
  && apt-get remove --yes python3 python5.3 \
  && apt-get clean \
  && rm -rf /root/.cache /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY requirements.txt /databricks/requirements.txt
RUN pip install setuptools wheel \
  && pip install -r /databricks/requirements.txt \
  && rm -rf /tmp/* /var/tmp/*

# pyarrow: 0.15.0 breaks the streaming protocol used with Spark
# https://arrow.apache.org/blog/2019/10/06/0.15.0-release/
# IMPORTANT: use this so that Spark works with pyarrow
ENV ARROW_PRE_0_15_IPC_FORMAT=1
