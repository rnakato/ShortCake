# Changelog

## 2025.1.31: version 3.2.0
- Added [SCENIC+](https://github.com/aertslab/scenicplus) in the ``scenicplus`` environment
- Added [decoupler](https://decoupler-py.readthedocs.io/en/latest/index.html) in the ``shortcake_default`` environment
- In the ``shortcake_default`` environment,
   - Updated Python from 3.9 to 3.10
   - Updated scanpy from 1.9.8 to 1.10.4
   - Updated cellrank from 1.5.1 to 2.0.6
   - Updated pandas from 1.2.1 to 1.5.0
   - Updated scvelo from 0.2.5 to 0.3.1
   - Updated screcode from 0.2.5 to 1.0.0


### 2024.11.24: version 3.1.0
- Updated jaxlib to 0.3.7 in the ``scvi-scgen-scmomat-unitvelo`` environment to fix an installation issue (https://github.com/rnakato/ShortCake/issues/13)
- Added [doubletdetection](https://github.com/JonathanShor/DoubletDetection) in the ``scvi-scgen-scmomat-unitvelo`` environment
- Fixed an installation issue of velocyto-R
- Added [GEMLI](https://github.com/UPSUTER/GEMLI)
- Added [DIRECT-NET](https://github.com/zhanglhbioinfor/DIRECT-NET)
- Added [scplotter](https://pwwang.github.io/scplotter/index.html)
- Added [parallel-fastq-dump](https://github.com/rvalieris/parallel-fastq-dump)
- Updated rapids_singlecell from 0.10.2 to 0.10.10
- Updated SRA Toolkit from 3.0.10 to v3.1.1
- Removed ``MeSH.Hsa.eg.db`` because it is not available for Bioconductor version '3.18'

### 2024.5.22: version 3.0.0
- Changed Python environment from conda to micromamba (`/opt/micromamba`)
- Added `glmGamPoi` for faster computation.
- Created different flavors of **ShortCake** to improve usability.
- Added [cell2fate](https://github.com/BayraktarLab/cell2fate)
- ~~Added [RENGE](https://github.com/masastat/RENGE)~~
- Added [BANKSY](https://github.com/prabhakarlab/Banksy)
- Removed monet

### 2024.2.14: version 2.0.0
- Frozen ShortCake.Python (version1) Dockerfile
- Released ShortCake.Python version2 (`ShortCake_ver2`)
- Added [CellTypist](https://github.com/Teichlab/celltypist)
- Added [CellMap](https://github.com/yusuke-imoto-lab/CellMap)
- Fixed bug in `scvi-scgen-scmomat-unitvelo` Conda environment by adjusting the version of `jax`.
- Fixed bug in `celloracle` Conda environment by updating the Python version from 3.7 to 3.8.
- Install MS core fonts (ttf-mscorefonts-installer)

### 2024.2.8: version 1.9.1
- Downgrade notebook to 6.X to change back to UI of jupyter notebook
- Fixed bug in CellRank environment: downgraded pandas to <2 to avoid "AttributeError: can't set attribute" error
    - See https://github.com/theislab/cellrank/issues/1078 for detail
- Added [cellAlign](https://github.com/shenorrLabTRDF/cellAlign)

### 2024.1.31: version 1.9.0
- Added [Mowgli](https://github.com/cantinilab/mowgli)
- Added [SCENT](https://github.com/immunogenomics/SCENT)
- Added [moslin](https://github.com/theislab/moslin) (included in Moscot)
- Added [SCOT](https://rsinghlab.github.io/SCOT/)
- Added [Genes2Genes](https://teichlab.github.io/Genes2Genes/)

### 2023.12.11: version 1.8.0
- Added [miloR](https://github.com/MarioniLab/miloR)
- Removed the conda environment of UniTVelo and included it in `shortcake_default`

### 2023.10.26: version 1.7.0
- Updated CellRank to version 2.0.0
- Added [rapids_singlecell](https://github.com/scverse/rapids_singlecell)
- Created ShortCake.ver2 (Dockerfile.Python.ver2) to separate several tools of ShortCake

### 2023.5.16: version 1.6.0
- Added [UniTVelo](https://github.com/StatBiomed/UniTVelo)
- Added [scranPY](https://github.com/sfortma2/scranPY/)

### 2023.5.23: version 1.5.1
- Added [InstaPrism](https://github.com/humengying0907/InstaPrism)
- Added the `shortcake_default` jupyter kernel to avoid the version conflict. The tools that do not have their own kernel are included in it.
- Merge several jupyter kernels

### 2023.5.16: version 1.5.0
- Added [STELLAR](http://snap.stanford.edu/stellar/)
- Added [GEARS](https://github.com/snap-stanford/GEARS)
- Added [SATURN](https://github.com/snap-stanford/SATURN)
- Added [tricycle](https://github.com/hansenlab/tricycle)
- Added [SEACells](https://github.com/dpeerlab/SEACells)
- Added [Moscot](https://moscot.readthedocs.io/en/latest/)
- Added [Scriabin](https://github.com/BlishLab/scriabin)
- Added [scDesign3](https://github.com/SONGDONGYUAN1994/scDesign3)
- Added [scReadSim](https://github.com/JSB-UCLA/scReadSim)
- Added [CellTypist](https://github.com/Teichlab/celltypist)
- Added [LIANA](https://github.com/saezlab/liana) and [LIANA-py](https://github.com/saezlab/liana-py)
- Added [RENGE](https://github.com/masastat/RENGE)
- Added [MultiVelo](https://github.com/welch-lab/MultiVelo)

### 2023.5.11: version 1.4.2
- Remove /root/.cpanm/work directory

### 2023.5.7: version 1.4.1
- Bug fix: issue #8

### 2023.4.26: version 1.4.0
- Update Seurat to v5
- Added [EEISP](https://github.com/nakatolab/EEISP)
- Added ``run_env.sh`` to activate virtual environments in Python
- Several bug fixes for installation
- Separate Seurat-related tools from Dockerfile.R (now Dockerfile.Seurat)
- Added ``wget.sh`` to download SeuratData for Docker building

### 2023.2.10: version 1.3.1
- Modify bedtools files from the static binary file to ones compiled from the source
- Move Changelog to `ChangeLog.md`

### 2023.2.8: version 1.3.0

- Added [bedtools](https://bedtools.readthedocs.io/en/latest/) version 2.30.0
- move scripts (jupyternotebook.sh etc) to /opt/scripts folder

### 2023.2.2: version 1.2.0

- Added [ikarus](https://github.com/BIMSBbioinfo/ikarus)
- Added [scTriangulate](https://github.com/frankligy/scTriangulate)
- Added [DropletQC](https://github.com/powellgenomicslab/DropletQC)
- Added [Dictys](https://github.com/pinellolab/dictys)
- Added [AutoGeneS](https://github.com/theislab/AutoGeneS)
- Added [BayesPrism](https://github.com/Danko-Lab/BayesPrism)
- Added [SignatuR](https://github.com/carmonalab/SignatuR)
- Added [scMoMaT](https://github.com/PeterZZQ/scMoMaT)
- Added [MARIO](https://github.com/shuxiaoc/mario-py)

### 2023.1.7: version 1.1.1

- Downgrade jinja2 to v3.0.3 to avoid the error in html conversion in Jupyter notebook (see [issue #6](https://github.com/rnakato/ShortCake/issues/6)).

### 2022.12.24: version 1.1.0

- Added CellOracle, RECODE and JASPAR2022
- Bug fix to remove a warning "/opt/conda/lib/libtinfo.so.6: no version information available"

### 2022.11.16

- Rename to **ShortCake** (version 1.0.0)

### 2022.08.2 (2022-08)

- Create separate environments for python tools to avoid version conflict. They can be executed from Jupyter notebook

### 2022.03 (2022-03-03)

- Separate Dockerfile to Dockerfile.R and Dockerfile.Python
- change base image from `pytorch-1.5-cuda10.1-cudnn7-devel` to `nvidia/cuda:11.5.1-cudnn8-devel-ubuntu20.04` to upgrade Python to 3.9
- Added CellChat, dyngen, Dynamo

### 2021.03 (2021-05-01):

- Added datasets in SeuratData
- Added Pagoda2

### 2021.02 (2021-02-07):

- Added programs
- Use pip venv for several tools to avoid package conflicts (e.g., tensorflow)

### 2020.12 (2020-12-24):

- Added `docker-compose.yml` to allow GitHub Token
- Omit the password to login Jupyter notebook
- Added programs
- Fix several bugs in the installation

### v1.3.0 (2020-07-14):
- add programs

### v1.2.0:
- change base image from `Ubuntu18.04` to `pytorch-1.5-cuda10.1-cudnn7-devel` to allow GPU computing

### v1.1.0:
- change base image `jupyter/datascience-notebook` to `Ubuntu18.04`
