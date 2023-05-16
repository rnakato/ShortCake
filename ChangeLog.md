# Changelog

- 2023.5.16: version 1.5.0
    - Add [STELLAR](http://snap.stanford.edu/stellar/)
    - Add [GEARS](https://github.com/snap-stanford/GEARS)
    - Add [SATURN](https://github.com/snap-stanford/SATURN)
    - Add [tricycle](https://github.com/hansenlab/tricycle)
    - Add [SEACells](https://github.com/dpeerlab/SEACells)
    - Add [Moscot](https://moscot.readthedocs.io/en/latest/)
    - Add [Scriabin](https://github.com/BlishLab/scriabin)
    - Add [scDesign3](https://github.com/SONGDONGYUAN1994/scDesign3)
    - Add [scReadSim](https://github.com/JSB-UCLA/scReadSim)
    - Add [CellTypist](https://github.com/Teichlab/celltypist)
    - Add [LIANA](https://github.com/saezlab/liana) and [LIANA-py](https://github.com/saezlab/liana-py)
    - Add [RENGE](https://github.com/masastat/RENGE)

- 2023.5.11: version 1.4.2
    - Remove /root/.cpanm/work directory

- 2023.5.7: version 1.4.1
    - Bug fix: issue #8

- 2023.4.26: version 1.4.0
    - Update Seurat to v5
    - Add [EEISP](https://github.com/nakatolab/EEISP)
    - Add ``run_env.sh`` to activate virtual environments in Python
    - Several bug fixes for installation
    - Separate Seurat-related tools from Dockerfile.R (now Dockerfile.Seurat)
    - Add ``wget.sh`` to download SeuratData for Docker building

- 2023.2.10: version 1.3.1
    - Modify bedtools files from the static binary file to ones compiled from the source
    - Move Changelog to `ChangeLog.md`

- 2023.2.8: version 1.3.0

    - Add [bedtools](https://bedtools.readthedocs.io/en/latest/) version 2.30.0
    - move scripts (jupyternotebook.sh etc) to /opt/scripts folder

- 2023.2.2: version 1.2.0

    - Add [ikarus](https://github.com/BIMSBbioinfo/ikarus)
    - Add [scTriangulate](https://github.com/frankligy/scTriangulate)
    - Add [DropletQC](https://github.com/powellgenomicslab/DropletQC)
    - Add [Dictys](https://github.com/pinellolab/dictys)
    - Add [AutoGeneS](https://github.com/theislab/AutoGeneS)
    - Add [BayesPrism](https://github.com/Danko-Lab/BayesPrism)
    - Add [SignatuR](https://github.com/carmonalab/SignatuR)
    - Add [scMoMaT](https://github.com/PeterZZQ/scMoMaT)
    - Add [MARIO](https://github.com/shuxiaoc/mario-py)
<!--
 https://github.com/BIMSBbioinfo/ikarus---auxiliary
 https://github.com/powellgenomicslab/dropletQC_paper
-->
- 2023.1.7: version 1.1.1

    - Downgrade jinja2 to v3.0.3 to avoid the error in html conversion in Jupyter notebook (see [issue #6](https://github.com/rnakato/ShortCake/issues/6)).

- 2022.12.24: version 1.1.0

    - Add CellOracle, RECODE and JASPAR2022
    - Bug fix to remove a warning "/opt/conda/lib/libtinfo.so.6: no version information available"

- 2022.11.16

    - Rename to **ShortCake** (version 1.0.0)

- 2022.08.2 (2022-08)

    - Create separate environments for python tools to avoid version conflict. They can be executed from Jupyter notebook

- 2022.03 (2022-03-03)

    - Separate Dockerfile to Dockerfile.R and Dockerfile.Python
    - change base image from `pytorch-1.5-cuda10.1-cudnn7-devel` to `nvidia/cuda:11.5.1-cudnn8-devel-ubuntu20.04` to upgrade Python to 3.9
    - Add CellChat, dyngen, Dynamo

- 2021.03 (2021-05-01):

    - Add datasets in SeuratData
    - Add Pagoda2

- 2021.02 (2021-02-07):

    - Add programs
    - Use pip venv for several tools to avoid package conflicts (e.g., tensorflow)

- 2020.12 (2020-12-24):

    - Add `docker-compose.yml` to allow GitHub Token
    - Omit the password to login Jupyter notebook
    - Add programs
    - Fix several bugs in the installation

- v1.3.0 (2020-07-14): add programs
- v1.2.0: change base image from `Ubuntu18.04` to `pytorch-1.5-cuda10.1-cudnn7-devel` to allow GPU computing
- v1.1.0: change base image `jupyter/datascience-notebook` to `Ubuntu18.04`
