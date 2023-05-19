#!/usr/bin/env bash

set -u

TARGET_DIR="${HOME}/.config/nvim"
BACKUP_DIR=""
USE_SSH=1

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

is_executable() {
  type "$1" > /dev/null 2&>1
}

execute() {
  if ! "$@"; then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

info() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

warn() {
  printf "${tty_yellow}Warning${tty_reset}: %s\n" "$(chomp "$1")"
}

download_cmd() {
  local source="https://github.com/MasahiroSakoda/dotfiles"
  local tarball="$SOURCE/tarball/main"
  local tar_cmd="tar -xzv -C "$TARGET" --strip-components=1 --exclude='{.gitignore}'"
  local cmd=""

  if is_executable "git"; then
    cmd="git clone $source $TARGET"
  elif is_executable "curl"; then
    cmd="curl -#L $tarball | $tar_cmd"
  elif is_executable "wget"; then
    cmd="wget --no-check-certificate -O - $tarball | $tar_cmd"
  fi

  echo $cmd
}
