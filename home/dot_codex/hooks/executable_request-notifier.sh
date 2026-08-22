#!/usr/bin/env bash

set -euo pipefail

# Read JSON from stdin
input=$(cat)
if [ -z "$input" ]; then
  exit 0
fi

# Parse JSON fields
project=$(cat | jq -r '.cwd | split("/") | last')
msg="Perission Required"
sound="Submarine"

case "$(uname)" in
"darwin")
  osascript -e "display notification \"$project: $msg\" with title \"Codex\" sound name \"$sound\" "
  ;;
"linux")
  notify-send "Codex - ${project}: ${msg}"
  ;;
esac
