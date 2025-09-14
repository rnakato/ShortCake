FROM rnakato/shortcake_seurat:3.4.0
LABEL maintainer="Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"

USER root
WORKDIR /opt

ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    libgmp-dev \
    libglpk-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV Ncpus=16
# metaboliteIDmapping: for OmnipathR and lianna
COPY howmany_0.3-1.tar.gz howmany_0.3-1.tar.gz
RUN R CMD INSTALL howmany_0.3-1.tar.gz \
    && rm howmany_0.3-1.tar.gz

RUN R -e 'devtools::install_version("dbplyr", version = "2.3.4")' \
    && R -e "remotes::install_github(c('bokeh/rbokeh'))" \
    && R -e "BiocManager::install(c('BioQC', \
                                    'beachmat', \
                                    'celldex', \
                                    'clusterExperiment', \
                                    'clusterProfiler', \
                                    'DelayedArray', \
                                    'DelayedMatrixStats', \
                                    'DESeq2', \
                                    'doMC', \
                                    'doRNG', \
                                    'DropletUtils', \
                                    'DT', \
                                    'limma', \
                                    'MAST', \
                                    'tanaylab/metacell', \
                                    'metaboliteIDmapping' , \
                                    'mixtools', \
                                    'NMF', \
                                    'pcaMethods', \
                                    'pheatmap', \
                                    'preprocessCore', \
                                    'R2HTML', \
                                    'rbokeh', \
                                    'RCA', \
                                    'SC3', \
                                    'scater', \
                                    'scmap', \
                                    'scran', \
                                    'scRNAseq', \
                                    'scTensor', \
                                    'SingleCellExperiment', \
                                    'slingshot', \
                                    'splatter', \
                                    'stringi', \
                                    'sva', \
                                    'WGCNA'))" \
    && R -e "BiocManager::install(c('tricycle', \
                                    'SingleCellSignalR'))" \
    && R -e "BiocManager::install(c('BSgenome.Hsapiens.UCSC.hg19', \
                                    'BSgenome.Hsapiens.UCSC.hg38', \
                                    'BSgenome.Mmusculus.UCSC.mm10', \
                                    'BSgenome.Mmusculus.UCSC.mm39', \
                                    'BSgenome.Dmelanogaster.UCSC.dm6', \
                                    'BSgenome.Drerio.UCSC.danRer10', \
                                    'BSgenome.Celegans.UCSC.ce10', \
                                    'BSgenome.Celegans.UCSC.ce11', \
                                    'BSgenome.Scerevisiae.UCSC.sacCer3', \
                                    'EnsDb.Hsapiens.v75', \
                                    'EnsDb.Hsapiens.v79', \
                                    'EnsDb.Hsapiens.v86', \
                                    'EnsDb.Mmusculus.v79', \
                                    'EnsDb.Mmusculus.v86', \
                                    'EnsDb.Dmelanogaster.v79', \
                                    'EnsDb.Dmelanogaster.v86', \
                                    'JASPAR2016', \
                                    'JASPAR2018', \
                                    'JASPAR2020', \
                                    'JASPAR2022', \
                                    'JASPAR2024', \
                                    'org.Hs.eg.db', \
                                    'org.Mm.eg.db', \
                                    'org.Dm.eg.db', \
                                    'org.Ce.eg.db', \
                                    'org.Sc.sgd.db'))" \
    && R -e "install.packages(c('ClusterR', \
                                'DDRTree', \
                                'densityClust', \
                                'dtw', \
                                'dyngen', \
                                'gam', \
                                'gganimate', \
                                'gprofiler2', \
                                'irlba', \
                                'PRROC', \
                                'rbokeh', \
                                'SAVER', \
                                'singleCellHaystack', \
                                'UpSetR'))" \
    && R -e "remotes::install_github(c('prabhakarlab/Banksy', \
                                       'Danko-Lab/BayesPrism/BayesPrism', \
                                       'sqjin/CellChat', \
                                       'jokergoo/circlize', \
                                       'aertslab/cisTopic', \
                                       'jokergoo/ComplexHeatmap', \
                                       'chris-mcginnis-ucsf/DoubletFinder', \
                                       'aet21/EpiSCORE', \
                                       'csglab/GEDI', \
                                       'humengying0907/InstaPrism', \
                                       'theislab/kBET', \
                                       'saezlab/liana', \
                                       'immunogenomics/presto', \
                                       'sqjin/scAI', \
                                       'ZJUFanLab/scCATCH', \
                                       'SONGDONGYUAN1994/scDesign3', \
                                       'Vivianstats/scImpute', \
                                       'sunduanchen/Scissor', \
                                       'software-github/SCRABBLE/R', \
                                       'immunogenomics/SCENT', \
                                       'BlishLab/scriabin', \
                                       'carmonalab/SignatuR', \
                                       'dviraran/SingleR'))" \
    && R -e "remotes::install_github('powellgenomicslab/DropletQC', build_vignettes = TRUE)" \
    && R -e "remotes::install_github('UPSUTER/GEMLI', subdir='GEMLI_package_v0')" \
    && R -e "remotes::install_github('shenorrLab/cellAlign')" \
    && R -e "remotes::install_github('igrabski/sc-SHC')" \
    && R -e "remotes::install_github('zhanghao-njmu/SCP')" \
# scplotter
    && R -e "BiocManager::install('scRepertoire')" \
    && R -e "remotes::install_github('pwwang/scplotter')" \
# velocyto.R
# We cloned and modified velocyto.R to fix an installation error: https://github.com/velocyto-team/velocyto.R/issues/211
    && R -e "remotes::install_github(c('aertslab/SCopeLoomR', 'rnakato/velocyto.R'))" \
    && R -e "install.packages('pagoda2')" \
# SingleCellNet
    && R -e "remotes::install_github(c('pcahan1/singleCellNet'))" \
    && R -e "remotes::install_github('mojaveazure/loomR', ref = 'develop')" \
# ArchR
    && R -e "devtools::install_github('GreenleafLab/ArchR', ref='master', repos = BiocManager::repositories())" \
# chromVAR
    && R -e "BiocManager::install(c('chromVAR'))" \
    && R -e "remotes::install_github(c('GreenleafLab/chromVARmotifs','GreenleafLab/motifmatchr'))" \
# miloR
    && R -e "BiocManager::install('miloR')"

# Monocle3
COPY speedglm-master.tar.gz speedglm-master.tar.gz
RUN set -e \
    && R CMD INSTALL speedglm-master.tar.gz \
    && rm speedglm-master.tar.gz \
    && R -e "BiocManager::install(c('BiocGenerics', 'limma', 'S4Vectors', 'SingleCellExperiment', 'SummarizedExperiment', 'batchelor', 'Matrix.utils'))" \
    && R -e "remotes::install_github('cole-trapnell-lab/leidenbase')" \
    && R -e "remotes::install_github('cole-trapnell-lab/monocle3', ref='develop')" \
    && R -e "remotes::install_github('cole-trapnell-lab/garnett', ref='monocle3')" \
# cicero
    && R -e "remotes::install_github('cole-trapnell-lab/cicero-release', ref = 'monocle3')" \
# Harmony
    && R -e "remotes::install_github(c('immunogenomics/harmony','immunogenomics/presto','JEFworks/MUDAN'))" \
# SCDC, MuSiC
    && R -e "BiocManager::install(c('TOAST'))" \
    && R -e "remotes::install_github(c('renozao/xbioc','meichendong/SCDC', 'xuranw/MuSiC'))" \
# MOFA2
    && R -e "remotes::install_github('bioFAM/MOFA2', build_opts = c('--no-resave-data --no-build-vignettes'))" \
# bigSCale2
    && R -e "install.packages(c('fmsb','ClassDiscovery','ggalt','ggdendro','ggpubr'))" \
    && R -e "remotes::install_github('iaconogi/bigSCale2')" \
# DIRECT-NET
    && R -e "remotes::install_github('zhanglhbioinfor/DIRECT-NET')"

# kallisto, bustools
RUN set -e \
    && git clone https://github.com/BUStools/bustools.git \
    && cd bustools \
    && mkdir build \
    && cd build \
    && cmake .. && make && make install \
    && R -e "remotes::install_github(c('tidymodels/tidymodels','BUStools/BUSpaRse'))" \
    && rm -rf /opt/bustools

# FROWMAP
#COPY SDMTools_1.1-221.2.tar.gz SDMTools_1.1-221.2.tar.gz
#    && R CMD INSTALL SDMTools_1.1-221.2.tar.gz \
#    && rm SDMTools_1.1-221.2.tar.gz \
#RUN set -e \
#    && R -e "install.packages(c('igraph','robustbase','shiny','tcltk','rhandsontable'))" \
#    && R -e "BiocManager::install('cytolib')" \
#    && R -e "BiocManager::install('flowCore')" \
#    && R -e "remotes::install_github(c('nolanlab/scaffold','ParkerICI/vite','nolanlab/Rclusterpp','nolanlab/spade','zunderlab/FLOWMAP'))"

# FUSCA: CellComm
RUN set -e \
    && wget https://cran.r-project.org/src/contrib/Archive/geomnet/geomnet_0.3.1.tar.gz \
    && R CMD INSTALL geomnet_0.3.1.tar.gz \
    && rm geomnet_0.3.1.tar.gz \
    && R -e "remotes::install_github('edroaldo/fusca')"

# LIGER (FFTW, FIt-SNE)
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null \
    | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
  && echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' \
    | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null \
  && apt update && apt install -y cmake
RUN wget --progress=dot:giga http://www.fftw.org/fftw-3.3.10.tar.gz \
    && tar zxvf fftw-3.3.10.tar.gz \
    && rm fftw-3.3.10.tar.gz \
    && cd fftw-3.3.10 \
    && ./configure \
    && make \
    && make install \
    && sudo git clone https://github.com/KlugerLab/FIt-SNE.git \
    && cd FIt-SNE/ \
    && g++ -std=c++11 -O3 src/sptree.cpp src/tsne.cpp src/nbodyfft.cpp -o bin/fast_tsne -pthread -lfftw3 -lm -Wno-address-of-packed-member \
    && cp bin/fast_tsne /usr/local/bin/ \
    && cd \
    && rm -rf /opt/fftw-3.3.10 \
    && R -e "install.packages('rliger')"

# CIBERSORTx EcoTyper resigstration needed
# https://github.com/digitalcytometry/ecotyper

# SCAFE
RUN git clone https://github.com/chung-lab/SCAFE \
    && cd SCAFE \
    && chmod +x /opt/SCAFE/scripts/*  /opt/SCAFE/resources/bin/*/*

ENV GITHUB_PAT=

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && mkdir -p /.singularity.d \
    && echo '#!/bin/sh\n. /entrypoint.sh\nexec "$@"' > /.singularity.d/runscript \
    && chmod +x /.singularity.d/runscript

ENV PATH=$PATH:/opt:/opt/scripts:/opt/SCAFE/scripts:
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
