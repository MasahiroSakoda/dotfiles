#!/usr/bin/env bash

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck disable=SC2034
REPO_ROOT="${PROJECT_ROOT}"

HOME_SRC="${PROJECT_ROOT}/home"
# shellcheck disable=SC2034
CHEZMOI_SOURCE="$HOME_SRC"

common_setup() {
  cd "${PROJECT_ROOT}" || exit 1
}

skip_if_no_command() {
  local cmd="$1"
  if ! command -v "$cmd" &>/dev/null; then
    skip "$cmd not installed"
  fi
}

skip_if_no_chezmoi_data() {
  if ! chezmoi data &>/dev/null; then
    skip "chezmoi data not configured"
  fi
}

# -*-mode:sh-*- vim:ft=sh
