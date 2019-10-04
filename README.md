# docker_singlecell_jupyter
A docker image for singlecell analysis. It's on docker-hub and github

## tags and links
- 1.0.0/latest 

## Included tools
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

## Run
    docker pull rnakato/singlecell_jupyter
    
    # container login
    docker run --rm -it rnakato/singlecell_jupyter /bin/bash
    # jupyter notebook
    docker run --name notebook -p 8888:8888 -v (your directory):/home/jovyan/work rnakato/singlecell_jupyter start-notebook.sh

## Build image from dockerfile

    git clone https://github.com/rnakato/docker_singlecell.git
    cd docker_singlecell
    docker build -f Dockerfile -t rnakato/singlecell_jupyter

## Contact 

Ryuichiro Nakato: rnakato@iam.u-tokyo.ac.jp
