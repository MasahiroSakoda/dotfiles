#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
  skip_if_no_command fish
}

@test ".config/fish/config.fish is valid" {
  [ -f "${HOME_SRC}/dot_config/fish/config.fish.tmpl" ]
  run chezmoi execute-template < "${HOME_SRC}/dot_config/fish/config.fish.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/fish/**/*.fish is exists" {

  for f in "${HOME_SRC}"/dot_config/fish/**/*.fish; do
    [ -f "$f" ]
  done
}

@test "fish config templates renders properly" {
  for f in "${HOME_SRC}"/dot_config/fish/*.fish.tmpl; do
    run chezmoi execute-template < "$f"
    [ "$status" -eq 0 ]
  done
}

@test ".config/fish/conf.d/*.fish.tmpl renders properly" {
  for f in "${HOME_SRC}"/dot_config/fish/conf.d/*.fish.tmpl; do
    [ -f "$f" ]
    run chezmoi execute-template < "$f"
    [ "$status" -eq 0 ]
  done
}

# -*-mode:sh-*- vim:ft=sh
