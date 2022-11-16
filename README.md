# docker_singlecell_jupyter
0;136;0cA docker image for single-cell analyses. It's on docker-hub and GitHub.

## Changelog

- 2022.08.2 (2022-08)

    - Create separate environments for python tools to avoid version conflict. They can be executed from Jupyter notebook

- 2022.03 (2022-03-03)

    - Separate Dockerfile to Dockerfile.R and Dockerfile.Python
    - change base image from `pytorch-1.5-cuda10.1-cudnn7-devel` to `nvidia/cuda:11.5.1-cudnn8-devel-ubuntu20.04` to upgrade Python to 3.9
    - Add CellChat, dyngen, Dynamo

- 2021.03 (2021-05-01):

    - Add datasets in SeuratData
    - Add Pagoda2

- 2021.02 (2021-02-07):

    - Add programs
    - Use pip venv for several tools to avoid package conflicts (e.g., tensorflow)

- 2020.12 (2020-12-24):

    - Add `docker-compose.yml` to allow GitHub Token
    - Omit the password to login Jupyter notebook
    - Add programs
    - Fix several bugs in the installation

- v1.3.0 (2020-07-14): add programs
- v1.2.0: change base image from `Ubuntu18.04` to `pytorch-1.5-cuda10.1-cudnn7-devel` to allow GPU computing
- v1.1.0: change base image `jupyter/datascience-notebook` to `Ubuntu18.04`

## Included tools (latest)

- Pipeline: Seurat (and wrappers), scater, scran, scanpy, scVI, monet, Pagoda2, kallisto (bustools)
- Doublet finding: Scrublet, DoubletFinder
- Batch correction and data integration: Harmony, scmap, scBio, SingleCellNet
- Clustering: SC3, metacell, SCCAF, Constclust, bigSCale2
- Cluster annotation: RCA, CellAssign, garnett, scCatch, SingleR
- Trajectory analysis: Monocle2/3, slingshot, Palantir, FROWMAP
- RNA velocity: velocyto, scVelo, CellRank, Dynamo
- Gene network: WGCNA, SCENIC (pySCENIC)
- Cell-to-cell interaction: CellPhoneDB, SingleCellSingnalR, scTensor, cell2cell, CellChat
- Data imputation: scImpute, MAGIC, SAVER, SAVER-X, SCRABBLE
- Multi-modal: LIGER, scAI, MOFA2
- Bulk deconvolution: SCDC, MuSiC
- Simulation: Splatter, dyngen
- Others: scGen, sleepwalk, singleCellHaystack, ComplexHeatmap
- scATAC-seq: cicero, chromVAR, ArchR, Signac, cisTopic, episcanpy

- Database (genome): BSgenome.Hsapiens.UCSC.hg19, BSgenome.Hsapiens.UCSC.hg38, BSgenome.Mmusculus.UCSC.mm10, BSgenome.Scerevisiae.UCSC.sacCer3, BSgenome.Dmelanogaster.UCSC.dm6
- Database (gene): EnsDb.Hsapiens.v75, EnsDb.Hsapiens.v79, EnsDb.Hsapiens.v86, EnsDb.Mmusculus.v79
- Database (motif): JASPAR2016, JASPAR2018, JASPAR2020
- SeuratData: ifnb_3.1.0, panc8_3.0.2, pbmcsca_3.0.0, pbmc3k_3.1.4, celegans.embryo_0.1.0, cbmc_3.1.4, hcabm40k_3.0.0, thp1.eccite_3.1.5, stxBrain_0.1.1, stxKidney_0.1.0, bmcite_0.3.0, pbmcMultiome_0.1.2, ssHippo_3.1.4

## Run

For Docker:

    # pull docker image
    docker pull rnakato/singlecell_jupyter

    # container login
    docker run [--gpus all] --rm -it rnakato/singlecell_jupyter /bin/bash
    # jupyter notebook (see 'mnt/' directory in the notebook )
    docker run [--gpus all] --rm -p 8888:8888 -v (your directory):/work/mnt rnakato/singlecell_jupyter jupyternotebook.sh

For Singularity:

    # build image
    singularity build -F rnakato_singlecell_jupyter.sif docker://rnakato/singlecell_jupyter
    # jupyter notebook
    singularity exec [--nv] rnakato_singlecell_jupyter.sif jupyternotebook.sh
    # execute R directory
    singularity exec [--nv] rnakato_singlecell_jupyter.sif R

## Build image from Dockerfile
First clone and move to the repository

    git clone https://github.com/rnakato/docker_singlecell.git
    cd docker_singlecell

Because the Dockerfile installs many packages from GitHub, please add [a GitHub token from your own repository](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) and add it in `docker-compose.R.yml` and `docker-compose.yml`. Then type:

    docker-compose -f docker-compose.R.yml build
    docker-compose -f docker-compose.yml build

## Contact

Ryuichiro Nakato: rnakato AT iqb.u-tokyo.ac.jp
