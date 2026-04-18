#!/usr/bin/env python
"""Minimal Squidpy smoke test without downloading external datasets.

This test creates a small synthetic spatial AnnData object and runs a few
core Squidpy graph-based routines to catch runtime incompatibilities that
simple import tests miss.
"""

from __future__ import annotations

import numpy as np
import pandas as pd
import anndata as ad
import squidpy as sq


def main() -> None:
    rng = np.random.default_rng(42)

    n_cells = 60
    n_genes = 25

    X = rng.poisson(lam=2.0, size=(n_cells, n_genes)).astype(np.float32)
    obs = pd.DataFrame(
        {
            "cluster": pd.Categorical(rng.choice(["A", "B", "C"], size=n_cells)),
        },
        index=[f"cell_{i}" for i in range(n_cells)],
    )
    var = pd.DataFrame(index=[f"gene_{j}" for j in range(n_genes)])

    adata = ad.AnnData(X=X, obs=obs, var=var)
    adata.obsm["spatial"] = rng.normal(size=(n_cells, 2)).astype(np.float32)

    sq.gr.spatial_neighbors(adata, coord_type="generic", delaunay=True)
    sq.gr.nhood_enrichment(adata, cluster_key="cluster")
    sq.gr.centrality_scores(adata, cluster_key="cluster")
    sq.gr.interaction_matrix(adata, cluster_key="cluster")

    assert "spatial_connectivities" in adata.obsp, "Missing spatial graph"
    assert "cluster_nhood_enrichment" in adata.uns, "Missing nhood enrichment result"
    assert "cluster_centrality_scores" in adata.uns, "Missing centrality scores result"
    assert "cluster_interactions" in adata.uns, "Missing interaction matrix result"

    print("squidpy synthetic spatial smoke test: OK")
    print(f"squidpy version: {sq.__version__}")
    print(f"adata shape: {adata.shape}")


if __name__ == "__main__":
    main()
