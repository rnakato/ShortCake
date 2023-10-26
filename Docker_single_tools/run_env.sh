#!/bin/bash
source /opt/conda/etc/profile.d/conda.sh
conda activate $1
shift
exec "$@"
