# syntax=docker/dockerfile:1
FROM rnakato/shortcake_seurat:4.0.0
LABEL maintainer="Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"

USER root
WORKDIR /opt

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

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

RUN --mount=type=secret,id=github_pat,env=GITHUB_PAT \
    --mount=type=bind,source=verify_r_packages.R,target=/tmp/verify_r_packages.R \
    set -euo pipefail; \
    # Armadillo 15 (RcppArmadillo) はC++14を必須とする一方、mbkmeans、motifmatchr、chromVAR、miloRはC++11を明示する。 \
    # そのため、このRUN内に限りC++11指定をC++14ツールチェーンへ読み替えてビルドする (RcppArmadillo issue #484)。 \
    printf 'CXX11 = $(CXX14)\nCXX11STD = $(CXX14STD)\n' > /tmp/Makevars.cxx14 \
    && export R_MAKEVARS_USER=/tmp/Makevars.cxx14 \
    && R -e 'devtools::install_version("dbplyr", version = "2.3.4")' \
    && R -e "BiocManager::install(c('BioQC', \
                                    'BiocNeighbors', \
                                    'biomaRt', \
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
                                    'metaboliteIDmapping' , \
                                    'mixtools', \
                                    'NMF', \
                                    'pcaMethods', \
                                    'pheatmap', \
                                    'preprocessCore', \
                                    'R2HTML', \
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
                                'SAVER', \
                                'singleCellHaystack', \
                                'UpSetR'))" \
    && R -e "remotes::install_github(c('prabhakarlab/Banksy@081f51b4b41f26aa53158be0382b7b05cf620875', \
                                       'Danko-Lab/BayesPrism/BayesPrism@19052052a6f30833b27e2148294459b0ba2f923e', \
                                       'chris-mcginnis-ucsf/DoubletFinder@1b244d8f0d54b4b1cb4365639931bbb16f01e1cd', \
                                       'aet21/EpiSCORE@3572ef86814ba2998e33036f756ef7227155d479', \
                                       'csglab/GEDI@c59913ddb55fd6dbfae40f32870a042bdfa50d0c', \
                                       'humengying0907/InstaPrism@7d3b57cde9342c5eac7282f4c2d8bff09f21e693', \
                                       'theislab/kBET@afc5f431bcbefd73267acc066a0f2e4eaa10a355', \
                                       'immunogenomics/presto@v1.1.0', \
                                       'ZJUFanLab/scCATCH@06c6ffb960795d028c675643f0d22fbc78080a97', \
                                       'SONGDONGYUAN1994/scDesign3@dec8acb2f54c2498f005ab0fce9781b7654562ef', \
                                       'Vivianstats/scImpute@78556ee2dc0a9c830223b9e3e9f99387cd3e09a4', \
                                       'software-github/SCRABBLE/R@c6b51c147ba6abf16465e6d374ec92db535bcaf6', \
                                       'immunogenomics/SCENT@e80b5ba6b445f972c7fe28fb41e24ef4f5b2e373', \
                                       'carmonalab/SignatuR@e3d02c6208272b8f29beb90cdb581d3a3bf820f1', \
                                       'dviraran/SingleR@0ad570e57d69deb49b83a37b1f216234df7dcf4e'))" \
    && R -e "remotes::install_github('sqjin/CellChat@e4f68625b074247d619c2e488d33970cc531e17c')" \
    && R -e "remotes::install_github('saezlab/liana@6cab46c54234f861ea176c3de77c4b8aa45ecb3d')" \
    && R -e "remotes::install_github('BlishLab/scriabin@bce695bd598e2e2d37e51d983dca2a29d5ef61c7')" \
    # DropletQCのbuild_vignettes=FALSEは、vignetteビルドに必要なパッケージがBioconductor 3.15でインストールできないため
    && R -e "remotes::install_github('powellgenomicslab/DropletQC@5d7dadca4dbc2aa471ea6540792469e85f1281e5', build_vignettes = FALSE)" \
    && R -e "remotes::install_github('UPSUTER/GEMLI@2e3ba196906b445329267d69b5a17bcdae7251dd', subdir='GEMLI_package_v0')" \
    && R -e "remotes::install_github('shenorrLab/cellAlign@30fb085bcf45280e1706450e9cfcba3728cda6d8')" \
    && R -e "remotes::install_github('igrabski/sc-SHC@2671f6ee5a55572ddd7216de822044f9497d6161')" \
    && R -e "remotes::install_github('zhanghao-njmu/SCP@b9b0eb7a7bf2c2c4b2262e73e09d7ebd515c7da0')" \
# scplotter
    && R -e "BiocManager::install('scRepertoire')" \
    && R -e "remotes::install_github('pwwang/scplotter@398bd50e6561cad73d1b59a4027bdea0b050f934')" \
# velocyto.R
# We cloned and modified velocyto.R to fix an installation error: https://github.com/velocyto-team/velocyto.R/issues/211
    && R -e "remotes::install_github(c('aertslab/SCopeLoomR@20f4e0af5ecdbb748a088d52400e24b42ed30a24', 'rnakato/velocyto.R@641437819b4de023ab4eb4e9a44d0d4c702c54a9'))" \
    && R -e "install.packages('pagoda2')" \
# SingleCellNet
    && R -e "remotes::install_github('pcahan1/singleCellNet@1f55f245ca7ec2c680349161f4e1db12f5ac81b3')" \
    && R -e "remotes::install_github('mojaveazure/loomR@1eca16a60f529944050e2a3419040cb811726699')" \
# ArchR
    && R -e "devtools::install_github('GreenleafLab/ArchR@6feec354ad6c8052ddbc4626a2ca2d858ed465bf', repos = BiocManager::repositories())" \
# chromVAR
    && R -e "BiocManager::install(c('chromVAR'))" \
    && R -e "remotes::install_github(c('GreenleafLab/chromVARmotifs@38bed559c1f4770b6c91c80bf3f8ea965da26076','GreenleafLab/motifmatchr@d0dc70e5b25d4d80b5bd96de8820a82de174baa5'))" \
# miloR
    && R -e "BiocManager::install('miloR')" \
# conos
    && R -e "remotes::install_github('kharchenkolab/conos@v1.5.4')" \
    && Rscript /tmp/verify_r_packages.R miloR liana SCP scriabin CellChat ComplexHeatmap ArchR chromVAR SingleCellSignalR velocyto.R conos \
    && rm /tmp/Makevars.cxx14

# Monocle3
COPY speedglm-master.tar.gz speedglm-master.tar.gz
RUN --mount=type=secret,id=github_pat,env=GITHUB_PAT \
    set -euo pipefail; \
    R CMD INSTALL speedglm-master.tar.gz \
    && rm speedglm-master.tar.gz \
    && R -e "BiocManager::install(c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats', \
                       'limma', 'lme4', 'S4Vectors', 'SingleCellExperiment', \
                       'SummarizedExperiment', 'batchelor', 'HDF5Array', 'ggrastr'))" \
    # leidenbase: GitHubのmaster(0.1.32)は configure が R 4.6 で廃止された "R CMD config CXX11" を呼ぶため \
    # ビルドできない。CRANの0.1.37は修正済みだが対応するコミットがGitHubに無いのでCRANから入れる。 \
    && R -e "install.packages('leidenbase')" \
    && R -e "remotes::install_github('bnprks/BPCells/r@c293a0a34e653c395c8e9bf9ed3133107324d7b7')" \
    && R -e "remotes::install_github('cole-trapnell-lab/monocle3@e00846ed21d23b95724dfa980fbc4a264c3444fc')" \
    && R -e "remotes::install_github('cole-trapnell-lab/garnett@349c1f8fa92e837e572aa28a90d2919c83fd6390')" \
# cicero
    && R -e "remotes::install_github('cole-trapnell-lab/cicero-release@495ef0da13cc9ffe55516bfd34f48b671ad55aba')" \
# Harmony
    && R -e "remotes::install_github('immunogenomics/harmony@df19af23ae0639bd6ea2da63898f973f08c85862')" \
    && R -e "remotes::install_github(c('immunogenomics/presto@v1.1.0','JEFworks/MUDAN@3636ed2f9a404cbdfcfdce5500384b59a72de666'))" \
# SCDC, MuSiC
    && R -e "BiocManager::install(c('TOAST'))" \
    && R -e "remotes::install_github(c('renozao/xbioc@1354168bd7e64be4ee1f9f74e971a61556d75003','meichendong/SCDC@7a49c765b77759ff204f7afaa4dbff1436355407', 'xuranw/MuSiC@f21fe67f5670d5e9fca0ad7550abaae3423eb59c'))" \
# MOFA2
    && R -e "remotes::install_url('https://github.com/bioFAM/MOFA2/archive/072bf792a17118a39d3ad040ead1468b7a9f9214.tar.gz', subdir = 'MOFA2', build_opts = c('--no-resave-data --no-build-vignettes'))" \
# bigSCale2
    && R -e "install.packages(c('fmsb','ClassDiscovery','ggdendro','ggpubr'))" \
    && R -e "remotes::install_github('iaconogi/bigSCale2@e47f0cd4b6374e5bcc52d99f4c50d0671aada811')" \
# DIRECT-NET
    && R -e "remotes::install_github('zhanglhbioinfor/DIRECT-NET@d116bbabed0bad60ca13e0de0d4f4407562c2415')"

# LIGER (FFTW, FIt-SNE)
# rliger が依存する RcppPlanc は cmake >= 3.24 を要求する。Ubuntu 22.04 の cmake は 3.22 で
# 足りなかったため Kitware のリポジトリを追加していたが、24.04 は標準で 3.28 を提供するので不要。
RUN wget --progress=dot:giga http://www.fftw.org/fftw-3.3.10.tar.gz \
    && tar zxvf fftw-3.3.10.tar.gz \
    && rm fftw-3.3.10.tar.gz \
    && cd fftw-3.3.10 \
    && ./configure \
    && make \
    && make install \
    && sudo git clone https://github.com/KlugerLab/FIt-SNE.git \
    && git -C FIt-SNE checkout --detach v1.2.1 \
    && cd FIt-SNE/ \
    && g++ -std=c++11 -O3 src/sptree.cpp src/tsne.cpp src/nbodyfft.cpp -o bin/fast_tsne -pthread -lfftw3 -lm -Wno-address-of-packed-member \
    && cp bin/fast_tsne /usr/local/bin/ \
    && cd \
    && rm -rf /opt/fftw-3.3.10 \
    && R -e "install.packages('rliger')"

COPY bustools_linux-v0.39.3.tar.gz bustools_linux-v0.39.3.tar.gz
RUN --mount=type=secret,id=github_pat,env=GITHUB_PAT \
    --mount=type=bind,source=verify_r_packages.R,target=/tmp/verify_r_packages.R \
    set -euo pipefail; \
# kallisto, bustools
    tar zxvf bustools_linux-v0.39.3.tar.gz \
    && cp bustools/bustools /usr/local/bin/ \
    && rm -rf /opt/bustools bustools_linux-v0.39.3.tar.gz \
    && R -e "remotes::install_github('tidymodels/tidymodels@0c21a2d907d6c7e250397c4310cd3e0c9342c651')" \
    && git clone https://github.com/BUStools/BUSpaRse.git /tmp/BUSpaRse \
    && git -C /tmp/BUSpaRse checkout --detach 6e8888151fbe0bf6919ac8b4af6475c8bc6fec33 \
    && sed -i 's/^CXX_STD = CXX11$/CXX_STD = CXX14/' /tmp/BUSpaRse/src/Makevars \
    && grep -Fx 'CXX_STD = CXX14' /tmp/BUSpaRse/src/Makevars \
    # R CMD INSTALL は依存を解決しないため、依存解決を行う install_local を使う。 \
    # 既定のreposはCRANのみでBioconductorのplyrangesが引けないので、ArchRと同様にBiocManagerのreposを明示する。 \
    && R -e "remotes::install_local('/tmp/BUSpaRse', upgrade='never', repos = BiocManager::repositories())" \
    && rm -rf /tmp/BUSpaRse \
# FUSCA: CellComm
    && wget https://cran.r-project.org/src/contrib/Archive/geomnet/geomnet_0.3.1.tar.gz \
    && R CMD INSTALL geomnet_0.3.1.tar.gz \
    && rm geomnet_0.3.1.tar.gz \
    && R -e "remotes::install_github('edroaldo/fusca@348d653184928d430bb8db7489f80947f25cc93e')" \
# SCAFE
    && cd /opt \
    && git clone https://github.com/chung-lab/SCAFE \
    && git -C SCAFE checkout --detach v1.0.0 \
    && cd SCAFE \
    && chmod +x /opt/SCAFE/scripts/*  /opt/SCAFE/resources/bin/*/* \
    && Rscript /tmp/verify_r_packages.R kBET GEDI scplotter DIRECTNET GEMLI miloR SingleCellExperiment liana cellAlign SCP dplyr patchwork scriabin tricycle presto EpiSCORE DropletQC BayesPrism UpSetR dyngen CellChat ComplexHeatmap Seurat SeuratWrappers Azimuth SeuratDisk SeuratData Signac MOFA2 stringi harmony MUDAN DoubletFinder rliger monocle3 garnett ArchR chromVAR SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR conos CoGAPS scran slingshot scRNAseq scTensor scater sleepwalk scBio RCA SC3 scmap WGCNA Banksy InstaPrism scDesign3 SCENT SignatuR scRepertoire pagoda2 bigSCale cicero SCDC MuSiC celldex BUSpaRse

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && mkdir -p /.singularity.d \
    && printf '#!/bin/sh\n. /entrypoint.sh\nexec "$@"\n' > /.singularity.d/runscript \
    && chmod +x /.singularity.d/runscript

ENV PATH=$PATH:/opt:/opt/scripts:/opt/SCAFE/scripts:
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
