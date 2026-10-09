#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".config/ghostty/config is valid" {
  [ -f "${HOME_SRC}/dot_config/ghostty/config.tmpl" ]

  run chezmoi execute-template < "${HOME_SRC}/dot_config/ghostty/config.tmpl"
  [ "$status" -eq 0 ]
}

@test "Library/Application Supports/com.mitchellh.ghostty/config is valid" {
  [ -f "${HOME_SRC}/Private_Library/Application Support/com.mitchellh.ghostty/config.tmpl" ]

  run chezmoi execute-template < "${HOME_SRC}/Private_Library/Application Support/com.mitchellh.ghostty/config.tmpl"
  [ "$status" -eq 0 ]
}

# -*-mode:sh-*- vim:ft=sh
