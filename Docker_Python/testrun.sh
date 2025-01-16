tag=3.2.0

#    sctriangulate \
toollist="
    autogenes \
    bbknn \
    cellmap \
    celltypist \
    constclust \
    cython \
    doubletdetection \
    harmonypy \
    llvmlite \
    louvain \
    leidenalg \
    magic \
    multivelo \
    numba \
    optuna \
    palantir \
    phenograph \
    pyscenic \
    scvelo \
    scanpy \
    squidpy \
    cellrank \
    liana \
    pyscenic \
    scanpy \
    screcode \
    scrublet \
    scvelo \
    snapatac2 \
    velocyto "
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_light:$tag run_env.sh shortcake_default python -c "import "$tool"; print ("$tool".__version__)"
done

#exit

# default
toollist="
    celloracle \
    cellphonedb \
    episcanpy \
    mario"
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh $tool python -c "import "$tool"; print ("$tool".__version__)"
done

for tool in genes2genes mowgli 
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh genes2genes-mowgli python -c "import "$tool"; print ("$tool".__version__)"
done

for tool in dynamo moscot
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh dynamo-moscot python -c "import "$tool"; print ("$tool".__version__)"
done

for tool in cell2cell scReadSim
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh cell2cell-screadsim python -c "import "$tool"; print ("$tool".__version__)"
done

for tool in ikarus novosparc
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh ikarus-novosparc python -c "import "$tool"; print ("$tool".__version__)"
done

echo "EEISP"
docker run -it --rm rnakato/shortcake:$tag eeisp --version

echo "SEACells"
docker run -it --rm rnakato/shortcake:$tag run_env.sh seacells python -c "import SEACells"

#exit

# Full
# default
#    cellrank \
#   liana \
toollist="
    dictys \
    gears \
    rapids_singlecell"
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm --gpus all rnakato/shortcake_full:$tag  run_env.sh $tool python -c "import "$tool"; print ("$tool".__version__)"
done

echo "STELLAR"
docker run -it --rm rnakato/shortcake_full:$tag run_env.sh stellar python /opt/stellar/STELLAR_run.py

for tool in scvi scgen scmomat unitvelo
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm --gpus all rnakato/shortcake_full:$tag  run_env.sh scvi-scgen-scmomat-unitvelo python -c "import "$tool"; print ("$tool".__version__)"
done

# scVI
for tool in scvi scgen scmomat unitvelo 
do
    command="python -c \"import "$tool"\""
    echo scVI  $command
    docker run -it --rm --gpus all rnakato/shortcake_scvi:$tag  run_env.sh scvi-scgen-scmomat-unitvelo python -c "import "$tool"; print ("$tool".__version__)"
done

#rapids_singlecell
echo "rapids_singlecell rapids_singlecell"
docker run -it --rm --gpus all rnakato/shortcake_rapidsc:$tag run_env.sh rapids_singlecell python -c "import rapids_singlecell"
