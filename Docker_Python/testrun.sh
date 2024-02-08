toollist="
    autogenes \
    bbknn \
    celltypist \
    llvmlite \
    numba \
    cython \
    louvain \
    leidenalg \
    magic \
    mowgli \
    multivelo \
    palantir \
    phenograph \
    scvelo \
    screcode \
    scrublet \
    sctriangulate \
    snapatac2 \
"
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh shortcake_default python -c "import "$tool""
done

toollist="
    liana \
    moscot \
    cell2cell \
    cell2fate \
    celloracle \
    cellrank \
    cellphonedb \
    constclust \
    doubletdetection \
    dynamo \
    episcanpy \
    harmonypy \
    ikarus \
    monet \
    novosparc \
    pyscenic \
    "

for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh $tool python -c "import $tool"
done

for tool in scvi scgen unitvelo scmomat
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh scvi-scgen-unitvelo-scmomat python -c "import $tool"
done

echo "scReadSim"
docker run -it --rm rnakato/shortcake run_env.sh screadsim python -c "import scReadSim"

echo "SEACells"
docker run -it --rm rnakato/shortcake run_env.sh seacells python -c "import SEACells"

echo "rapids_singlecell"
docker run -it --gpus all --rm rnakato/shortcake run_env.sh rapids_singlecell python -c "import rapids_singlecell"

#echo "SAVERX"
#docker run -it --rm rnakato/shortcake run_env.sh saver-x R -e "library(SAVERX)"

#echo "SCCAF"
#docker run -it --rm rnakato/shortcake run_env.sh SCCAF python -c "from SCCAF import *"

echo "EEISP"
docker run -it --rm rnakato/shortcake eeisp --version
