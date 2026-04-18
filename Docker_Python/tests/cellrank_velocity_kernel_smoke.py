#!/usr/bin/env python3
"""Smoke test for CellRank on top of the standard scVelo pancreas workflow.

This test is intentionally modest. It verifies that CellRank can consume the
output of the canonical scVelo preprocessing/velocity steps without crashing.
"""
from __future__ import annotations

import json
import sys
import traceback
from typing import Any


def log(msg: str) -> None:
    print(msg, flush=True)


def fail(msg: str, exit_code: int = 1) -> None:
    log(f"[FAIL] {msg}")
    sys.exit(exit_code)


try:
    import numpy as np
    import scvelo as scv
    import cellrank as cr
    import scanpy as sc
except Exception as exc:  # pragma: no cover
    fail(f"Import failed before test start: {exc!r}")


def main() -> None:
    log("[INFO] scVelo version: {}".format(getattr(scv, "__version__", "unknown")))
    log("[INFO] CellRank version: {}".format(getattr(cr, "__version__", "unknown")))

    log("[INFO] Loading pancreas tutorial dataset")
    adata = cr.datasets.bone_marrow()

    log("[INFO] Running scanpy preprocessing")
    sc.pp.filter_genes(adata, min_cells=5)
    sc.pp.normalize_total(adata, target_sum=1e4)

    sc.pp.log1p(adata)
    sc.pp.highly_variable_genes(adata, n_top_genes=3000)

    log("[INFO] Compute PCA and k-nearest neighbor (k-NN) graph")
    sc.tl.pca(adata, random_state=0)
    sc.pp.neighbors(adata, random_state=0)

    log("[INFO] Visualize this data")
    sc.pl.embedding(adata, basis="tsne", color=["clusters", "palantir_pseudotime"])

    log("[INFO] Building CellRank PseudotimeKernel")
    pk = cr.kernels.PseudotimeKernel(adata, time_key="palantir_pseudotime")

    tm = pk.compute_transition_matrix()
    if tm is None:
        fail("PseudotimeKernel transition matrix is None")

    pk.plot_random_walks(
        seed=0,
        n_sims=100,
        start_ixs={"clusters": "HSC_1"},
        basis="tsne",
        max_iter=100,
        legend_loc="on data",
        color="clusters",
    )

    log("[INFO] CellRank Meets RNA Velocity")
    adata = cr.datasets.pancreas()
    scv.pl.proportions(adata)

    log("[INFO] Preprocess with scVelo")
    # filter and normalize - scVelo uses pre-filtering gene counts per cell to determine
    # the library size for normalization
    scv.pp.filter_genes(adata, min_shared_counts=20)
    scv.pp.normalize_per_cell(adata)

    # log transformation and hvg
    sc.pp.log1p(adata)
    sc.pp.highly_variable_genes(adata, n_top_genes=2000)

    # pca, neighbors, and moments.
    sc.tl.pca(adata)
    sc.pp.neighbors(adata, n_pcs=30, n_neighbors=30, random_state=0)
    scv.pp.moments(adata, n_pcs=None, n_neighbors=None)

    log("[INFO] Run scVelo")
    scv.tl.recover_dynamics(adata, n_jobs=8)
    scv.tl.velocity(adata, mode="dynamical")

    log("[INFO] Combine scVelo")
    vk = cr.kernels.VelocityKernel(adata)
    vk.compute_transition_matrix()


if __name__ == "__main__":
    try:
        main()
    except Exception:
        traceback.print_exc()
        fail("CellRank velocity-kernel smoke test crashed")
