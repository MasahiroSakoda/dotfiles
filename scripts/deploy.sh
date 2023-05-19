#!/usr/bin/env bash
set -e
ROOT_DIR=${HOME}/.local/share/chezmoi

# symlink via GNU stow
stow -v -d ${ROOT_DIR}/packages -t ~ fish
stow -v -d ${ROOT_DIR}/packages -t ~ git
stow -v -d ${ROOT_DIR}/packages -t ~ nvim
stow -v -d ${ROOT_DIR}/packages -t ~ bat
stow -v -d ${ROOT_DIR}/packages -t ~ bottom
