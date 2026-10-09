#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"
load "../../helpers/validate_shell.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".gemini/antigravity-cli/AGENTS.md is valid" {
  [ -f "${HOME_SRC}/dot_config/opencode/AGENTS.md.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_config/opencode/AGENTS.md.tmpl"
  [ "$status" -eq 0 ]
}

@test ".gemini/antigravity-cli/settings.json is valid" {
  [ -f "${HOME_SRC}/dot_gemini/antigravity-cli/private_settings.json.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_gemini/antigravity-cli/private_settings.json.tmpl"
  [ "$status" -eq 0 ]

}

@test ".gemini/antigravity-cli/keybindings.json is valid" {
  [ -f "${HOME_SRC}/dot_gemini/antigravity-cli/private_keybindings.json.tmpl" ]
  run chezmoi execute-template <"${HOME_SRC}/dot_gemini/antigravity-cli/private_keybindings.json.tmpl"
  [ "$status" -eq 0 ]

}

@test ".gemini/antigravity-cli/scripts/statusline.sh is valid" {
  assert_valid_shell "${HOME_SRC}/dot_gemini/antigravity-cli/scripts/executable_statusline.sh"
}

@test ".gemini/antigravity-cli/scripts/title.sh is valid" {
  # Assert the deployed targets rather than globbing ~/.gemini, which can hold
  # files chezmoi does not manage.
  for name in title.sh statusline.sh; do
    run assert_chezmoi_attr "${HOME}/.gemini/antigravity-cli/scripts/${name}" file executable
    [ "$status" -eq 0 ]
  done

  assert_valid_shell "${HOME_SRC}/dot_gemini/antigravity-cli/scripts/executable_title.sh"
}

# -*-mode:sh-*- vim:ft=sh
