#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".config/starship/starship.toml is valid" {
  [ -f "${HOME_SRC}/dot_config/starship/starship.toml.tmpl" ]

  run chezmoi execute-template < "${HOME_SRC}/dot_config/starship/starship.toml.tmpl"
  [ "$status" -eq 0 ]
}

# -*-mode:sh-*- vim:ft=sh
