for tool in presto EpiSCORE DropletQC BayesPrism UpSetR dyngen CellChat ComplexHeatmap Seurat SeuratDisk SeuratData Signac MOFA2 FLOWMAPR stringi metacell scAI harmony MUDAN DoubletFinder liger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 JASPAR2020 JASPAR2022 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR conos CoGAPS scran slingshot scRNAseq scTensor monocle scater BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10 celldex # cellassign
do
#    docker run -it --rm rnakato/shortcake R -e "library("$tool")"
    singularity exec --bind /work,/work2 /work/SingularityImages/shortcake.1.5.0.sif R -e "library("$tool")"
done

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
    screcode \
    multivelo 
"
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh shortcake_default python -c "import "$tool""
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
    pyscenic
    
"
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh $tool python -c "import $tool"
done

for tool in scvi scgen scmomat
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake run_env.sh scvi-scgen-scmomat python -c "import $tool"
done

#echo "SAVERX"
#docker run -it --rm rnakato/shortcake run_env.sh saver-x R -e "library(SAVERX)"

echo "SCCAF"
docker run -it --rm rnakato/shortcake run_env.sh SCCAF python -c "from SCCAF import SCCAF_assessment"

echo "EEISP"
docker run -it --rm rnakato/shortcake eeisp --version

