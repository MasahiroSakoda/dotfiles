#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"
load "../../helpers/validate_json.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".config/opencode/AGENTS.md is valid" {
  [ -f "${HOME_SRC}/dot_config/opencode/AGENTS.md.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_config/opencode/AGENTS.md.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/opencode/opencode.json is valid" {
  [ -f "${HOME_SRC}/dot_config/opencode/opencode.json.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_config/opencode/opencode.json.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/opencode/cli.jsonc is valid" {
  [ -f "${HOME_SRC}/dot_config/opencode/cli.jsonc.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_config/opencode/cli.jsonc.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/opencode/dcp.jsonc is valid" {
  assert_valid_jsonc "${HOME_SRC}/dot_config/opencode/dcp.jsonc"
}

# -*-mode:sh-*- vim:ft=sh
