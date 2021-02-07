for tool in stringi metacell cellassign scAI harmony MUDAN DoubletFinder liger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR Signac conos CoGAPS scran slingshot scRNAseq scTensor monocle scater BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10 celldex Seurat SeuratDisk SeuratData SAVERX MOFA2 FLOWMAPR
do
    docker run -it --rm rnakato/singlecell_jupyter R -e "library("$tool")"
done
