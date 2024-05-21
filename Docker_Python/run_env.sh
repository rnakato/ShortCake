#!/bin/bash
#source /opt/conda/etc/profile.d/conda.sh
#conda activate $1
eval "$(micromamba shell hook --shell bash)"
micromamba activate $1
shift
exec "$@"
