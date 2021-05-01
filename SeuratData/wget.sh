for data in ifnb.SeuratData_3.1.0 \
                panc8.SeuratData_3.0.2 \
                pbmcsca.SeuratData_3.0.0 \
                pbmc3k.SeuratData_3.1.4 \
                celegans.embryo.SeuratData_0.1.0 \
                cbmc.SeuratData_3.1.4 \
                hcabm40k.SeuratData_3.0.0 \
                thp1.eccite.SeuratData_3.1.5 \
                stxBrain.SeuratData_0.1.1 \
                stxKidney.SeuratData_0.1.0 \
                bmcite.SeuratData_0.3.0 \
                pbmcMultiome.SeuratData_0.1.0 \
                ssHippo.SeuratData_3.1.4
do
    wget --timestamping http://seurat.nygenome.org/src/contrib/$data.tar.gz
done
