#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../helpers/chezmoi_helper.sh"
load "../../helpers/validate_shell.sh"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
}

@test ".config/zsh/zsh* is valid" {
  for f in "${HOME_SRC}"/dot_config/zsh/z*; do
    [ -f "$f" ]
  done

  run chezmoi execute-template < "${HOME_SRC}/dot_config/zsh/zshenv.tmpl"
  [ "$status" -eq 0 ]
}

@test ".config/zsh/zsh* is symlinks" {
  run assert_chezmoi_attr "${HOME}/.config/zsh/.zshrc" symlink linkname zshrv
  run assert_chezmoi_attr "${HOME}/.config/zsh/.zprofile" symlink linkname zprofile
  run assert_chezmoi_attr "${HOME}/.config/zsh/.zshenv" symlink linkname zshenv
  run assert_chezmoi_attr "${HOME}/.config/zsh/.zlogin" symlink linkname zlogin
  run assert_chezmoi_attr "${HOME}/.config/zsh/.zlogout" symlink linkname zlogout
}

@test ".config/zsh/functions/*.zsh is valid" {
  for f in "${HOME_SRC}"/dot_config/zsh/functions/*.zsh; do
    [ -f "$f" ]
  done
  for f in "${HOME_SRC}"/dot_config/zsh/functions/*.zsh.tmpl; do
    [ -f "$f" ]
    run chezmoi execute-template < "$f"
    [ "$status" -eq 0 ]
  done
}

@test ".config/zsh/abbreviations exists" {
  [ -f "${HOME_SRC}/dot_config/zsh/abbreviations" ]
  run assert_valid_shell "${HOME_SRC}/dot_config/zsh/abbreviations"
  [ "$status" -eq 0 ]
}

# -*-mode:sh-*- vim:ft=sh
