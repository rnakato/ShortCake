#!/usr/bin/env bash
set -u

tag=4.0.0

TOTAL=0
FAILURES=0
FAILED_LABELS=()

check() {
    local label="$1"
    shift
    TOTAL=$((TOTAL + 1))
    echo
    echo "================================================================"
    echo "[$TOTAL] $label"
    echo "================================================================"
    echo "+ $*"
    if "$@"; then
        echo "OK: $label"
    else
        local status=$?
        echo "FAILED($status): $label" >&2
        FAILURES=$((FAILURES + 1))
        FAILED_LABELS+=("$label")
    fi
}

toollist="
    anndata \
    autogenes \
    bbknn \
    cellmap \
    celltypist \
    constclust \
    cython \
    dask \
    doubletdetection \
    harmonypy \
    llvmlite \
    leidenalg \
    magic \
    memento \
    multivelo \
    numba \
    optuna \
    phate \
    phenograph \
    scanorama \
    scanpy \
    scib \
    scranPY \
    screcode \
    scrublet \
    snapatac2 \
    velocyto "

for tool in $toollist
do
    check "shortcake_default: import $tool" docker run --rm rnakato/shortcake_light:$tag run_env.sh shortcake_default python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

# scanpy environment
for tool in scanpy scvelo
do
    check "scanpy env: import $tool" docker run --rm rnakato/shortcake_light:$tag run_env.sh scanpy python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

# cellrank environment
for tool in cellrank scvelo palantir
do
    check "cellrank env: import $tool" docker run --rm rnakato/shortcake_light:$tag run_env.sh cellrank python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

for tool in loompy pyscenic
do
    check "scenic env: import $tool" docker run --rm rnakato/shortcake_light:$tag run_env.sh scenic python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done
check "scenic cli: pyscenic" docker run --rm rnakato/shortcake_light:$tag run_env.sh scenic pyscenic
check "scenicplus cli: scenicplus" docker run --rm rnakato/shortcake_light:$tag run_env.sh scenicplus scenicplus
check "scenicplus env: import scenicplus" docker run --rm rnakato/shortcake_light:$tag run_env.sh scenicplus python -c "import scenicplus; print (getattr(scenicplus, '__version__', 'no __version__'))"

for tool in squidpy
do
    check "squidpy env: import $tool" docker run --rm rnakato/shortcake_light:$tag run_env.sh squidpy python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

# default
toollist="
    celloracle \
    cellphonedb \
    episcanpy \
    mario \
    metacells"
for tool in $toollist
do
    check "$tool env: import $tool" docker run --rm rnakato/shortcake:$tag run_env.sh $tool python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

for tool in genes2genes mowgli
do
    check "genes2genes-mowgli env: import $tool" docker run --rm rnakato/shortcake:$tag run_env.sh genes2genes-mowgli python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

for tool in dynamo
do
    check "dynamo env: import $tool" docker run --rm rnakato/shortcake:$tag run_env.sh dynamo python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

for tool in moscot
do
    check "moscot env: import $tool" docker run --rm rnakato/shortcake:$tag run_env.sh moscot python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

for tool in cell2cell scReadSim
do
    check "cell2cell-screadsim env: import $tool" docker run --rm rnakato/shortcake:$tag run_env.sh cell2cell-screadsim python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

for tool in decoupler liana sctriangulate
do
    check "decoupler-liana-sctriangulate env: import $tool" docker run --rm rnakato/shortcake:$tag run_env.sh decoupler-liana-sctriangulate python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

for tool in ikarus novosparc
do
    check "ikarus-novosparc env: import $tool" docker run --rm rnakato/shortcake:$tag run_env.sh ikarus-novosparc python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

check "eeisp cli" docker run --rm rnakato/shortcake:$tag eeisp --version

check "seacells env: import SEACells" docker run --rm rnakato/shortcake:$tag run_env.sh seacells python -c "import SEACells"

# Full
toollist="
    dictys \
    gears \
    rapids_singlecell"
for tool in $toollist
do
    check "$tool env: import $tool" docker run --rm --gpus all rnakato/shortcake_full:$tag run_env.sh $tool python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

# STELLAR is a cloned repository, not an installed package, and STELLAR_run.py needs the HuBMAP
# demo data from Dryad, which is not shipped in the image. Check that its modules and the
# torch/torch_geometric stack they need can be imported instead.
check "stellar modules" docker run --rm rnakato/shortcake_full:$tag run_env.sh stellar python -c "import sys; sys.path.insert(0, '/opt/stellar'); import torch, torch_geometric; from STELLAR import STELLAR; import datasets, utils; print (torch.__version__, torch_geometric.__version__)"

# SATURN (not pip-installed as an importable package; this only confirms the
# GPU torch stack built for it imports correctly)
check "saturn env: import torch" docker run --rm --gpus all rnakato/shortcake_full:$tag run_env.sh saturn python -c "import torch; print(getattr(torch, '__version__', 'no __version__'))"

for tool in scvi scgen scmomat unitvelo
do
    check "full scvi-scgen-scmomat-unitvelo env: import $tool" docker run --rm --gpus all rnakato/shortcake_full:$tag run_env.sh scvi-scgen-scmomat-unitvelo python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

# scVI flavor
for tool in scvi scgen scmomat unitvelo
do
    check "scvi flavor: import $tool" docker run --rm --gpus all rnakato/shortcake_scvi:$tag run_env.sh scvi-scgen-scmomat-unitvelo python -c "import "$tool"; print (getattr("$tool", '__version__', 'no __version__'))"
done

# rapidsc flavor
check "rapidsc flavor: import rapids_singlecell" docker run --rm --gpus all rnakato/shortcake_rapidsc:$tag run_env.sh rapids_singlecell python -c "import rapids_singlecell"

echo
echo "================================================================"
echo "Summary"
echo "================================================================"
echo "Total checks : $TOTAL"
echo "Failures     : $FAILURES"

if [[ "$FAILURES" -gt 0 ]]; then
    echo
    echo "Failed:"
    printf '  - %s\n' "${FAILED_LABELS[@]}"
    exit 1
fi

echo "All checks passed."
