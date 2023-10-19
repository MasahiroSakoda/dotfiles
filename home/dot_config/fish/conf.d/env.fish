# -*-mode:fish-*- vim:ft=fish

# XDG paths
set -gx XDG_BIN_HOME $HOME/.local/bin
set -gx XDG_LIB_HOME $HOME/.local/lib
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

# Homebrew
set -gx HOMEBREW_PREFIX "{{ .brew_prefix }}"
if test -d $HOMEBREW_PREFIX
  set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
end

## Cask
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"
