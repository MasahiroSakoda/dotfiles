#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
  skip_if_no_command nvim
}

@test ".config/nvim/**/*.lua is valid" {
  [ -f "${HOME_SRC}/dot_config/nvim/init.lua" ]
  # bats runs bash 3.2 on macOS, which has no globstar, so ** only expands
  # one level. find is used instead; CI does not install fd.
  while IFS= read -r -d '' f; do
    [ -f "$f" ]
  done < <(find "${HOME_SRC}/dot_config/nvim/lua" -type f -name '*.lua' -print0)
}

# -*-mode:sh-*- vim:ft=sh
