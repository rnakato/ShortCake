#!/bin/bash
set -e
eval "$(micromamba shell hook --shell bash)"
micromamba activate base
exec "$@"
