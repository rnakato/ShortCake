FROM rnakato/singlecell_jupyter:1.2.0
LABEL maintainer "Ryuichiro Nakato <rnakato@iam.u-tokyo.ac.jp>"

USER root
WORKDIR /opt

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libgmp3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip

# Palantir, MAGIC
RUN pip install PhenoGraph palantir rpy2 magic-impute \
    && R -e "install.packages('gam')"

# Scrublet
RUN pip install scrublet

# SingleCellNet
RUN R -e "devtools::install_github('pcahan1/singleCellNet')"

# FlyATACAtlus
RUN R -e "install.packages(c('irlba','DDRTree','densityClust'))"

# Splatter
RUN R -e "BiocManager::install('splatter')"

# SCRABBLE
RUN R -e "devtools::install_github('software-github/SCRABBLE/R')"

# Imputation comparison
RUN R -e "install.packages(c('SAVER','ClusterR'))"

# SingleCellSingnalR
RUN R -e "devtools::install_github('SCA-IRCM/SingleCellSignalR_v1', subdir = 'SingleCellSignalR')"

# Theis_Tutorial
RUN pip install gprofiler-official anndata2ri bbknn \
	&&  R -e "BiocManager::install(c('MAST','clusterExperiment'))"

# DoubletFinder
RUN R -e "devtools::install_github('chris-mcginnis-ucsf/DoubletFinder')"

# scater-cellassign
RUN R -e "install.packages(c('here'))"
RUN R -e "devtools::install_github('Irrationone/cellassign')"
#    && R -e "tensorflow::install_tensorflow(gpu = TRUE)"

# scVI
RUN conda install scvi -c bioconda -c conda-forge \
    && pip install scikit-misc plotnine

# scGen
RUN pip install scgen

# SCCAF
RUN pip install sccaf

# metacells
RUN R -e "BiocManager::install('metacell',  site_repository = 'tanaylab.github.io/repo', update = FALSE)"

# LIGER
RUN R -e "devtools::install_github(c('MacoskoLab/liger'))"
ADD bedops_linux_x86_64-v2.4.39 bedops_linux_x86_64-v2.4.39

# Harmony
RUN R -e "BiocManager::install('sva')" \
    && R -e "devtools::install_github(c('immunogenomics/harmony','JEFworks/MUDAN'))"

ENV PATH ${PATH}:/opt/bedops_linux_x86_64-v2.4.39