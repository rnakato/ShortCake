#!/bin/bash

docker run --rm -it -p 8888:8888 \
       -v $(pwd):/home/jovyan \
       rnakato/singlecell_ubuntu \
       jupyternotebook.sh

## Singu;arity

### Old one
#docker run --name notebook -p 8888:8888 \
#       -v $(pwd):/home/jovyan \
#       rnakato/singlecell_jupyter \
#      start-notebook.sh
