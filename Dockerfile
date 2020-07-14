FROM rnakato/singlecell_jupyter:1.3.0
LABEL maintainer "Ryuichiro Nakato <rnakato@iam.u-tokyo.ac.jp>"

USER root
WORKDIR /opt

#RUN apt-get update \
#    && apt-get install -y --no-install-recommends \
#    libgmp3-dev \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*

#RUN pip install -U pip

# SingleR
RUN R -e "BiocManager::install('SingleR')"
