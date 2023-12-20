toollist="
    llvmlite \
    numba \
    cython \
    celltypist \
    louvain \
    leidenalg \
    magic \
    autogenes \
    palantir \
    sctriangulate \
    scrublet \
    scvelo \
    bbknn \
    screcode \
    unitvelo
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
    rapids_singlecell 
"

for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh $tool python -c "import $tool"
done

for tool in #scvi scgen scmomat
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh scvi-scgen-scmomat python -c "import $tool"
done

for tool in #gears
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh stellar-gears-saturn python -c "import $tool"
done

echo "scReadSim"
docker run -it --rm rnakato/shortcake run_env.sh screadsim python -c "import scReadSim"

echo "SEACells"
docker run -it --rm rnakato/shortcake run_env.sh seacells python -c "import SEACells"

#echo "STELLAR"
#docker run -it --rm rnakato/shortcake run_env.sh stellar python -c "from STELLAR import STELLAR"

#echo "SAVERX"
#docker run -it --rm rnakato/shortcake run_env.sh saver-x R -e "library(SAVERX)"

#echo "SCCAF"
#docker run -it --rm rnakato/shortcake run_env.sh SCCAF python -c "from SCCAF import *"

echo "EEISP"
docker run -it --rm rnakato/shortcake eeisp --version
