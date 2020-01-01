### Single-cell analysis pipeline for "Integrated analysis and regulation of cellular diversity"
# Installed tools: Seurat, Monocle3, scater, scImpute, velocyto, scanpy, sleepwalk, liger, RCA, scBio, SCENIC, singleCellHaystack, scmap, scran, slingshot

# splatter is an R script and cannot be installed by command
# https://github.com/MarioniLab/MNN2017/

FROM jupyter/datascience-notebook:1386e2046833
LABEL maintainer "Ryuichiro Nakato <rnakato@iam.u-tokyo.ac.jp>"

USER root

ENV PACKAGES_CONDA numpy numpy_groupies scipy pandas==0.23.4 cython numba matplotlib scikit-learn h5py click python-igraph louvain umap-learn
ENV PACKAGES_PY velocyto
#pyscenic

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-file \
    apt-utils \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    emacs \
    eog \
    evince \
    gawk \
    gedit \
    gfortran \
    git \
    gnupg \
    hdf5-helpers \
    htop \
    imagemagick \
    libblas-dev \
    libboost-all-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libgdal-dev \
    libglu1-mesa-dev \
    libhdf5-dev \
    liblapack3 \
    liblapack-dev \
    libssl-dev \
    libudunits2-dev \
    libx11-dev \
    make \
    openjdk-8-jdk-headless \
    openjdk-8-jre \
    pigz \
    sra-toolkit \
    unzip \
    vim \
    xorg \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial.so.100 /usr/lib/x86_64-linux-gnu/libhdf5.so.100 \
    && ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial_hl.so.100 /usr/lib/x86_64-linux-gnu/libhdf5_hl.so.100

# FFTW, FIt-SNE
RUN wget http://www.fftw.org/fftw-3.3.8.tar.gz \
    && tar zxvf fftw-3.3.8.tar.gz \
    && cd fftw-3.3.8 \
    && ./configure \
    && make \
    && make install \
    && git clone https://github.com/KlugerLab/FIt-SNE.git \
    && cd FIt-SNE/ \
    && g++ -std=c++11 -O3  src/sptree.cpp src/tsne.cpp src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm \
    && cp bin/fast_tsne /usr/local/bin/

# Python
RUN conda config --add channels conda-forge \
    && conda install ${PACKAGES_CONDA} \
    && conda install -c bioconda samtools scanpy \
    && pip install -U ${PACKAGES_PY}

# R
RUN R -e "install.packages(c('Rcpp','devtools','BiocManager','igraph','sleepwalk','bit64','zoo','hdf5r'), repos='https://cran.ism.ac.jp/')"

RUN ln -s /bin/tar /bin/gtar \
    && R -e "BiocManager::install(c('limma', 'Seurat','scater','tsne','Rtsne','pcaMethods','WGCNA','preprocessCore', 'RCA', 'scmap', 'mixtools', 'rbokeh', 'DT', 'NMF', 'pheatmap', 'R2HTML', 'doMC', 'doRNG', 'scran', 'slingshot'))" \
    && R -e "install.packages(c('scBio'), repos='https://cran.ism.ac.jp/')" \
    && R -e "devtools::install_github(c('Vivianstats/scImpute', 'MacoskoLab/liger', 'alexisvdb/singleCellHaystack', 'aertslab/SCopeLoomR'))"

# velocyto
RUN conda install -c statiskit libboost \
    && R -e "devtools::install_github('velocyto-team/velocyto.R')"

# monocle3
RUN conda install -c bioconda r-monocle3 \
    && R -e "install.packages(c('stringi'), repos='https://cran.ism.ac.jp/')"

# permission of work/
RUN chmod -R 775 /home/jovyan/work

RUN ln -s /opt/conda/pkgs/r-base-3*/lib/R/lib/libRlapack.so /opt/conda/lib
#ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/conda/pkgs/r-base-3.6.1-h9bb98a2_1/lib/R/lib/
USER jovyan

#RUN conda install r-units r-curl r-sf \
#    && R -e "BiocManager::install(c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats','S4Vectors', 'SingleCellExperiment','SummarizedExperiment', 'batchelor'))" \
#    && R -e "devtools::install_github('cole-trapnell-lab/leidenbase')" \
#    && R -e "devtools::install_github('cole-trapnell-lab/monocle3')"
