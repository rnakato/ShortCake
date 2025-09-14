for tool in kBET GEDI scplotter DIRECTNET GEMLI miloR SingleCellExperiment liana cellAlign SCP dplyr patchwork scriabin tricycle presto EpiSCORE DropletQC BayesPrism UpSetR dyngen CellChat ComplexHeatmap Seurat SeuratDisk SeuratData Signac MOFA2 stringi metacell scAI harmony MUDAN DoubletFinder liger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 JASPAR2020 JASPAR2022 JASPAR2024 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR conos CoGAPS scran slingshot scRNAseq scTensor scater BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10 celldex # FLOWMAPR cellassign monocle
do
    docker run -it --rm rnakato/shortcake_r:3.4.0 R -e "library("$tool")"
done
