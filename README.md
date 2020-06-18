# docker_singlecell_jupyter
A docker image for singlecell analysis. It's on docker-hub and github

# Changelog
- v1.2.0: change base image from `Ubuntu18.04` to `pytorch-1.5-cuda10.1-cudnn7-devel` to allow GPU computing
- v1.1.0: change base image `jupyter/datascience-notebook` to `Ubuntu18.04`

# Included tools (latest)
- Seurat
- Monocle3
- scater
- scmap
- scran
- slingshot
- scImpute
- velocyto (R and Python)
- scanpy
- sleepwalk
- liger
- RCA
- scBio
- SCENIC
- singleCellHaystack
- CellPhoneDB

# Run

For Docker:

    # pull docker image
    docker pull rnakato/singlecell_jupyter

    # container login
    docker run --gpus all --rm -it rnakato/singlecell_jupyter /bin/bash
    # jupyter notebook
    docker run --gpus all --rm -p 8888:8888 -v (your directory):/opt/work rnakato/singlecell_jupyter jupyternotebook.sh

For Singularity:

    # build image
    singularity build -F rnakato_singlecell_jupyter.img docker://rnakato/singlecell_jupyter
    # jupyter notebook
    singularity exec --nv rnakato_singlecell_jupyter.img jupyternotebook.sh
    # execute R directory
    singularity exec --nv rnakato_singlecell_jupyter.img R
    
# Build image from dockerfile

    git clone https://github.com/rnakato/docker_singlecell.git
    cd docker_singlecell
    docker build -t rnakato/singlecell_jupyter

## Contact

Ryuichiro Nakato: rnakato AT iam.u-tokyo.ac.jp
