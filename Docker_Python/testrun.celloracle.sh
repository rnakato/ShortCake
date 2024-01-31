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
    docker run -it --rm docker_python_celloracle run_env.sh shortcake_default python -c "import "$tool""
done

toollist=" celloracle "

for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm docker_python_celloracle run_env.sh $tool python -c "import $tool"
done

echo "Genes2Genes"
docker run -it --rm docker_python_celloracle run_env.sh shortcake_default python -c "from genes2genes import Main"

#echo "RENGE"
#docker run -it --rm docker_python_celloracle run_env.sh renge python -c "from renge import Renge"

