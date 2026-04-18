#!/usr/bin/env python3
"""Smoke test for the official scVelo pancreas tutorial core steps.

This is intended to catch runtime incompatibilities that are invisible to
simple import checks or `pip check`.
"""
from __future__ import annotations

import json
import os
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
    import scanpy as sc
except Exception as exc:  # pragma: no cover
    fail(f"Import failed before test start: {exc!r}")


def main() -> None:
    log("[INFO] scVelo version: {}".format(getattr(scv, "__version__", "unknown")))
    log("[INFO] Loading pancreas tutorial dataset")
    adata = scv.datasets.pancreas()
    log(f"[INFO] Loaded adata: n_obs={adata.n_obs}, n_vars={adata.n_vars}")

    scv.pl.proportions(adata)

    # Keep the test faithful to the tutorial while still remaining cheap enough
    # for repeated build-time execution.
    log("[INFO] Running scv.pp.filter_genes")
    # gene filtering
    scv.pp.filter_genes(adata, min_shared_counts=20)

    # normalization
    log("[INFO] Running scv.pp.normalize_per_cell")
    scv.pp.normalize_per_cell(adata)
    log("[INFO] Running sc.pp.log1p")
    sc.pp.log1p(adata)

    log("[INFO] Running sc.pp.highly_variable_genes")
    sc.pp.highly_variable_genes(
        adata,
        n_top_genes=2000,
        flavor="seurat"
    )
    adata = adata[:, adata.var["highly_variable"]].copy()

    log("[INFO] Running scv.pp.moments")
    scv.pp.moments(adata, n_pcs=30, n_neighbors=30)

    log("[INFO] Running scv.tl.velocity")
    scv.tl.velocity(adata)

    log("[INFO] Running scv.tl.velocity_graph")
    scv.tl.velocity_graph(adata)

    # Minimal structural assertions.
    required_layers = ["velocity"]
    missing_layers = [k for k in required_layers if k not in adata.layers]
    if missing_layers:
        fail(f"Missing expected layers after velocity run: {missing_layers}")

    required_uns = ["velocity_graph"]
    missing_uns = [k for k in required_uns if k not in adata.uns]
    if missing_uns:
        fail(f"Missing expected uns keys after velocity_graph run: {missing_uns}")

    vel = adata.layers["velocity"]
    vel_arr = vel.A if hasattr(vel, "A") else np.asarray(vel)
    if vel_arr.size == 0:
        fail("Velocity layer is empty")
    if not np.isfinite(vel_arr).all():
        fail("Velocity layer contains NaN or inf values")

    summary: dict[str, Any] = {
        "n_obs": int(adata.n_obs),
        "n_vars": int(adata.n_vars),
        "velocity_shape": tuple(int(x) for x in vel_arr.shape),
        "velocity_nonzero": int(np.count_nonzero(vel_arr)),
    }
    log("[PASS] scVelo pancreas smoke test completed")
    log(json.dumps(summary, indent=2))


if __name__ == "__main__":
    try:
        main()
    except Exception:
        traceback.print_exc()
        fail("scVelo pancreas smoke test crashed")
