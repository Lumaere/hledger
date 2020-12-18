#!/usr/bin/env bash
# Parse hledger's help and output long options. Do not propose single letter
# completions. Options requiring an argument make that explicit by appending the
# equal sign (=)
set -euo pipefail

declare subcommand=${1:-}
declare hledgerArgs=(--help)
[[ -n $subcommand ]] && hledgerArgs=("$subcommand" "${hledgerArgs[@]}")

hledger "${hledgerArgs[@]}" |
  sed -rn '/^\s+-/p' |
  sed -rn 's/^\s{1,4}(-.)?\s{1,4}(--[a-zA-Z][-_a-zA-Z0-9]+=?).*/\2/p' |
  sort -u
