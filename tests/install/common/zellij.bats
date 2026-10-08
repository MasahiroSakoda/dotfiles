#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".config/zellij/config.kdl is valid" {
  [ -f "${HOME_SRC}/dot_config/zellij/config.kdl.tmpl" ]

  run chezmoi execute-template < "${HOME_SRC}/dot_config/zellij/config.kdl.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/zellij/layouts/*.kdl.tmpl renders properly" {
  for f in "${HOME_SRC}"/dot_config/zellij/layouts/*.kdl.tmpl; do
    [ -f "$f" ]
    run chezmoi execute-template < "$f"
  [ "$status" -eq 0 ]
  done
}

# -*-mode:sh-*- vim:ft=sh
