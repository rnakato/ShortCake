# ShortCake🍰
A docker image for single-cell analyses. It's on docker-hub and GitHub.
This repository is an update of [singlecell_jupyter](https://hub.docker.com/repository/docker/rnakato/singlecell_jupyter).

## Changelog

See [Changelog](https://github.com/rnakato/ShortCake/blob/master/ChangeLog.md)
## Included tools (latest)

- **Pipeline**: [Seurat](https://satijalab.org/seurat/) (and [Seurat wrappers](https://github.com/satijalab/seurat-wrappers)), [scater](https://bioconductor.org/packages/release/bioc/html/scater.html), [scran](https://bioconductor.org/packages/release/bioc/html/scran.html), [Scanpy](https://scanpy.readthedocs.io/en/stable/), [scvi-tools](https://scvi-tools.org/) (previous scVI), [monet](https://github.com/flo-compbio/monet), [Pagoda2](https://github.com/kharchenkolab/pagoda2), [kallisto-bustools](https://www.kallistobus.tools/)
- **Quality check**: [DropletQC](https://github.com/powellgenomicslab/DropletQC)
- **Doublet finding**: [Scrublet](https://github.com/swolock/scrublet), [DoubletFinder](https://github.com/chris-mcginnis-ucsf/DoubletFinder)
- **Batch correction and data integration**: [Harmony](https://portals.broadinstitute.org/harmony/articles/quickstart.html), [scmap](https://www.sanger.ac.uk/tool/scmap/), [scBio](https://bioinformaticshome.com/db/tool/scBio), [SingleCellNet](https://github.com/pcahan1/singleCellNet)
- **Clustering**: [SC3](https://bioconductor.org/packages/release/bioc/html/SC3.html), [metacell](https://tanaylab.github.io/metacell/), [SCCAF](https://github.com/SCCAF/sccaf), [Constclust](https://constclust.readthedocs.io/en/latest/), [bigSCale2](https://github.com/iaconogi/bigSCale2), [
scTriangulate](https://github.com/frankligy/scTriangulate)
- **Cell-type annotation**: [RCA](https://github.com/prabhakarlab/RCAv2), [garnett](https://cole-trapnell-lab.github.io/garnett/), [scCatch](https://github.com/ZJUFanLab/scCATCH), [SingleR](https://github.com/dviraran/SingleR), [ikarus](https://github.com/BIMSBbioinfo/ikarus)
- **Trajectory (pseudo-time) analysis**: [Monocle2/3](https://cole-trapnell-lab.github.io/monocle3/), [slingshot](https://bioconductor.org/packages/devel/bioc/vignettes/slingshot/inst/doc/vignette.html), [Palantir](https://github.com/dpeerlab/Palantir), [FROWMAP](https://github.com/zunderlab/FLOWMAP/)
- **RNA velocity**: [velocyto](http://velocyto.org/), [scVelo](https://scvelo.readthedocs.io/en/stable/), [CellRank](https://cellrank.readthedocs.io/en/stable/), [Dynamo](https://dynamo-release.readthedocs.io/en/latest/)
- **Gene network**: WGCNA, [SCENIC](https://scenic.aertslab.org/) (pySCENIC), [CellOracle](https://morris-lab.github.io/CellOracle.documentation/), [Dictys](https://github.com/pinellolab/dictys)
- **Cell-cell interaction**: [CellPhoneDB](https://www.cellphonedb.org/), [SingleCellSignalR](https://www.bioconductor.org/packages/release/bioc/html/SingleCellSignalR.html), [scTensor](https://www.bioconductor.org/packages/release/bioc/html/scTensor.html), [cell2cell](https://earmingol.github.io/cell2cell/), [CellChat](http://www.cellchat.org/)
- **Data imputation**: [MAGIC](https://github.com/KrishnaswamyLab/MAGIC), [SAVER](https://github.com/mohuangx/SAVER), [scImpute](https://github.com/Vivianstats/scImpute), [SCRABBLE](https://github.com/tanlabcode/SCRABBLE), [RECODE](https://yusuke-imoto-lab.github.io/RECODE/)
- **Multi-modal analysis**: [LIGER](https://github.com/welch-lab/liger), [scAI](https://github.com/sqjin/scAI), [MOFA2](https://biofam.github.io/MOFA2/), [scMoMaT](https://github.com/PeterZZQ/scMoMaT), [MARIO](https://github.com/shuxiaoc/mario-py)
- **Bulk deconvolution**: [SCDC](https://meichendong.github.io/SCDC/articles/SCDC.html), [MuSiC](https://xuranw.github.io/MuSiC/articles/MuSiC.html), [BayesPrism](https://github.com/Danko-Lab/BayesPrism), [AutoGeneS](https://github.com/theislab/AutoGeneS)
- **Simulation**: [Splatter](https://github.com/Oshlack/splatter), [dyngen](https://github.com/dynverse/dyngen), [scGen](https://github.com/theislab/scgen)
- **Others**: [Sleepwalk](https://anders-biostat.github.io/sleepwalk/), [singleCellHaystack](https://github.com/alexisvdb/singleCellHaystack), [SignatuR](https://github.com/carmonalab/SignatuR), [ComplexHeatmap](https://jokergoo.github.io/ComplexHeatmap-reference/book/)
- **scATAC-seq**: [Cicero](https://cole-trapnell-lab.github.io/cicero-release/docs_m3/), [chromVAR](https://bioconductor.org/packages/release/bioc/html/chromVAR.html), [ArchR](https://www.archrproject.com/), [Signac](https://stuartlab.org/signac/index.html), [cisTopic](https://github.com/aertslab/cisTopic), [EpiScanpy](https://episcanpy.readthedocs.io/en/latest/)

- **Database (genome)**: BSgenome.Hsapiens.UCSC.hg19, BSgenome.Hsapiens.UCSC.hg38, BSgenome.Mmusculus.UCSC.mm10, BSgenome.Scerevisiae.UCSC.sacCer3, BSgenome.Dmelanogaster.UCSC.dm6
- **Database (gene)**: EnsDb.Hsapiens.v75, EnsDb.Hsapiens.v79, EnsDb.Hsapiens.v86, EnsDb.Mmusculus.v79
- **Database (motif)**: JASPAR2016, JASPAR2018, JASPAR2020, JASPAR2022
- **SeuratData**: ifnb_3.1.0, panc8_3.0.2, pbmcsca_3.0.0, pbmc3k_3.1.4, celegans.embryo_0.1.0, cbmc_3.1.4, hcabm40k_3.0.0, thp1.eccite_3.1.5, stxBrain_0.1.1, stxKidney_0.1.0, bmcite_0.3.0, pbmcMultiome_0.1.2, ssHippo_3.1.4

## Run

For Docker:

    # pull docker image
    docker pull rnakato/shortcake

    # container login
    docker run [--gpus all] --rm -it rnakato/shortcake /bin/bash
    # jupyter notebook (see 'mnt/' directory in the notebook )
    docker run [--gpus all] --rm -p 8888:8888 -v (your directory):/work/mnt rnakato/shortcake jupyternotebook.sh

For Singularity:

    # build image
    singularity build -F shortcake.sif docker://rnakato/shortcake
    # jupyter notebook
    singularity exec [--nv] shortcake.sif jupyternotebook.sh
    # execute R directory
    singularity exec [--nv] shortcake.sif R

## Build image from Dockerfile
First clone and move to the repository

    git clone https://github.com/rnakato/ShortCake
    cd ShortCake

- Because the Dockerfile installs many packages from GitHub, first get [a GitHub token from your own repository](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) and add it in `Docker_R/docker-compose.R.yml` and `Docker_Python/docker-compose.yml`.
- Download the dataset of [SeuratData](https://github.com/satijalab/seurat-data) from [our GoogleDrive](https://drive.google.com/file/d/1oQbZztyt3tLppWjklvS0Fn4ayG_zhvq4/view?usp=sharing) and unzip it in ``Docker_R`` directory.

Then build packages:

    # build R packages
    cd Docker_R
    docker-compose -f docker-compose.R.yml build
    # Then build Python packages
    cd ../Docker_Python/
    docker-compose -f docker-compose.yml build

## Singularity images

Prebuild singularity images (version 3.8.5) are available on our [Google Drive](https://drive.google.com/drive/folders/1x1mqN3Im4RGZKnuhiDKfqYLcL86an7s8?usp=sharing).

## Contact

Ryuichiro Nakato: rnakato AT iqb.u-tokyo.ac.jp
