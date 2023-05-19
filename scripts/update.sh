#!/usr/bin/env bash
set -e

. bin/echo.sh

PKG_DIR="${HOME}/.dotfiles/packages"

fisher update
brew update
