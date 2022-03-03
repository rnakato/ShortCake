for tool in CellChat ComplexHeatmap Seurat SeuratDisk SeuratData Signac SAVERX MOFA2 FLOWMAPR stringi metacell cellassign scAI harmony MUDAN DoubletFinder liger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR conos CoGAPS scran slingshot scRNAseq scTensor monocle scater BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10 celldex
do
    docker run -it --rm rnakato/singlecell_jupyter R -e "library("$tool")"
done
