for tool in UpSetR dyngen CellChat ComplexHeatmap Seurat SeuratDisk SeuratData Signac SAVERX MOFA2 FLOWMAPR stringi metacell scAI harmony MUDAN DoubletFinder liger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 JASPAR2020 JASPAR2022 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR conos CoGAPS scran slingshot scRNAseq scTensor monocle scater BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10 celldex # cellassign
do
    docker run -it --rm rnakato/shortcake R -e "library("$tool")"
done
