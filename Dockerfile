### Single-cell analysis pipeline
# Installed tools: Seurat, scater, scImpute, velocyto, scanpy, sleepwalk, singleCellHaystack
# splatter is an R script and cannot be installed by command

FROM rnakato/anaconda3:2019.03
MAINTAINER Ryuichiro Nakato <rnakato@iam.u-tokyo.ac.jp>

ENV PACKAGES git vim htop gnupg emacs apt-file evince gedit eog build-essential ca-certificates zlib1g-dev liblapack3 libcurl4-openssl-dev bzip2 curl gawk libssl-dev make cmake unzip pigz imagemagick bowtie bowtie2 sra-toolkit openjdk-8-jdk-headless openjdk-8-jre gfortran liblapack-dev libblas-dev libhdf5-dev hdf5-helpers libboost-all-dev
ENV PACKAGES_CONDA numpy scipy cython numba matplotlib scikit-learn h5py click
ENV PACKAGES_PY scanpy python-igraph louvain velocyto

RUN apt update \
    && apt install -y --no-install-recommends ${PACKAGES} \
    && apt clean \
    && ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial.so.100 /usr/lib/x86_64-linux-gnu/libhdf5.so.100 \
    && ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial_hl.so.100 /usr/lib/x86_64-linux-gnu/libhdf5_hl.so.100
# R
# hdf5r failed due to the conda path
# configure from source
RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" >> /etc/apt/sources.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 51716619E084DAB9 \
    && apt update \
    && apt install -y --no-install-recommends r-base \
    && apt clean \
    && R CMD javareconf \
    && R -e "install.packages(c('Rcpp','devtools','BiocManager','igraph','sleepwalk','bit64'))" \
    && git clone https://github.com/hhoeflin/hdf5r \
    && cd hdf5r \
    && ./configure --with-hdf5=/usr/bin/h5cc \
    && R CMD INSTALL --no-configure . \
    && cd .. && rm -rf hdf5r \
    && R -e "BiocManager::install(c('Seurat','scater','tsne','Rtsne','pcaMethods'))" \
    && R -e "devtools::install_github(c('Vivianstats/scImpute', 'velocyto-team/velocyto.R', 'alexisvdb/singleCellHaystack'))" 
# Python
RUN conda install ${PACKAGES_CONDA} \
    && conda install ${PACKAGES_CONDA} \
    && conda install -c bioconda samtools \
    && pip install -U ${PACKAGES_PY} 

CMD ["/bin/bash"]
