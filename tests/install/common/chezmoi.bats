#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/validate_shell.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".chezmoiroot points to home/" {
  [ -f "$PROJECT_ROOT/.chezmoiroot" ]
  run cat "$PROJECT_ROOT/.chezmoiroot"
  [ "$output" = "home" ]
}

@test "home/.chezmoi* exists" {
  [ -f "${HOME_SRC}/.chezmoi.toml.tmpl" ]
  [ -f "${HOME_SRC}/.chezmoiversion" ]
  [ -f "${HOME_SRC}/.chezmoiignore" ]
  [ -f "${HOME_SRC}/.chezmoiremove.tmpl" ]
}

@test "home/.chezmoidata/*.toml exists" {
  for f in "${HOME_SRC}"/.chezmoidata/*.toml; do
    [ -f "$f" ]
  done
}

@test "home/.chezmoiscripts/*.sh.tmpl exists" {
  for f in "${HOME_SRC}"/.chezmoiscripts/*.sh.tmpl; do
    run chezmoi execute-template < "$f"
    [ "$status" -eq 0 ]
    run assert_valid_shell "$f"
    [ "$status" -eq 0 ]
  done
}

@test "home/.chezmoiexternals/*.toml.tmpl renders properly" {
  for f in "${HOME_SRC}"/.chezmoiexternals/*.toml.tmpl; do
    [ -f "$f" ]
    run chezmoi execute-template < "$f"
    [ "$status" -eq 0 ]
  done
}

# INFO: chezmoi templates are validated in specific tools
# @test "home/.chezmoitempaltes/* exists" {
#   for f in "${HOME_SRC}"/.chezmoitemplates/*; do
#     [ -f "$f" ]
#   done
# }

@test "chezmoi managed files list is non-empty" {
  skip_if_no_command chezmoi
  run chezmoi managed --include=files
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -gt 0 ]
}

@test "chezmoi diff runs without crash" {
  skip_if_no_command chezmoi
  # diff exits 0 if no changes, non-zero if changes exist - both are fine
  run chezmoi diff --no-pager
  # Just checking it doesn't crash (exit 2+ would be an error)
  [[ "$status" -eq 0 ]] || [[ "$status" -eq 1 ]]
}

# -*-mode:sh-*- vim:ft=sh
