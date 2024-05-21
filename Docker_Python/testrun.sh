tag=3.0.0

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
    cellrank \
    liana \
    pyscenic \
    scanpy \
    screcode \
    scrublet \
    sctriangulate \
    scvelo \
    snapatac2 \
    velocyto "
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_light:$tag run_env.sh shortcake_default python -c "import "$tool""
done

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
    docker run -it --rm rnakato/shortcake:$tag run_env.sh $tool python -c "import $tool"
done

for tool in genes2genes mowgli 
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh genes2genes-mowgli python -c "import $tool"
done

for tool in dynamo moscot
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh dynamo-moscot python -c "import $tool"
done

for tool in cell2cell scReadSim
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh cell2cell-screadsim python -c "import $tool"
done

for tool in ikarus novosparc
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake:$tag run_env.sh ikarus-novosparc python -c "import $tool"
done

echo "EEISP"
docker run -it --rm rnakato/shortcake:$tag eeisp --version

echo "SEACells"
docker run -it --rm rnakato/shortcake:$tag run_env.sh seacells python -c "import SEACells"

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
    docker run -it --rm rnakato/shortcake_full:$tag  run_env.sh $tool python -c "import $tool"
done

echo "STELLAR"
docker run -it --rm rnakato/shortcake_full:$tag run_env.sh stellar python -c "from STELLAR import STELLAR"

for tool in scvi scgen scmomat unitvelo
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_full:$tag  run_env.sh scvi-scgen-scmomat-unitvelo python -c "import $tool"
done

# scVI
for tool in scvi scgen scmomat unitvelo 
do
    command="python -c \"import "$tool"\""
    echo scVI  $command
    docker run -it --rm rnakato/shortcake_scvi:$tag  run_env.sh scvi-scgen-scmomat-unitvelo python -c "import $tool"
done

#rapids_singlecell
echo "rapids_singlecell rapids_singlecell"
docker run -it --rm rnakato/shortcake_rapidsc:$tag run_env.sh rapids_singlecell python -c "import rapids_singlecell"
