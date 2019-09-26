#!/bin/bash

docker run --name notebook -p 8888:8888 \
       -v $(pwd):/home/jovyan \
       rnakato/singlecell_jupyter \
       start-notebook.sh
