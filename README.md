
# <img src = "img/ShortCakeLogo.jpg" width = 120ptx> ShortCake🍰 

ShortCake is an integrated platform for efficient and reproducible single-cell analysis using the Docker system.

This is an update of the [singlecell_jupyter](https://hub.docker.com/repository/docker/rnakato/singlecell_jupyter) repository.

## 0. Changelog

See [Changelog](https://github.com/rnakato/ShortCake/blob/master/ChangeLog.md)

## 1. Included tools (v3.4.0)

(The tools that cannot be installed due to unresolved errors are crossed out.)

- **Pipeline**: [Seurat](https://satijalab.org/seurat/) (and [Seurat wrappers](https://github.com/satijalab/seurat-wrappers)), [scater](https://bioconductor.org/packages/release/bioc/html/scater.html), [scran](https://bioconductor.org/packages/release/bioc/html/scran.html), [Scanpy](https://scanpy.readthedocs.io/en/stable/), [scvi-tools](https://scvi-tools.org/) (previous scVI), [Pagoda2](https://github.com/kharchenkolab/pagoda2), [kallisto-bustools](https://www.kallistobus.tools/), [SCAFE](https://github.com/chung-lab/SCAFE), [rapids_singlecell](https://github.com/scverse/rapids_singlecell)
- **Quality check**: [DropletQC](https://github.com/powellgenomicslab/DropletQC)
- **Doublet finding**: [Scrublet](https://github.com/swolock/scrublet), [DoubletFinder](https://github.com/chris-mcginnis-ucsf/DoubletFinder)
- **Batch correction and data integration**: [Harmony](https://portals.broadinstitute.org/harmony/articles/quickstart.html), [scmap](https://www.sanger.ac.uk/tool/scmap/), [scBio](https://bioinformaticshome.com/db/tool/scBio), [SingleCellNet](https://github.com/pcahan1/singleCellNet), [scib](https://github.com/theislab/scib), [scanorama](https://github.com/brianhie/scanorama), [kBET](https://github.com/theislab/kBET)
- **Clustering**: [SC3](https://bioconductor.org/packages/release/bioc/html/SC3.html), [metacell](https://tanaylab.github.io/metacell/), [SCCAF](https://github.com/SCCAF/sccaf), [Constclust](https://constclust.readthedocs.io/en/latest/), [bigSCale2](https://github.com/iaconogi/bigSCale2), [scTriangulate](https://github.com/frankligy/scTriangulate), [miloR](https://github.com/MarioniLab/miloR), [GEDI](https://github.com/csglab/GEDI)
- **Cell-type annotation**: [RCA](https://github.com/prabhakarlab/RCAv2), [garnett](https://cole-trapnell-lab.github.io/garnett/), [scCatch](https://github.com/ZJUFanLab/scCATCH), [SingleR](https://github.com/dviraran/SingleR), [CellTypist](https://github.com/Teichlab/celltypist), [ikarus](https://github.com/BIMSBbioinfo/ikarus)
- **Trajectory (pseudo-time) analysis**: [Monocle3](https://cole-trapnell-lab.github.io/monocle3/), [slingshot](https://bioconductor.org/packages/devel/bioc/vignettes/slingshot/inst/doc/vignette.html), [Palantir](https://github.com/dpeerlab/Palantir), [PHATE](https://github.com/KrishnaswamyLab/PHATE), ~~[FROWMAP](https://github.com/zunderlab/FLOWMAP/)~~
- **RNA velocity**: [velocyto](http://velocyto.org/), [scVelo](https://scvelo.readthedocs.io/en/stable/), [CellRank](https://cellrank.readthedocs.io/en/stable/), [Dynamo](https://dynamo-release.readthedocs.io/en/latest/), [MultiVelo](https://github.com/welch-lab/MultiVelo), [UniTVelo](https://github.com/StatBiomed/UniTVelo)
- **Trajectory alignment**: [cellAlign](https://github.com/shenorrLabTRDF/cellAlign), [Genes2Genes](https://teichlab.github.io/Genes2Genes/)
- **Spatial transcriptome**: [STELLAR](http://snap.stanford.edu/stellar/), [BANKSY](https://github.com/prabhakarlab/Banksy), [Squidpy](https://squidpy.readthedocs.io/), [singleCellHaystack](https://github.com/alexisvdb/singleCellHaystack)
- **Cell-cycle prediction**: [tricycle](https://github.com/hansenlab/tricycle)
- **Gene network**: WGCNA, [SCENIC](https://scenic.aertslab.org/) (pySCENIC), [SCENIC+](https://github.com/aertslab/scenicplus), [CellOracle](https://morris-lab.github.io/CellOracle.documentation/), [EEISP](https://github.com/nakatolab/EEISP)
- **Cell-cell interaction**: [CellPhoneDB](https://www.cellphonedb.org/), [SingleCellSignalR](https://www.bioconductor.org/packages/release/bioc/html/SingleCellSignalR.html), [scTensor](https://www.bioconductor.org/packages/release/bioc/html/scTensor.html), [cell2cell](https://earmingol.github.io/cell2cell/), [CellChat](http://www.cellchat.org/), [Scriabin](https://github.com/BlishLab/scriabin)
- **Data imputation**: [MAGIC](https://github.com/KrishnaswamyLab/MAGIC), [SAVER](https://github.com/mohuangx/SAVER), [scImpute](https://github.com/Vivianstats/scImpute), [SCRABBLE](https://github.com/tanlabcode/SCRABBLE), [RECODE](https://yusuke-imoto-lab.github.io/RECODE/)
- **Multi-modal analysis**: [LIGER](https://github.com/welch-lab/liger), [scAI](https://github.com/sqjin/scAI), [MOFA2](https://biofam.github.io/MOFA2/), [scMoMaT](https://github.com/PeterZZQ/scMoMaT), [Mowgli](https://github.com/cantinilab/mowgli), [MARIO](https://github.com/shuxiaoc/mario-py), [SATURN](https://github.com/snap-stanford/SATURN), [Moscot](https://moscot.readthedocs.io/en/latest/), [SCOT](https://rsinghlab.github.io/SCOT/), [DIRECT-NET](https://github.com/zhanglhbioinfor/DIRECT-NET)
- **Visualization**: [ComplexHeatmap](https://jokergoo.github.io/ComplexHeatmap-reference/book/), [scplotter](https://pwwang.github.io/scplotter/index.html), [Sleepwalk](https://anders-biostat.github.io/sleepwalk/)
- **Bulk deconvolution**: [SCDC](https://meichendong.github.io/SCDC/articles/SCDC.html), [MuSiC](https://xuranw.github.io/MuSiC/articles/MuSiC.html), [BayesPrism](https://github.com/Danko-Lab/BayesPrism), [InstaPrism](https://github.com/humengying0907/InstaPrism), [AutoGeneS](https://github.com/theislab/AutoGeneS), [scranPY](https://github.com/sfortma2/scranPY)
- **Gene perturbation prediction**: [GEARS](https://github.com/snap-stanford/GEARS)
- **Simulation**: [Splatter](https://github.com/Oshlack/splatter), [dyngen](https://github.com/dynverse/dyngen), [scGen](https://github.com/theislab/scgen), [scReadSim](https://github.com/JSB-UCLA/scReadSim), [scDesign3](https://github.com/SONGDONGYUAN1994/scDesign3)
- **scATAC-seq**: [Cicero](https://cole-trapnell-lab.github.io/cicero-release/docs_m3/), [chromVAR](https://bioconductor.org/packages/release/bioc/html/chromVAR.html), [ArchR](https://www.archrproject.com/), [Signac](https://stuartlab.org/signac/index.html), [cisTopic](https://github.com/aertslab/cisTopic), [EpiScanpy](https://episcanpy.readthedocs.io/en/latest/), [SCENT](https://github.com/immunogenomics/SCENT)
- **Immune receptor analysis**: [scRepertoire](https://www.bioconductor.org/packages/release/bioc/html/scRepertoire.html)
- **Others**: [SignatuR](https://github.com/carmonalab/SignatuR), [decoupler](https://decoupler-py.readthedocs.io/en/latest/index.html)


- **Database (genome)**: BSgenome.Hsapiens.UCSC.hg19, BSgenome.Hsapiens.UCSC.hg38, BSgenome.Mmusculus.UCSC.mm10, BSgenome.Scerevisiae.UCSC.sacCer3, BSgenome.Dmelanogaster.UCSC.dm6
- **Database (gene)**: EnsDb.Hsapiens.v75, EnsDb.Hsapiens.v79, EnsDb.Hsapiens.v86, EnsDb.Mmusculus.v79
- **Database (motif)**: JASPAR2016, JASPAR2018, JASPAR2020, JASPAR2022, JASPAR2024
- **SeuratData**: ifnb_3.1.0, panc8_3.0.2, pbmcsca_3.0.0, pbmc3k_3.1.4, celegans.embryo_0.1.0, cbmc_3.1.4, hcabm40k_3.0.0, thp1.eccite_3.1.5, stxBrain_0.1.1, stxKidney_0.1.0, bmcite_0.3.0, pbmcMultiome_0.1.2, ssHippo_3.1.4

## 2. (new!) Flavors of ShortCake

The ShortCake Docker image is large, at about 100 GB. 

Since ShortCake version 3, we have created several flavors to reduce the size of the image and make it easier to use, as shown below.

- **shortcake_seurat**: Contains only Seurat and its related packages.
- **shortcake_r**: Contains additional R packages installed on top of `shortcake_seurat`. Jupyter notebook is available, but Python tools are not installed.
- **shortcake_light**: Installs the shortcake_default environment on top of `shortcake_r`. This flavor includes Seurat, Scanpy, Monocle3, and scVelo, and is sufficient for most users.
- **shortcake**: Installs almost all Python virtual environments on top of `shortcake_light`. The only exceptions are the scVI and rapids_singlecell environments.
- **shortcake_scvi**: Installs the scVI environment on top of `shortcake_light`.
- **shortcake_rapidsc**: Installs the shortcake_rapidsc environment on top of `shortcake_light`.
- **shortcake_full**: The full image with all tools installed.

For example, you can use `shortcake_light` version 3.4.0 with this command:

    docker run --rm -p 8888:8888 -it rnakato/shortcake_light:3.4.0 jupyternotebook.sh

## 3. Run

### 3.1 Docker

For Docker:

You can pull (download) the ShortCake docker image with this command:

    docker pull rnakato/shortcake:<version>

Then you can run ShortCake with the command:

    # Container login
    docker run [--gpus all] --rm -it rnakato/shortcake /bin/bash
    
    # Execute jupyter notebook (see 'mnt/' directory in the notebook )
    docker run [--gpus all] --rm -p 8888:8888 -v (your directory):/work/mnt rnakato/shortcake jupyternotebook.sh

- The `--gpus all` option is necessary when using a GPU (e.g., scvi-tools).
- The `-p 8888:8888` option maps the container's port 8888 to the host's port 8888. This allows you to access the Jupyter notebook from your web browser.
- The `-v (your directory):/work/mnt` option mounts your local directory to the `/work/mnt` directory in the container. You can change `(your directory)` to the path of your local directory where you want to save or load data. In the Jupyter notebook, you can see the `/work/mnt` directory.

For more information about Docker, see [the original website](https://docs.docker.com/get-started/overview/).

### 3.2. Singularity (Apptainer)

(Note: Singularity has recently been renamed [Apptainer](https://apptainer.org/). To use Apptainer, simply replace the `singularity` command with `apptainer`.)

You can build the singularity file (.sif) of ShortCake with this command:

    # If you use singularity
    singularity build -F shortcake.sif docker://rnakato/shortcake    
    # If you use apptainer
    apptainer build -F shortcake.sif docker://rnakato/shortcake

Instead, you can download the singularity image of ShortCake from our [Dropbox](https://www.dropbox.com/scl/fo/lptb68dirr9wcncy77wsv/h?rlkey=whhcaxuvxd1cz4fqoeyzy63bf&dl=0) (We use singularity version 3.8.5).

Then you can run ShortCake with the command:

    # Execute Jupyter Notebook (Python and R)
    singularity exec [--nv] shortcake.sif jupyternotebook.sh
    
    # Execute RStudio Server
    singularity exec [--nv] shortcake.sif rserver.sh <port>

    # Execute R directory
    singularity exec [--nv] shortcake.sif R

The `--nv` option is needed if you use a GPU.

## 4. Usage

### 4.1 Virtual environments for Python

To avoid version conflicts between tools, we created several Python environments with [micromamba](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html).
You can see the list of environments installed in the image with `micromamba env list` command as follows:

    $ docker run -it --rm rnakato/shortcake:3.4.0 micromamba env list
        Name                           Active  Path
        ─────────────────────────────────────────────────────────────────────────────────────────────
        base                           *       /opt/micromamba
        cell2cell-screadsim                    /opt/micromamba/envs/cell2cell-screadsim
        celloracle                             /opt/micromamba/envs/celloracle
        cellphonedb                            /opt/micromamba/envs/cellphonedb
        decoupler-liana-sctriangulate          /opt/micromamba/envs/decoupler-liana-sctriangulate
        dynamo-moscot                          /opt/micromamba/envs/dynamo-moscot
        episcanpy                              /opt/micromamba/envs/episcanpy
        genes2genes-mowgli                     /opt/micromamba/envs/genes2genes-mowgli
        ikarus-novosparc                       /opt/micromamba/envs/ikarus-novosparc
        mario                                  /opt/micromamba/envs/mario
        scenic                                 /opt/micromamba/envs/scenic
        seacells                               /opt/micromamba/envs/seacells
        shortcake_default                      /opt/micromamba/envs/shortcake_default
        squidpy                                /opt/micromamba/envs/squidpy


Note that the `base` environment does not include any tools other than Jupyter notebook and EEISP.
`shortcake_default` is the default environment with Python3.10 and contains vairous tools as below:

- scanpy
- scvelo
- cellrank
- harmonypy
- anndata2ri
- autogenes
- bbknn
- cellmap
- moscot
- celltypist
- doubletdetection
- magic-impute
- palantir
- constclust
- multivelo
- screcode
- scrublet
- snapatac2
- velocyto
- scranPY
- phate
- scib
- scanorama

The other environments are named after the tools they contain.


### 4.2 Jupyter

We recommend using Jupyter Notebook (JupyterLab) to use ShortCake:

    singularity exec shortcake.sif jupyternotebook.sh

Specify the appropriate kernel (environment) to use them.
In addition, the R command and all R tools are usable in the ``R`` kernel.

<img src="https://github.com/rnakato/ShortCake/blob/master/img/jupyter_kernel.png" width="240" valign="middle" alt="jupyter_kernel" />


### 4.3 Rstudio

ShortCake also provides the Rstudio environment. 
We recommend using Rstudio server as follows:

    # Docker
    docker run -it -p 8787:8787 --rm rnakato/shortcake_light:3.4.0 rserver.sh 8787
    # Singularity
    singularity exec shortcake.sif rserver.sh 8787

Then, access `http://localhost:8787` from your web browser. The default username and password are both `rstudio`.

You can also run Rstudio directly without a server:

    singularity exec shortcake.sif rstudio

Note that Rstudio requires a GUI (Graphical User Interface) environment, so you will need to set up X11 forwarding to use it.

### 4.4 Command line

Several single-cell tools provide command-line tools. 
For example, [velocyto](https://velocyto.org/) provides the command ``velocyto run10x`` to generate a .loom file. 
It can be executed as follows:

    singularity exec shortcake.sif velocyto run10x -m repeat_msk.gtf <10Xdir> <gtf>

To use a virtual environment from the command line, activate it with the ``run_env.sh`` script:

    singularity exec shortcake.sif run_env.sh <environment> <command>
    
    # Example to activate "celloracle" environment
    singularity exec shortcake.sif run_env.sh celloracle python -c "import celloracle"

It is also possible to log directly into the ShortCake container and work inside it using the command-line interface. 

    docker run --rm -p 8888:8888 rnakato/shortcake /bin/bash


## 5. Build the image from Dockerfile

First, clone and move to the repository

    git clone https://github.com/rnakato/ShortCake
    cd ShortCake

## 5.1 Get your GitHub token

Since the Dockerfile installs many packages from GitHub, first get [a GitHub token from your own repository](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token). Next, create `Docker_R/.env` and `Docker_Python/.env` files and store the token as follows:

    GITHUB_PAT=<your_GitHub_token>

## 5.2 Build shortcake_seurat and shortcake_r

Move `Docker_R` directory:

    cd Docker_R/

Download the [SeuratData](https://github.com/satijalab/seurat-data) dataset using ``wget.sh`` in the ``Docker_R/SeuratData`` directory:

    cd SeuratData/
    sh wget.sh

Then build packages:

    cd Docker_R
    # build both shortcake_seurat and shortcake_r
    docker-compose -f docker-compose.yml build
    # build shortcake_seurat only
    docker-compose -f docker-compose.yml build seurat 
    # build shortcake_r only
    docker-compose -f docker-compose.yml build r

## 5.3 Build other flavors

Move to 'Python' directory:

    cd ../Docker_Python/

Then build Python packages:

    # build all the flavors below
    docker-compose -f docker-compose.yml build
    # build shortcake_light
    docker-compose -f docker-compose.yml build light
    # build shortcake
    docker-compose -f docker-compose.yml build default
    # build shortcake_full
    docker-compose -f docker-compose.yml build full
    # build shortcake_scvi
    docker-compose -f docker-compose.yml build scvi
    # build shortcake_rapidsc
    docker-compose -f docker-compose.yml build rapidsc
