#!/usr/bin/env bash
set -e

# symlink via GNU stow
stow -v -d ${HOME}/.dotfiles/packages -t ~ fish git nvim bat bottom karabiner
