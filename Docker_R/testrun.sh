#!/usr/bin/env bash
set -u

TOTAL=0
FAILURES=0
FAILED_LABELS=()

check() {
    local label="$1"
    shift
    TOTAL=$((TOTAL + 1))
    echo
    echo "================================================================"
    echo "[$TOTAL] $label"
    echo "================================================================"
    echo "+ $*"
    if "$@"; then
        echo "OK: $label"
    else
        local status=$?
        echo "FAILED($status): $label" >&2
        FAILURES=$((FAILURES + 1))
        FAILED_LABELS+=("$label")
    fi
}

toollist="kBET GEDI scplotter DIRECTNET GEMLI miloR SingleCellExperiment liana cellAlign SCP dplyr patchwork scriabin tricycle presto EpiSCORE DropletQC BayesPrism UpSetR dyngen CellChat ComplexHeatmap Seurat SeuratWrappers Azimuth SeuratDisk SeuratData Signac MOFA2 stringi harmony MUDAN DoubletFinder rliger monocle3 garnett ArchR chromVAR JASPAR2016 JASPAR2018 JASPAR2020 JASPAR2022 JASPAR2024 SingleCellSignalR SAVER ClusterR SCRABBLE splatter loomR singleCellNet scCATCH velocyto.R singleCellHaystack scImpute SingleR conos CoGAPS scran slingshot scRNAseq scTensor scater sleepwalk scBio RCA SC3 scmap WGCNA Banksy InstaPrism scDesign3 SCENT SignatuR scRepertoire pagoda2 bigSCale cicero SCDC MuSiC BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10 BSgenome.Scerevisiae.UCSC.sacCer3 BSgenome.Dmelanogaster.UCSC.dm6 EnsDb.Hsapiens.v75 EnsDb.Hsapiens.v79 EnsDb.Hsapiens.v86 EnsDb.Mmusculus.v79 celldex BPCells BUSpaRse CIPR N2R Nebulosa RcppSpdlog batchelor bit64 ggbio glmGamPoi glmpca metap miQC qqconf rsvd scry"
# FLOWMAPR, cellassign, monocle are intentionally excluded (unresolved install errors, see README)

for tool in $toollist
do
    check "R: library($tool)" docker run --rm rnakato/shortcake_r:4.0.0 R -e "library("$tool")"
done

echo
echo "================================================================"
echo "Summary"
echo "================================================================"
echo "Total checks : $TOTAL"
echo "Failures     : $FAILURES"

if [[ "$FAILURES" -gt 0 ]]; then
    echo
    echo "Failed:"
    printf '  - %s\n' "${FAILED_LABELS[@]}"
    exit 1
fi

echo "All checks passed."
