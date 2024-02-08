sing="singularity exec --nv --bind /work,/work2,/work3 /work3/SingularityImages/shortcake.1.9.0.sif"

for tool in miloR SingleCellExperiment liana SCP dplyr patchwork scriabin tricycle presto EpiSCORE DropletQC BayesPrism UpSetR dyngen CellChat ComplexHeatmap Seurat SeuratDisk SeuratData Signac MOFA2 FLOWMAPR stringi metacell scAI harmony MUDAN DoubletFinder liger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 JASPAR2020 JASPAR2022 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR conos CoGAPS scran slingshot scRNAseq scTensor scater BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10 celldex # cellassign monocle 
do
    $sing R -e "library("$tool")"
done

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
    $sing run_env.sh shortcake_default python -c "import "$tool""
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
"
for tool in $toollist
do
    command="python -c \"import "$tool"\""
    echo $command
    $sing run_env.sh $tool python -c "import $tool"
done

for tool in scvi scgen unitvelo scmomat
do
    command="python -c \"import "$tool"\""
    echo $command
    $sing run_env.sh scvi-scgen-unitvelo-scmomat python -c "import $tool"
done

echo "scReadSim"
$sing run_env.sh screadsim python -c "import scReadSim"

echo "SEACells"
$sing run_env.sh seacells python -c "import SEACells"

echo "rapids_singlecell"
$sing run_env.sh rapids_singlecell python -c "import rapids_singlecell"
