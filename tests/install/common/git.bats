#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".gitignore exists" {
  [ -f "$PROJECT_ROOT/.gitignore" ]
}

@test ".lefthook.yaml exists" {
  [ -f "$PROJECT_ROOT/.lefthook.yaml" ]
}

# -*-mode:sh-*- vim:ft=sh
