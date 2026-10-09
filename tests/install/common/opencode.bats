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

@test ".config/opencode/config.json is valid" {
  [ -f "${HOME_SRC}/dot_config/opencode/config.json.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_config/opencode/config.json.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/opencode/tui.json is valid" {
  [ -f "${HOME_SRC}/dot_config/opencode/tui.json.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_config/opencode/tui.json.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/opencode/dcp.jsonc is valid" {
  assert_valid_jsonc "${HOME_SRC}/dot_config/opencode/dcp.jsonc"
}

# -*-mode:sh-*- vim:ft=sh
