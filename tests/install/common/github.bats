#!/usr/bin/env bats

load "../../helpers/test_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}
@test ".github/CODEOWNERS file exists" {
  [ -f "${PROJECT_ROOT}/.github/CODEOWNERS" ]
  [ -f "${PROJECT_ROOT}/.github/labeler.yml" ]
  [ -f "${PROJECT_ROOT}/.github/renovate.json" ]
  [ -f "${PROJECT_ROOT}/.github/.pinact.yaml" ]
}

@test ".github/ISSUE_TEMPLATE/*.yml file exists" {
  for f in "${PROJECT_ROOT}"/.github/ISSUE_TEMPLATE/*.yml; do
    [ -f "$f" ]
  done
}

@test ".github/pull_request_template.md file exists" {
  [ -f "${PROJECT_ROOT}/.github/pull_request_template.md" ]
}

@test ".github/workflows/*.yml file exists" {
  for f in "${PROJECT_ROOT}"/.github/workflows/*.yml; do
    [ -f "$f" ]
  done
}

# -*-mode:sh-*- vim:ft=sh
