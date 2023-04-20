FROM docker_r-shortcake_r_seurat:latest
LABEL maintainer "Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"

USER root
WORKDIR /opt

ARG GITHUB_PAT
RUN set -x && \
    echo "GITHUB_PAT=$GITHUB_PAT" > ~/.Renviron \
    && cat ~/.Renviron \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libfftw3-dev \
    libgfortran5 \
    libgmp3-dev \
    libgraphviz-dev \
    libgtk-3-dev \
    libgtkmm-3.0-dev \
    libssl-dev \
    libunwind-dev \
    libxt-dev \
    pandoc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN set -e \
    && R -e "BiocManager::install(c('BioQC', \
                                    'BSgenome.Hsapiens.UCSC.hg19', \
                                    'BSgenome.Hsapiens.UCSC.hg38', \
                                    'BSgenome.Mmusculus.UCSC.mm10', \
                                    'BSgenome.Mmusculus.UCSC.mm39', \
                                    'BSgenome.Dmelanogaster.UCSC.dm6', \
                                    'BSgenome.Drerio.UCSC.danRer10', \
                                    'BSgenome.Celegans.UCSC.ce10', \
                                    'BSgenome.Celegans.UCSC.ce11', \
                                    'BSgenome.Scerevisiae.UCSC.sacCer3', \
                                    'celldex', \
                                    'clusterExperiment', \
                                    'clusterProfiler', \
                                    'DelayedMatrixStats', \
                                    'doMC', \
                                    'doRNG', \
                                    'DropletUtils', \
                                    'DT', \
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
                                    'limma', \
                                    'MAST', \
                                    'MeSH.Hsa.eg.db', \
                                    'mixtools', \
                                    'monocle', \
                                    'NMF', \
                                    'org.Hs.eg.db', \
                                    'org.Mm.eg.db', \
                                    'org.Dm.eg.db', \
                                    'org.Ce.eg.db', \
                                    'org.Sc.sgd.db', \
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
                                    'SingleCellSignalR', \
                                    'slingshot', \
                                    'splatter', \
                                    'stringi', \
                                    'WGCNA'))" \
    && R -e "install.packages(c('ClusterR', \
                                'DDRTree', \
                                'densityClust', \
                                'dyngen', \
                                'gam', \
                                'gprofiler2', \
                                'irlba', \
                                'SAVER', \
                                'UpSetR'))" \
    && R -e "remotes::install_github(c('Danko-Lab/BayesPrism/BayesPrism', \
                                       'jokergoo/ComplexHeatmap', \
                                       'immunogenomics/presto', \
                                       'aet21/EpiSCORE', \
                                       'carmonalab/SignatuR', \
                                       'dviraran/SingleR'))" \
    && R -e "remotes::install_github('powellgenomicslab/DropletQC', build_vignettes = TRUE)" \
# scImpute, singleCellHaystack, scCATCH
    && R -e "install.packages('singleCellHaystack')" \
    && R -e "remotes::install_github(c('Vivianstats/scImpute', 'ZJUFanLab/scCATCH'))" \
# velocyto.R
    && R -e "remotes::install_github(c('aertslab/SCopeLoomR', 'velocyto-team/velocyto.R'))" \
    && R -e "install.packages('pagoda2')" \
# SingleCellNet
    && R -e "remotes::install_github(c('pcahan1/singleCellNet'))" \
    && R -e "remotes::install_github('mojaveazure/loomR', ref = 'develop')" \
# SCRABBLE
    && R -e "remotes::install_github('software-github/SCRABBLE/R')" \
# ArchR
    && R -e "devtools::install_github('GreenleafLab/ArchR', ref='master', repos = BiocManager::repositories())" \
# chromVAR
    && R -e "BiocManager::install(c('chromVAR'))" \
    && R -e "remotes::install_github(c('GreenleafLab/chromVARmotifs','GreenleafLab/motifmatchr'))"
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
# DoubletFinder
    && R -e "remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')" \
# Harmony
    && R -e "install.packages('gganimate')" \
    && R -e "BiocManager::install(c('sva','DESeq2'))" \
    && R -e "remotes::install_github(c('immunogenomics/harmony','immunogenomics/presto','JEFworks/MUDAN'))"

# kallisto, bustools
RUN set -e \
    && git clone https://github.com/BUStools/bustools.git \
    && cd bustools \
    && mkdir build \
    && cd build \
    && cmake .. && make && make install \
    && R -e "remotes::install_github(c('tidymodels/tidymodels','BUStools/BUSpaRse'))" \
    && rm -rf /work/bustools

# metacells
RUN set -e \
    && R -e "BiocManager::install('tanaylab/metacell')" \
# cisTopic, scAI
    && R -e "remotes::install_github(c('aertslab/cisTopic', 'sqjin/scAI'))" \
# SCDC, MuSiC
    && R -e "BiocManager::install(c('TOAST'))" \
    && R -e "remotes::install_github(c('renozao/xbioc','meichendong/SCDC', 'xuranw/MuSiC'))" \
# MOFA2
    && R -e "remotes::install_github('bioFAM/MOFA2', build_opts = c('--no-resave-data --no-build-vignettes'))" \
# bigSCale2
    && R -e "install.packages(c('fmsb','ClassDiscovery','ggalt','ggdendro','ggpubr'))" \
    && R -e "remotes::install_github('iaconogi/bigSCale2')"

# FROWMAP
COPY SDMTools_1.1-221.2.tar.gz SDMTools_1.1-221.2.tar.gz
RUN set -e \
    && R CMD INSTALL SDMTools_1.1-221.2.tar.gz \
    && rm SDMTools_1.1-221.2.tar.gz \
    && R -e "install.packages(c('igraph','robustbase','shiny','tcltk','rhandsontable'))" \
    && R -e "BiocManager::install('flowCore')" \
    && R -e "remotes::install_github(c('nolanlab/scaffold','ParkerICI/vite','nolanlab/Rclusterpp','nolanlab/spade','zunderlab/FLOWMAP'))"

# CellChat
#RUN R -e "install.packages('NMF')" \
RUN set -e \
    && R -e "remotes::install_github('jokergoo/circlize')" \
    && R -e "remotes::install_github('jokergoo/ComplexHeatmap')" \
    && R -e "remotes::install_github('sqjin/CellChat')" \
# scTenifoldKnk
#    && R -e "remotes::install_github('cailab-tamu/scTenifoldKnk')" \
# Scissor
    && R -e "remotes::install_github('sunduanchen/Scissor')" \
# FUSCA: CellComm
    && wget https://cran.r-project.org/src/contrib/Archive/geomnet/geomnet_0.3.1.tar.gz \
    && R CMD INSTALL geomnet_0.3.1.tar.gz \
    && rm geomnet_0.3.1.tar.gz \
    && R -e "remotes::install_github('edroaldo/fusca')"

# CIBERSORTx EcoTyper resigstration needed
# https://github.com/digitalcytometry/ecotyper

RUN rm ~/.Renviron
