#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test "apm.yml file exists" {
  [ -f "${PROJECT_ROOT}/apm.yml" ]
  [ -f "${HOME_SRC}/dot_apm/apm.yml" ]
}

# @test "apm-policy.yml file exists" {
#   [ -f "$PROJECT_ROOT/apm-policy.yml" ]
# }

# -*-mode:sh-*- vim:ft=sh
