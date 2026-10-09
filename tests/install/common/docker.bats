#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".docker directory is private" {
  run assert_chezmoi_attr "${HOME}/.docker" dir private perm:0700
  [ "$status" -eq 0 ]
}

@test ".docker/*.json is private" {
  for f in "${HOME}"/.docker/*.json; do
    run assert_chezmoi_attr "$f" file private perm:0600
    [ "$status" -eq 0 ]
  done
}

# -*-mode:sh-*- vim:ft=sh
