#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <env_name> [module1 module2 ...]" >&2
  exit 2
fi

ENV_NAME="$1"
shift || true

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

RAW_CHECK_LOG="$TMPDIR/pip_check.raw.txt"
FILTERED_CHECK_LOG="$TMPDIR/pip_check.filtered.txt"
INSPECT_JSON="${TMPDIR}/${ENV_NAME}.pip-inspect.json"

echo "[INFO] Verifying environment: ${ENV_NAME}"

run_in_env() {
  micromamba run -n "${ENV_NAME}" "$@"
}

filter_known_exceptions() {
  local env_name="$1"
  local infile="$2"
  local outfile="$3"

  cp "$infile" "$outfile"

  case "$env_name" in
    scanpy|cellrank)
      # Known issue:
      # fcsparser 0.2.8 metadata still requires numpy<2, while this env intentionally keeps numpy>=2.
      # Remove only this exact warning. Everything else still fails.
      grep -Ev '^fcsparser[[:space:]]+[^ ]+[[:space:]]+has requirement numpy<2,>=1, but you have numpy[[:space:]].*\.$' \
        "$outfile" > "${outfile}.tmp" || true
      mv "${outfile}.tmp" "$outfile"
      ;;
  esac
}

should_skip_pip_check() {
  case "$1" in
    scenicplus)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

if should_skip_pip_check "$ENV_NAME"; then
  echo "[WARN] Skipping strict pip check for ${ENV_NAME}"
else
  echo "[INFO] Running pip check"
  set +e
  run_in_env python -m pip check >"$RAW_CHECK_LOG" 2>&1
  PIP_CHECK_STATUS=$?
  set -e

  if [[ $PIP_CHECK_STATUS -ne 0 ]]; then
    filter_known_exceptions "$ENV_NAME" "$RAW_CHECK_LOG" "$FILTERED_CHECK_LOG"

    if [[ -s "$FILTERED_CHECK_LOG" ]]; then
      echo "[ERROR] Unignored pip check failures in env: ${ENV_NAME}" >&2
      cat "$FILTERED_CHECK_LOG" >&2
      exit 1
    else
      echo "[WARN] pip check reported only ignored known exceptions in env: ${ENV_NAME}" >&2
      cat "$RAW_CHECK_LOG" >&2
    fi
  else
    : > "$FILTERED_CHECK_LOG"
  fi
fi

echo "[INFO] Saving pip inspect output: ${INSPECT_JSON}"
run_in_env python -m pip inspect > "$INSPECT_JSON"

echo "[INFO] Checking python and ipykernel"
run_in_env python - <<'PY'
import sys
import ipykernel
print("python:", sys.version)
print("ipykernel:", ipykernel.__version__)
PY

if [[ $# -gt 0 ]]; then
  echo "[INFO] Import smoke test: $*"
  for mod in "$@"; do
    run_in_env python - <<PY
import importlib
m = importlib.import_module("${mod}")
print("${mod}", getattr(m, "__version__", "unknown"))
PY
  done
fi

echo "[INFO] Environment verification passed: ${ENV_NAME}"