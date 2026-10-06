#!/usr/bin/env bash

# Bats helper: assert that a file is valid JSON, optionally against a JSON Schema.
#
#   assert_valid_json "$HOME_SRC/dot_config/opencode/config.json.tmpl"
#   assert_valid_json .github/labeler.yml schema.json
#
# The file must already be rendered: chezmoi templates are not valid JSON.
# Pass a schema path or http(s) URI as the second argument to also run
# JSON Schema validation via check-jsonschema.

assert_valid_json() {
  local file="${1:-}"
  local schema="${2:-}"
  local status output

  if [ -z "$file" ]; then
    echo "assert_valid_json: file path is required" >&2
    return 2
  fi

  if [ ! -f "$file" ]; then
    echo "assert_valid_json: no such file: $file" >&2
    return 1
  fi

  skip_if_no_command jq

  # `jq empty` parses without emitting output, so a literal `null` document
  # passes. `jq -e` would reject it as a falsy result.
  run jq empty "$file"
  if [ "$status" -ne 0 ]; then
    echo "assert_valid_json: $file is not valid JSON: $output" >&2
    return 1
  fi

  [ -n "$schema" ] || return 0

  skip_if_no_command uvx

  run uvx check-jsonschema --schemafile "$schema" "$file"
  if [ "$status" -ne 0 ]; then
    echo "assert_valid_json: $file does not match schema $schema: $output" >&2
    return 1
  fi
}

# -*-mode:sh-*- vim:ft=sh
