# docker_singlecell_jupyter
A docker image for single-cell analyses. It's on docker-hub and GitHub

## Changelog
- 2020.12 (2020-12-24): 

    - Add `docker-compose.yml` to allow GitHub Token
    - Omit the password to login Jupyter notebook
    - Add programs
    - Fix several bugs in the installation

- v1.3.0 (2020-07-14): add programs
- v1.2.0: change base image from `Ubuntu18.04` to `pytorch-1.5-cuda10.1-cudnn7-devel` to allow GPU computing
- v1.1.0: change base image `jupyter/datascience-notebook` to `Ubuntu18.04`

## Included tools (latest)

- Pipeline: Seurat (and wrappers), scater, scran, scanpy, liger, scVI, kallisto (bustools)
- Doublet finding: Scrublet, DoubletFinder
- Batch correction and data integration: Harmony, scmap, scBio, SingleCellNet
- Clustering: metacell, SCCAF
- Cluster annotation: RCA, CellAssign, garnett, scCatch, SingleR
- Trajectory analysis: Monocle2/3, slingshot, velocyto, scVelo, Palantir
- Gene network: WGCNA, SCENIC (pySCENIC)
- Cell-to-cell interaction: CellPhoneDB, SingleCellSingnalR, scTensor
- Data imputation: scImpute, MAGIC, SAVER, SCRABBLE
- Simulation: Splatter
- Multi-modal: LIGER, scAI
- Others: scGen, sleepwalk, singleCellHaystack, ComplexHeatmap
- scATAC-seq: cicero, chromVAR, ArchR, Signac, cisTopic

- Database (genome): BSgenome.Hsapiens.UCSC.hg19, BSgenome.Hsapiens.UCSC.hg38, BSgenome.Mmusculus.UCSC.mm10, BSgenome.Scerevisiae.UCSC.sacCer3, BSgenome.Dmelanogaster.UCSC.dm6
- Database (gene): EnsDb.Hsapiens.v75, EnsDb.Hsapiens.v79, EnsDb.Hsapiens.v86, EnsDb.Mmusculus.v79 
- Database (motif): JASPAR2016, JASPAR2018, JASPAR2020
- SeuratData: pbmcsca, ifnb, panc8, pbmc3k

## Run

For Docker:

    # pull docker image
    docker pull rnakato/singlecell_jupyter

    # container login
    docker run [--gpus all] --rm -it rnakato/singlecell_jupyter /bin/bash
    # jupyter notebook
    docker run [--gpus all] --rm -p 8888:8888 -v (your directory):/opt/work rnakato/singlecell_jupyter jupyternotebook.sh

If a password is requested on the Jupyter notebook start page, type "diversity".

For Singularity:

    # build image
    singularity build -F rnakato_singlecell_jupyter.img docker://rnakato/singlecell_jupyter
    # jupyter notebook
    singularity exec --nv rnakato_singlecell_jupyter.img jupyternotebook.sh
    # execute R directory
    singularity exec --nv rnakato_singlecell_jupyter.img R

## Build image from Dockerfile
First clone and move to the repository 

    git clone https://github.com/rnakato/docker_singlecell.git
    cd docker_singlecell

Because the Dockerfile contains many R packages installed from GitHub, please add [a GitHub token from your own repository](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) and add it in `docker-compose.yml`. Then type:

    docker-compose build

## Contact

Ryuichiro Nakato: rnakato AT iqb.u-tokyo.ac.jp
