### Single-cell analysis pipeline for "Integrated analysis and regulation of cellular diversity"
# Installed tools: Seurat, Monocle3, scater, scImpute, velocyto, scanpy, sleepwalk, liger, RCA, scBio, (py)SCENIC, singleCellHaystack, scmap, scran

# splatter is an R script and cannot be installed by command
# https://github.com/MarioniLab/MNN2017/

FROM rnakato/anaconda3:2019.03
LABEL maintainer "Ryuichiro Nakato <rnakato@iam.u-tokyo.ac.jp>"

ENV PACKAGES_CONDA numpy scipy pandas==0.23.4 cython numba matplotlib scikit-learn h5py click
ENV PACKAGES_PY scanpy python-igraph louvain velocyto pyscenic

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
    libcurl4-openssl-dev \
    libgdal-dev \
    libhdf5-dev \
    liblapack3 \
    liblapack-dev \
    libssl-dev \
    libudunits2-dev \
    make \
    openjdk-8-jdk-headless \
    openjdk-8-jre \
    pigz \
    sra-toolkit \
    unzip \
    vim \
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
# R
# hdf5r failed due to the conda path
# configure from source
RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" >> /etc/apt/sources.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 51716619E084DAB9 \
    && apt-get update \
    && apt-get install -y --no-install-recommends r-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && R CMD javareconf \
    && R -e "install.packages(c('Rcpp','devtools','BiocManager','igraph','sleepwalk','bit64','scBio','zoo'))" \
    && git clone https://github.com/hhoeflin/hdf5r \
    && cd hdf5r \
    && ./configure --with-hdf5=/usr/bin/h5cc \
    && R CMD INSTALL --no-configure . \
    && cd .. && rm -rf hdf5r \
    && R -e "BiocManager::install(c('Seurat','scater','tsne','Rtsne','pcaMethods','WGCNA','preprocessCore', 'RCA', 'scmap', 'mixtools', 'rbokeh', 'DT', 'NMF', 'pheatmap', 'R2HTML', 'doMC', 'doRNG', 'scran'))" \
    && R -e "devtools::install_github(c('cole-trapnell-lab/monocle3', 'Vivianstats/scImpute', 'velocyto-team/velocyto.R', 'MacoskoLab/liger', 'alexisvdb/singleCellHaystack', 'aertslab/SCopeLoomR'))"
# Python
RUN conda install ${PACKAGES_CONDA} \
    && conda install ${PACKAGES_CONDA} \
    && conda install -c bioconda samtools \
    && pip install -U ${PACKAGES_PY}

CMD ["/bin/bash"]
