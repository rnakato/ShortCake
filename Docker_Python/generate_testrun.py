#!/usr/bin/env python
"""
Generate testrun.sh from a single in-script manifest.

Usage:
    python generate_testrun.py > testrun.sh
    python generate_testrun.py --output testrun.sh
"""
from __future__ import annotations

import argparse
import shlex
from pathlib import Path

TAG_DEFAULT = "3.5.0"

MANIFEST = {
    "groups": [
        {
            "label": "light / shortcake_default",
            "image": "rnakato/shortcake_light",
            "env": "shortcake_default",
            "modules": [
                "autogenes","bbknn","cellmap","celltypist","cellrank","constclust",
                "cython","dask","doubletdetection","harmonypy","llvmlite","louvain",
                "leidenalg","magic","memento","multivelo","numba","optuna","palantir",
                "phenograph","phate","scanorama","scib","scanpy","screcode","scrublet",
                "scvelo","snapatac2","velocyto",
            ],
            "print_version": True,
            "gpu": False,
        },
        {
            "label": "light / scenic",
            "image": "rnakato/shortcake_light",
            "env": "scenic",
            "modules": ["scanpy", "loompy", "pyscenic"],
            "print_version": True,
            "gpu": False,
        },
        {
            "label": "light / squidpy",
            "image": "rnakato/shortcake_light",
            "env": "squidpy",
            "modules": ["squidpy"],
            "print_version": True,
            "gpu": False,
        },
        {
            "label": "default / per-tool envs",
            "checks": [
                {"image":"rnakato/shortcake","env":"celloracle","module":"celloracle","print_version":True},
                {"image":"rnakato/shortcake","env":"cellphonedb","module":"cellphonedb","print_version":True},
                {"image":"rnakato/shortcake","env":"episcanpy","module":"episcanpy","print_version":True},
                {"image":"rnakato/shortcake","env":"mario","module":"mario","print_version":True},
                {"image":"rnakato/shortcake","env":"genes2genes-mowgli","module":"genes2genes","print_version":True},
                {"image":"rnakato/shortcake","env":"genes2genes-mowgli","module":"mowgli","print_version":True},
                {"image":"rnakato/shortcake","env":"dynamo","module":"dynamo","print_version":True},
                {"image":"rnakato/shortcake","env":"moscot","module":"moscot","print_version":True},
                {"image":"rnakato/shortcake","env":"cell2cell-screadsim","module":"cell2cell","print_version":True},
                {"image":"rnakato/shortcake","env":"cell2cell-screadsim","module":"scReadSim","print_version":True},
                {"image":"rnakato/shortcake","env":"decoupler-liana-sctriangulate","module":"decoupler","print_version":True},
                {"image":"rnakato/shortcake","env":"decoupler-liana-sctriangulate","module":"liana","print_version":True},
                {"image":"rnakato/shortcake","env":"decoupler-liana-sctriangulate","module":"sctriangulate","print_version":True},
                {"image":"rnakato/shortcake","env":"ikarus-novosparc","module":"ikarus","print_version":True},
                {"image":"rnakato/shortcake","env":"ikarus-novosparc","module":"novosparc","print_version":True},
                {"image":"rnakato/shortcake","env":"seacells","module":"SEACells","print_version":False},
            ],
        },
        {
            "label": "full / GPU envs",
            "checks": [
                {"image":"rnakato/shortcake_full","env":"dictys","module":"dictys","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_full","env":"gears","module":"gears","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_full","env":"rapids_singlecell","module":"rapids_singlecell","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_full","env":"scvi-scgen-scmomat-unitvelo","module":"scvi","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_full","env":"scvi-scgen-scmomat-unitvelo","module":"scgen","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_full","env":"scvi-scgen-scmomat-unitvelo","module":"scmomat","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_full","env":"scvi-scgen-scmomat-unitvelo","module":"unitvelo","print_version":True,"gpu":True},
            ],
        },
        {
            "label": "scvi flavor / GPU envs",
            "checks": [
                {"image":"rnakato/shortcake_scvi","env":"scvi-scgen-scmomat-unitvelo","module":"scvi","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_scvi","env":"scvi-scgen-scmomat-unitvelo","module":"scgen","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_scvi","env":"scvi-scgen-scmomat-unitvelo","module":"scmomat","print_version":True,"gpu":True},
                {"image":"rnakato/shortcake_scvi","env":"scvi-scgen-scmomat-unitvelo","module":"unitvelo","print_version":True,"gpu":True},
            ],
        },
        {
            "label": "rapidsc flavor / GPU envs",
            "checks": [
                {"image":"rnakato/shortcake_rapidsc","env":"rapids_singlecell","module":"rapids_singlecell","print_version":True,"gpu":True},
            ],
        },
    ],
    "commands": [
        {"label":"light / scenic cli / pyscenic", "image":"rnakato/shortcake_light", "env":"scenic", "command":"pyscenic", "gpu":False},
        {"label":"light / scenic cli / scenicplus", "image":"rnakato/shortcake_light", "env":"scenic", "command":"scenicplus", "gpu":False},
        {"label":"default / cli / eeisp --version", "image":"rnakato/shortcake", "env":"", "command":"eeisp --version", "gpu":False},
        {"label":"full / stellar smoke", "image":"rnakato/shortcake_full", "env":"stellar", "command":"python /opt/stellar/STELLAR_run.py", "gpu":False},
    ],
}

HEADER = f'''#!/usr/bin/env bash
# AUTO-GENERATED by generate_testrun.py
# Do not edit this file directly.
set -u

TAG="${{1:-${{TAG:-{TAG_DEFAULT}}}}}"
SHORTCAKE_TTY="${{SHORTCAKE_TTY:-0}}"
DOCKER_EXTRA_ARGS="${{DOCKER_EXTRA_ARGS:-}}"

TOTAL=0
FAILURES=0
FAILED_LABELS=()

if [[ "$SHORTCAKE_TTY" == "1" ]]; then
    DOCKER_TTY_ARGS=(-it)
else
    DOCKER_TTY_ARGS=()
fi

run_check() {{
    local label="$1"
    local image="$2"
    local envname="$3"
    local gpu="$4"
    local inner_cmd="$5"

    TOTAL=$((TOTAL + 1))
    echo
    echo "================================================================"
    echo "[${{TOTAL}}] $label"
    echo "================================================================"

    local -a cmd=(docker run "${{DOCKER_TTY_ARGS[@]}}" --rm)
    if [[ -n "$DOCKER_EXTRA_ARGS" ]]; then
        # shellcheck disable=SC2206
        cmd+=($DOCKER_EXTRA_ARGS)
    fi
    if [[ "$gpu" == "1" ]]; then
        cmd+=(--gpus all)
    fi
    cmd+=("${{image}}:${{TAG}}")

    if [[ -n "$envname" ]]; then
        cmd+=(run_env.sh "$envname" bash -lc "$inner_cmd")
    else
        cmd+=(bash -lc "$inner_cmd")
    fi

    printf '+ '
    printf '%q ' "${{cmd[@]}}"
    echo

    if "${{cmd[@]}}"; then
        echo "OK: $label"
    else
        local status=$?
        echo "FAILED($status): $label" >&2
        FAILURES=$((FAILURES + 1))
        FAILED_LABELS+=("$label")
    fi
}}

run_import() {{
    local label="$1"
    local image="$2"
    local envname="$3"
    local module="$4"
    local print_version="$5"
    local gpu="$6"

    local pycmd
    if [[ "$print_version" == "1" ]]; then
        pycmd="import importlib; m=importlib.import_module('${{module}}'); print(getattr(m, '__version__', 'NO_VERSION_ATTR'))"
    else
        pycmd="import importlib; importlib.import_module('${{module}}'); print('IMPORTED')"
    fi

    local inner_cmd
    inner_cmd="python -c $(printf '%q' "$pycmd")"
    run_check "$label" "$image" "$envname" "$gpu" "$inner_cmd"
}}

run_cli() {{
    local label="$1"
    local image="$2"
    local envname="$3"
    local gpu="$4"
    local cli_cmd="$5"
    run_check "$label" "$image" "$envname" "$gpu" "$cli_cmd"
}}
'''

FOOTER = '''
echo
echo "================================================================"
echo "Summary"
echo "================================================================"
echo "Total checks : $TOTAL"
echo "Failures     : $FAILURES"

if [[ "$FAILURES" -gt 0 ]]; then
    echo
    echo "Failed labels:"
    printf '  - %s\n' "${FAILED_LABELS[@]}"
    exit 1
fi

echo "All checks passed."
'''

def q(s: str) -> str:
    return shlex.quote(s)

def expand_group(group: dict) -> list[dict]:
    if "checks" in group:
        return group["checks"]
    return [
        {
            "image": group["image"],
            "env": group["env"],
            "module": module,
            "print_version": group.get("print_version", True),
            "gpu": group.get("gpu", False),
        }
        for module in group["modules"]
    ]

def generate() -> str:
    lines = [HEADER.rstrip()]
    for group in MANIFEST["groups"]:
        lines.append("")
        lines.append(f"# {group['label']}")
        for check in expand_group(group):
            label = f"{check['image'].split('/')[-1]} / {check['env']} / import {check['module']}"
            lines.append(
                "run_import "
                f"{q(label)} {q(check['image'])} {q(check['env'])} {q(check['module'])} "
                f"{'1' if check.get('print_version', True) else '0'} "
                f"{'1' if check.get('gpu', False) else '0'}"
            )
    lines.append("")
    lines.append("# CLI checks")
    for check in MANIFEST["commands"]:
        lines.append(
            "run_cli "
            f"{q(check['label'])} {q(check['image'])} {q(check.get('env', ''))} "
            f"{'1' if check.get('gpu', False) else '0'} {q(check['command'])}"
        )
    lines.append(FOOTER.strip())
    return "\n".join(lines) + "\n"

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("-o", "--output", type=Path, help="Write output to a file instead of stdout.")
    args = parser.parse_args()

    rendered = generate()
    if args.output:
        args.output.write_text(rendered, encoding="utf-8")
        args.output.chmod(0o755)
    else:
        print(rendered, end="")

if __name__ == "__main__":
    main()
