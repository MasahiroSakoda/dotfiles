#!/usr/bin/env bash

set -euo pipefail

# Read JSON from stdin
input=$(cat)
if [ -z "$input" ]; then
  exit 0
fi

echo "$input" | jq -r '[now | todate] | @tsv' >>"${HOME}/.claude/bash-history.log"
