#!/usr/bin/env bash

# Bats helper: assert that a file is valid YAML, optionally against a JSON Schema.
#
#   assert_valid_yaml "$HOME_SRC/dot_config/gh/config.yml.tmpl"
#   assert_valid_yaml .github/workflows/ci.yml github-workflow.json
#
# The file must already be rendered: chezmoi templates are not valid YAML.
# Pass a schema path or http(s) URI as the second argument to also run
# JSON Schema validation via check-jsonschema, which reads YAML instances
# directly.

assert_valid_yaml() {
  local file="${1:-}"
  local schema="${2:-}"
  local status output

  if [ -z "$file" ]; then
    echo "assert_valid_yaml: file path is required" >&2
    return 2
  fi

  if [ ! -f "$file" ]; then
    echo "assert_valid_yaml: no such file: $file" >&2
    return 1
  fi

  skip_if_no_command yq

  # `yq eval` parses every document in the stream and re-emits it, so a
  # multi-document file with a broken document still fails.
  run yq eval '.' "$file" >/dev/null
  if [ "$status" -ne 0 ]; then
    echo "assert_valid_yaml: $file is not valid YAML: $output" >&2
    return 1
  fi

  [ -n "$schema" ] || return 0

  skip_if_no_command uvx

  run uvx check-jsonschema --schemafile "$schema" "$file"
  if [ "$status" -ne 0 ]; then
    echo "assert_valid_yaml: $file does not match schema $schema: $output" >&2
    return 1
  fi
}

# -*-mode:sh-*- vim:ft=sh
