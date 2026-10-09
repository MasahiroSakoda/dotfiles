#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".ssh directory is private" {
  run assert_chezmoi_attr "${HOME}/.ssh" dir private perm:0700
  [ "$status" -eq 0 ]
}

@test ".ssh/config is private" {
  run assert_chezmoi_attr "${HOME}/.ssh/config" file private perm:0600
  [ "$status" -eq 0 ]
}

@test ".ssh/known_hosts is private" {
  run assert_chezmoi_attr "${HOME}/.ssh/known_hosts" file private perm:0600
  [ "$status" -eq 0 ]
}

# -*-mode:sh-*- vim:ft=sh
