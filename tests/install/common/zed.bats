#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/validate_shell.sh"
load "../../helpers/validate_toml.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".config/zed/settings.json is valid" {
  [ -f "${HOME_SRC}/dot_config/zed/private_settings.json.tmpl" ]

  run chezmoi execute-template < "${HOME_SRC}/dot_config/zed/private_settings.json.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/zed/keymap.json is valid" {
  [ -f "${HOME_SRC}/dot_config/zed/private_keymap.json.tmpl" ]

  run chezmoi execute-template < "${HOME_SRC}/dot_config/zed/private_keymap.json.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/zed/tasks.json is valid" {
  [ -f "${HOME_SRC}/dot_config/zed/private_tasks.json.tmpl" ]

  run chezmoi execute-template < "${HOME_SRC}/dot_config/zed/private_tasks.json.tmpl"
  [ "$status" -eq 0 ]
}

# -*-mode:sh-*- vim:ft=sh
