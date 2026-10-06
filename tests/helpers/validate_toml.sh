#!/usr/bin/env bash

# Bats helper: assert that a file is valid TOML, optionally against a JSON Schema.
#
#   assert_valid_toml "$HOME_SRC/dot_config/mise/config.toml.tmpl"
#   assert_valid_toml mise.toml mise.json
#
# The file must already be rendered: chezmoi templates are not valid TOML.
# Pass a schema path or http(s) URI as the second argument to also run
# JSON Schema validation via check-jsonschema. The filetype is forced because
# it is otherwise guessed from the extension, and chezmoi sources end in .tmpl.

assert_valid_toml() {
  local file="${1:-}"
  local schema="${2:-}"
  local status output

  if [ -z "$file" ]; then
    echo "assert_valid_toml: file path is required" >&2
    return 2
  fi

  if [ ! -f "$file" ]; then
    echo "assert_valid_toml: no such file: $file" >&2
    return 1
  fi

  skip_if_no_command tombi

  # `tombi lint` parses the document and reports every syntax error, so a
  # malformed value anywhere in the file fails.
  run tombi lint --quiet "$file"
  if [ "$status" -ne 0 ]; then
    echo "assert_valid_toml: $file is not valid TOML: $output" >&2
    return 1
  fi

  [ -n "$schema" ] || return 0

  skip_if_no_command uvx

  run uvx check-jsonschema --schemafile "$schema" --force-filetype toml "$file"
  if [ "$status" -ne 0 ]; then
    echo "assert_valid_toml: $file does not match schema $schema: $output" >&2
    return 1
  fi
}

# -*-mode:sh-*- vim:ft=sh
