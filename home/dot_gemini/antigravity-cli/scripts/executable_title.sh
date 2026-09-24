#!/usr/bin/env bash
set -euo pipefail

# Read stdin into a variable
input=$(cat)

if [ -z "$(echo "$input" | tr -d '[:space:]')" ]; then
  echo "⚠️ Error: stdin is empty. This script requires a JSON payload piped to stdin." >&2
  exit 1
fi

# Verify valid JSON
if ! echo "$input" | jq empty >/dev/null 2>&1; then
  echo "⚠️ Error parsing JSON from stdin." >&2
  exit 1
fi

abbreviate_segment() {
  local seg="$1"
  if [ -z "$seg" ]; then
    echo ""
    return
  fi
  if [ "$seg" = "~" ]; then
    echo "~"
    return
  fi
  if [[ "$seg" == *.* ]]; then
    if [[ "$seg" == .* ]]; then
      echo "${seg:0:2}"
    else
      local first_char="${seg:0:1}"
      local after_dot="${seg#*.}"
      echo "${first_char}.${after_dot:0:1}"
    fi
  else
    echo "${seg:0:1}"
  fi
}

format_cwd() {
  local path="$1"
  if [ -z "$path" ] || [ "$path" = "null" ]; then
    echo "~"
    return
  fi

  local home="${HOME:-}"
  local formatted="$path"

  if [ -n "$home" ] && [[ "$formatted" == "$home"* ]]; then
    formatted="~${formatted#"$home"}"
  fi

  if [ "$formatted" != "/" ] && [[ "$formatted" == */ ]]; then
    formatted="${formatted%/}"
  fi

  IFS='/' read -ra parts <<<"$formatted"
  local last_idx=$((${#parts[@]} - 1))
  local result=()

  for i in "${!parts[@]}"; do
    if [ "$i" -eq "$last_idx" ]; then
      result+=("${parts[$i]}")
    else
      result+=("$(abbreviate_segment "${parts[$i]}")")
    fi
  done

  local IFS="/"
  echo "${result[*]}"
}

raw_cwd=$(echo "$input" | jq -r '.cwd // empty')
formatted_title=$(format_cwd "$raw_cwd")

printf "agy: %s \n" "$formatted_title"
