#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".gnupg directory is private" {
  run assert_chezmoi_attr "${HOME}/.gnupg" dir private perm:0700
  [ "$status" -eq 0 ]
}

@test ".gnupg/*.conf is private" {
  for f in "${HOME}"/.gnupg/*.conf; do
    run assert_chezmoi_attr "$f" file private perm:0600
    [ "$status" -eq 0 ]
  done
}

# -*-mode:sh-*- vim:ft=sh
