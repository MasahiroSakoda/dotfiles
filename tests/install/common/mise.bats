#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"
load "../../../.bats-libs/bats-assert/load"
load "../../../.bats-libs/bats-support/load"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
  MISE_CONFIG="${HOME_SRC}/dot_config/mise/config.toml.tmpl"
}

@test ".config/mise/config.toml is valid" {
  [ -f "${MISE_CONFIG}" ]

  run chezmoi execute-template < "${MISE_CONFIG}"
  [ "$status" -eq 0 ]
}

@test "Verify minimum_release_age is 3 days" {
  run chezmoi execute-template < "${MISE_CONFIG}"
  assert_output --partial 'minimum_release_age = "3d"'
}

# @test "Verify GPG signing" {
#   run chezmoi execute-template < "${MISE_CONFIG}"
#   assert_output --partial 'gpg_verify = true'
# }

# -*-mode:sh-*- vim:ft=sh
