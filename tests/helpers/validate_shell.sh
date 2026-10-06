#!/usr/bin/env bash

# Bats helper: assert that a shell script parses, and lint it when the
# language is one shellcheck understands.
#
#   assert_valid_shell "$BATS_TMPDIR/statusline"
#   assert_valid_shell config.fish fish
#
# The second argument pins the interpreter; otherwise it is taken from the
# shebang, defaulting to bash. The file must already be rendered: chezmoi
# templates are not valid shell.

assert_valid_shell() {
  local file="${1:-}"
  local shell="${2:-}"
  local status output

  if [ -z "$file" ]; then
    echo "assert_valid_shell: file path is required" >&2
    return 2
  fi

  if [ ! -f "$file" ]; then
    echo "assert_valid_shell: no such file: $file" >&2
    return 1
  fi

  if [ -z "$shell" ]; then
    IFS= read -r shell <"$file" || true
    shell="${shell#\#!}"
    shell="${shell##*/env }"
    shell="${shell##*/}"
    shell="${shell%% *}"
    shell="${shell:-bash}"
  fi

  if [ "$shell" = "fish" ]; then
    skip_if_no_command fish
    # fish has no -n; --no-execute parses without running.
    run fish --no-execute "$file"
  else
    skip_if_no_command "$shell"
    run "$shell" -n "$file"
  fi

  if [ "$status" -ne 0 ]; then
    echo "assert_valid_shell: $file is not valid $shell: $output" >&2
    return 1
  fi

  case "$shell" in
  sh | bash | dash | ksh) ;;
  *) return 0 ;;
  esac

  skip_if_no_command shellcheck

  # Same exclusions as .github/workflows/linter.yml so the helper and the
  # lint gate agree on what a valid script is.
  run shellcheck -e 1009 -e SC1054 -e SC1056 -e SC1072 -e SC1073 -e 1083 "$file"
  if [ "$status" -ne 0 ]; then
    echo "assert_valid_shell: $file has shellcheck findings: $output" >&2
    return 1
  fi
}

# -*-mode:sh-*- vim:ft=sh
