#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test "CLAUDE.md is valid" {
  run chezmoi execute-template <"${HOME_SRC}/dot_claude/private_CLAUDE.md.tmpl"
  [ "$status" -eq 0 ]

  run assert_chezmoi_attr "${HOME}/.claude/CLAUDE.md" file private perm:0600
  [ "$status" -eq 0 ]
}

@test ".claude/settings.json is valid" {
  run chezmoi execute-template <"${HOME_SRC}/dot_claude/private_settings.json.tmpl"
  [ "$status" -eq 0 ]

  run assert_chezmoi_attr "${HOME}/.claude/settings.json" file private perm:0600
  [ "$status" -eq 0 ]
}

@test ".claude/hooks/*.sh templates renders properly" {
  for f in "${HOME_SRC}"/dot_claude/hooks/*.sh.tmpl; do
    run chezmoi execute-template <"$f"
    [ "$status" -eq 0 ]
  done
}

@test ".claude/rules/*.md templates renders properly" {
  for f in "${HOME_SRC}"/dot_claude/rules/*.md.tmpl; do
    run chezmoi execute-template <"$f"
    [ "$status" -eq 0 ]
  done
}

# -*-mode:sh-*- vim:ft=sh
