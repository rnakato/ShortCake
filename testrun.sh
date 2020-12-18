for tool in metacell cellassign scAI harmony MUDAN DoubletFinder liger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR Signac conos CoGAPS scran slingshot scRNAseq scTensor monocle scater
do
    docker run -it --rm rnakato/singlecell_jupyter R -e "library("$tool")"
done
