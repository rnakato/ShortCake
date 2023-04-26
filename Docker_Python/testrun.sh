
toollist="
    llvmlite \
    numba \
    cython \
    louvain \
    leidenalg \
    magic \
    autogenes \
    palantir \
    sctriangulate \
    scrublet \
    scvelo \
    bbknn \
    screcode
"
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake python -c "import "$tool""
done

toollist="
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
    scgen \
    scvi
"

for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh $tool python -c "import $tool"
done

echo "SAVERX"
docker run -it --rm rnakato/shortcake run_env.sh saver-x R -e "library(SAVERX)"

echo "SCCAF"
docker run -it --rm rnakato/shortcake run_env.sh SCCAF python -c "from SCCAF import SCCAF_assessment"

echo "EEISP"
docker run -it --rm rnakato/shortcake eeisp --version

