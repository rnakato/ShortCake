#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-${TAG:-latest}}"
LOG_DIR="${LOG_DIR:-./tutorial_test_logs}"
TTY_FLAG=""

if [[ "${SHORTCAKE_TTY:-0}" == "1" ]]; then
  TTY_FLAG="-it"
fi

mkdir -p "$LOG_DIR"

failures=0

run_test() {
  local name="$1"
  local image="$2"
  local env_name="$3"
  local script_path="$4"
  shift 4

  local logfile="$LOG_DIR/${name}.log"
  echo "[INFO] Running ${name}" | tee "$logfile"
  set +e
  docker run ${TTY_FLAG} --rm \
    -v "$(pwd)/tests:/opt/shortcake-tests:ro" \
    "${image}:${TAG}" \
    run_env.sh "${env_name}" python "/opt/shortcake-tests/${script_path}" \
    2>&1 | tee -a "$logfile"
  local status=${PIPESTATUS[0]}
  set -e

  if [[ $status -ne 0 ]]; then
    echo "[FAIL] ${name}" | tee -a "$logfile"
    failures=$((failures + 1))
  else
    echo "[PASS] ${name}" | tee -a "$logfile"
  fi
}

run_test "scvelo_pancreas_smoke"          "rnakato/shortcake_light" "scanpy"   "scvelo_pancreas_smoke.py"
run_test "scvelo_tutorial_smoke"          "rnakato/shortcake_light" "scanpy"   "scVelotest.py"
run_test "cellrank_velocity_kernel_smoke" "rnakato/shortcake_light" "cellrank" "cellrank_velocity_kernel_smoke.py"
run_test "squidpy_spatial_smoke"          "rnakato/shortcake_light" "squidpy"  "squidpy_synthetic_smoke.py"

if [[ $failures -gt 0 ]]; then
  echo "[ERROR] ${failures} tutorial smoke test(s) failed. Logs are in ${LOG_DIR}." >&2
  exit 1
fi

echo "[INFO] All tutorial smoke tests passed. Logs are in ${LOG_DIR}."
