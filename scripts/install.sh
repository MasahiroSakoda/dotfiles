#!/usr/bin/env bash
set -e
. bin/echo.sh

PKG_DIR="${HOME}/.dotfiles/packages"

if ! (type brew > /dev/null 2>&1); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Permission
sudo chown -R "$(whoami)":admin /usr/local/*
sudo chmod -R g+w /usr/local/*

# Installation
brew bundle -v --file="${PKG_DIR}/Brewfile"
brew bundle -v --file="${PKG_DIR}/Caskfile"
brew bundle -v --file="${PKG_DIR}/Masfile"

# Change default shell
chsh -s /usr/local/bin/fish

# Install/Update Fish shell plugin
fisher update
