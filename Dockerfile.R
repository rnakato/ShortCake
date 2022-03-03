# Single-cell analysis pipeline for "Integrated analysis and regulation of cellular diversity"

FROM rnakato/r_python_gpu:2022.02
LABEL maintainer "Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"

USER root
WORKDIR /work

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/conda/lib/

ARG GITHUB_PAT
RUN set -x && \
    echo "GITHUB_PAT=$GITHUB_PAT" > ~/.Renviron \
    && cat ~/.Renviron \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libgfortran5 \
    libgmp3-dev \
    libgraphviz-dev \
    libgtk-3-dev \
    libgtkmm-3.0-dev \
    libssl-dev \
    libunwind-dev \
    libxt-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

# R for jupyterbook
RUN R -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))" \
    && R -e "remotes::install_github('IRkernel/IRkernel')" \
    && R -e "IRkernel::installspec()" \
# DelayedMatrixStats
    && R -e "devtools::install_github('PeteHaitch/DelayedMatrixStats@RELEASE_3_12')" \
# others
    && R -e "BiocManager::install(c('limma','scater','pcaMethods','WGCNA','preprocessCore', 'RCA', 'scmap', 'mixtools', 'stringi', 'rbokeh', 'DT', 'NMF', 'pheatmap', 'R2HTML', 'doMC', 'doRNG', 'scran', 'slingshot','DropletUtils', 'monocle', 'MeSH.Hsa.eg.db', 'MAST','clusterExperiment', 'scTensor'))" \
    && R -e "options(timeout=6000); BiocManager::install(c('BSgenome.Hsapiens.UCSC.hg19', 'BSgenome.Hsapiens.UCSC.hg38', 'BSgenome.Mmusculus.UCSC.mm10', 'BSgenome.Scerevisiae.UCSC.sacCer3', 'BSgenome.Dmelanogaster.UCSC.dm6'))" \
    && R -e "BiocManager::install(c('EnsDb.Hsapiens.v75','EnsDb.Hsapiens.v79', 'EnsDb.Hsapiens.v86', 'EnsDb.Mmusculus.v79'))" \
    && R -e "remotes::install_github(c('jokergoo/ComplexHeatmap'))"

# Seurat
COPY SeuratData SeuratData

RUN R -e "install.packages(c('sleepwalk','bit64','here','zoo','scBio','Seurat','metap'))" \
    && R -e "remotes::install_github('mojaveazure/seurat-disk')" \
# Signac
    && R -e "BiocManager::install('ggbio')" \
    && R -e "install.packages('Signac')" \
# SingleR
    && R -e "BiocManager::install(c('SingleR','scRNAseq','celldex'))" \
# Seurat wrappers
    && R -e "BiocManager::install(c('CoGAPS'))" \
    && R -e "BiocManager::install(c('scry'))" \
    && R -e "install.packages('glmpca')" \
    && R -e "remotes::install_github('kharchenkolab/conos')" \
#    && R -e "remotes::install_github('satijalab/seurat', ref = 'mixscape')" \
    && R -e "remotes::install_github('satijalab/seurat-wrappers')" \
# SeuratData
    && R -e "remotes::install_github('satijalab/seurat-data')" \
    && R -e "install.packages('SeuratData/ifnb.SeuratData_3.1.0.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/panc8.SeuratData_3.0.2.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/pbmcsca.SeuratData_3.0.0.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/pbmc3k.SeuratData_3.1.4.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/celegans.embryo.SeuratData_0.1.0.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/cbmc.SeuratData_3.1.4.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/hcabm40k.SeuratData_3.0.0.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/thp1.eccite.SeuratData_3.1.5.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/stxBrain.SeuratData_0.1.1.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/stxKidney.SeuratData_0.1.0.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/bmcite.SeuratData_0.3.0.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/pbmcMultiome.SeuratData_0.1.2.tar.gz', repos = NULL, type = 'source')" \
    && R -e "install.packages('SeuratData/ssHippo.SeuratData_3.1.4.tar.gz', repos = NULL, type = 'source')" \
    && rm -rf SeuratData

# scImpute, singleCellHaystack, scCATCH
RUN R -e "remotes::install_github(c('Vivianstats/scImpute', 'alexisvdb/singleCellHaystack', 'ZJUFanLab/scCATCH'))" \
# velocyto.R
    && R -e "remotes::install_github(c('aertslab/SCopeLoomR', 'velocyto-team/velocyto.R'))" \
    && R -e "install.packages('pagoda2')" \
# SingleCellNet
    && R -e "remotes::install_github(c('pcahan1/singleCellNet'))" \
    && R -e "remotes::install_github('mojaveazure/loomR', ref = 'develop')" \
# Splatter, SC3
    && R -e "BiocManager::install(c('splatter','SC3'))" \
# SCRABBLE
    && R -e "remotes::install_github('software-github/SCRABBLE/R')" \
# Imputation comparison
    && R -e "install.packages(c('SAVER','ClusterR'))" \
# SingleCellSingnalR
    && R -e "BiocManager::install(c('SingleCellSignalR'))" \
# ArchR
    && R -e "devtools::install_github('GreenleafLab/ArchR', ref='master', repos = BiocManager::repositories())" \
# chromVAR
    && R -e "BiocManager::install(c('chromVAR'))" \
    && R -e "remotes::install_github(c('GreenleafLab/chromVARmotifs','GreenleafLab/motifmatchr'))" \
# FlyATACAtlus
    && R -e "install.packages(c('irlba','DDRTree','densityClust'))"
# Monocle3
RUN R -e "BiocManager::install(c('BiocGenerics', 'limma', 'S4Vectors', 'SingleCellExperiment', 'SummarizedExperiment', 'batchelor', 'Matrix.utils'))" \
    && R -e "remotes::install_github('cole-trapnell-lab/leidenbase')" \
    && R -e "remotes::install_github('cole-trapnell-lab/monocle3', ref='develop')" \
    && R -e "BiocManager::install(c('org.Mm.eg.db', 'org.Hs.eg.db', 'org.Dm.eg.db', 'org.Ce.eg.db'))" \
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
RUN git clone https://github.com/BUStools/bustools.git \
    && cd bustools \
    && mkdir build \
    && cd build \
    && cmake .. && make && make install \
    && R -e "remotes::install_github(c('tidymodels/tidymodels','BUStools/BUSpaRse'))" \
    && rm -rf /work/bustools

# metacells
RUN R -e "BiocManager::install('tanaylab/metacell')" \
# motif database
    && R -e "BiocManager::install(c('JASPAR2016','JASPAR2018','JASPAR2020'))" \
# cisTopic, scAI
    && R -e "remotes::install_github(c('aertslab/cisTopic', 'sqjin/scAI'))" \
# SCDC, MuSiC
    && R -e "remotes::install_github(c('renozao/xbioc','meichendong/SCDC', 'xuranw/MuSiC'))" \
# MOFA2
    && R -e "remotes::install_github('bioFAM/MOFA2', build_opts = c('--no-resave-data --no-build-vignettes'))" \
# bigSCale2
    && R -e "install.packages(c('fmsb','ClassDiscovery','ggalt','ggdendro','ggpubr'))" \
    && R -e "BiocManager::install(c('org.Mm.eg.db', 'org.Hs.eg.db', 'BioQC', 'SingleCellExperiment'))" \
    && R -e "options(timeout=6000); remotes::install_github('iaconogi/bigSCale2')"

# FROWMAP
RUN R -e "install.packages('SDMTools',,'http://rforge.net/',type='source')" \
    && R -e "install.packages(c('igraph','robustbase','shiny','tcltk','rhandsontable'))" \
    && R -e "BiocManager::install('flowCore')" \
    && R -e "remotes::install_github(c('nolanlab/scaffold','ParkerICI/vite','nolanlab/Rclusterpp','nolanlab/spade','zunderlab/FLOWMAP'))"

# CellChat
RUN R -e "install.packages('NMF')" \
    && R -e "devtools::install_github('jokergoo/circlize')" \
    && R -e "devtools::install_github('jokergoo/ComplexHeatmap')" \
    && R -e "devtools::install_github('sqjin/CellChat')"

RUN rm ~/.Renviron
