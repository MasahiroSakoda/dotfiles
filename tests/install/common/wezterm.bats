#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".config/wezterm/*.lua exists" {
  for f in "${HOME_SRC}"/dot_config/wezterm/*.lua; do
    [ -f "$f" ]
  done
}

@test ".config/wezterm/*.lua.tmpl renders properly" {
  for f in "${HOME_SRC}"/dot_config/wezterm/*.lua.tmpl; do
    [ -f "$f" ]
    run chezmoi execute-template < "$f"
    [ "$status" -eq 0 ]
  done
}


# -*-mode:sh-*- vim:ft=sh
