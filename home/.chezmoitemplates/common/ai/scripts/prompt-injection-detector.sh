#!/usr/bin/env bash

# prompt-injection-detector.sh
# Detects Unicode characters commonly used for prompt injection or text manipulation.
# Compatible with macOS default Bash 3.2+ and fully immune to locale differences.

set -euo pipefail

# Low-case hexadecimal representations of UTF-8 byte sequences:

# 1. Tag Characters: U+E0001 to U+E007F -> \xf3\xa0\x80\x81 to \xf3\xa0\x81\xbf
TAG_PATTERN="f3a0808[1-9a-f]|f3a080[9ab][0-9a-f]|f3a081[89ab][0-9a-f]"

# 2. Bidi Override: U+202A to U+202F, U+2066 to U+2069
BIDI_PATTERN="e280a[a-f]|e281a[6-9]"

# 3. Variation Selectors: U+E0100 to U+E01EF -> \xf3\xa0\x84\x80 to \xf3\xa0\x87\xaf
VAR_PATTERN="f3a08[4-6][89ab][0-9a-f]|f3a087[89a][0-9a-f]"

# 4. Zero-Width Characters: U+200B to U+200D -> \xe2\x80\x8b to \xe2\x80\x8d
ZW_PATTERN="e2808[b-d]"

# Combined POSIX Extended Regular Expression pattern
COMBINED_PATTERN="${TAG_PATTERN}|${BIDI_PATTERN}|${VAR_PATTERN}|${ZW_PATTERN}"

show_help() {
  echo "Usage: $0 [file_path]"
  echo "       $0 - (to read from stdin)"
  echo "       If no argument is given, it reads from stdin."
  echo ""
  echo "Checks input for prompt injection characters:"
  echo "  - Tag Characters (U+E0001–U+E007F)"
  echo "  - Bidi Overrides (U+202A–F, U+2066–9)"
  echo "  - Variation Selectors (U+E0100–E01EF)"
  echo "  - Zero-Width Characters (U+200B–D)"
  echo ""
  echo "Exit codes:"
  echo "  0 = Clean input (no injection characters found)"
  echo "  1 = Injection characters detected"
  echo "  2 = Error (e.g., file not found)"
}

input_file=""
if [[ $# -eq 1 ]]; then
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
  elif [[ "$1" == "-" ]]; then
    input_file="-"
  else
    input_file="$1"
    if [[ ! -f "$input_file" ]]; then
      echo "Error: File '$input_file' not found." >&2
      exit 2
    fi
  fi
elif [[ $# -gt 1 ]]; then
  echo "Error: Too many arguments." >&2
  show_help >&2
  exit 2
else
  input_file="-"
fi

# Define 1MB limit in bytes (1024 * 1024)
MAX_BYTES=1048576
MAX_BYTES_PLUS_ONE=1048577

# Enforce size limit and prepare input source
if [[ "$input_file" == "-" ]]; then
  temp_file=$(mktemp)
  # Limit stdin read to prevent DoS/memory exhaustion
  head -c "$MAX_BYTES_PLUS_ONE" >"$temp_file"

  actual_size=$(wc -c <"$temp_file" | tr -d ' ')
  if [[ "$actual_size" -gt "$MAX_BYTES" ]]; then
    echo "Error: Input size exceeds 1MB limit." >&2
    exit 2
  fi
  source_path="$temp_file"
else
  actual_size=$(wc -c <"$input_file" | tr -d ' ')
  if [[ "$actual_size" -gt "$MAX_BYTES" ]]; then
    echo "Error: Input file size ($actual_size bytes) exceeds 1MB limit." >&2
    exit 2
  fi
  source_path="$input_file"
fi

# Convert stream to a single lowercase hex string.
# od -An -v -tx1 is standard across macOS/BSD and Linux.
hex_input=$(od -An -v -tx1 "$source_path" | tr -d ' \n\t\r' | tr 'A-F' 'a-f')

# Exit early if the input is empty.
if [[ -z "$hex_input" ]]; then
  exit 0
fi

# Verify if the combined pattern matches the hex stream.
if ! echo "$hex_input" | grep -E -q -i "$COMBINED_PATTERN"; then
  exit 0
fi

# Report specific detections to standard error.
echo "WARNING: Potential prompt injection / hidden characters detected!" >&2
detected=0

if echo "$hex_input" | grep -E -q -i "$TAG_PATTERN"; then
  echo "  - Tag Characters (U+E0001–E007F) detected." >&2
  detected=1
fi

if echo "$hex_input" | grep -E -q -i "$BIDI_PATTERN"; then
  echo "  - Bidi Override Characters (U+202A–F, U+2066–9) detected." >&2
  detected=1
fi

if echo "$hex_input" | grep -E -q -i "$VAR_PATTERN"; then
  echo "  - Variation Selectors (U+E0100–E01EF) detected." >&2
  detected=1
fi

if echo "$hex_input" | grep -E -q -i "$ZW_PATTERN"; then
  echo "  - Zero-Width Characters (U+200B–D) detected." >&2
  detected=1
fi

exit "$detected"
