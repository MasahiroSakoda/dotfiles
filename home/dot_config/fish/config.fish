# Language/Locale Configuration
set -x LANG ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8

# Path Configuration
set -g PATH /bin /sbin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin $HOME/.local/bin /usr/local/opt/bison/bin $PATH

# Editor
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

# GNU binutils
set -gx LDFLAGS "-L/usr/local/opt/binutils/lib"
set -gx CPPFLAGS "-I/usr/local/opt/binutils/include"

# Readline
set -gx PKG_CONFIG_PATH "/usr/local/opt/readline/lib/pkgconfig"

# libffi
set -gx LDFLAGS "-L/usr/local/opt/libffi/lib"
set -gx CPPFLAGS "-I/usr/local/opt/libffi/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig"
set -gx RUBY_CFLAGS "-Wno-error=implicit-function-declaration"

# ripgrep config
# set -gx RIPGREP_CONFIG_PATH $HOME/.config/rg/ripgreprc

# Theme configuration for bobthefish
set -g theme_title_display_process yes
set -g theme_show_exit_status yes

set -g theme_display_date yes
set -g theme_date_format "+%F %H:%M"

set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# Git
set -x theme_display_git_master_branch yes

# Pager
set -gx LESS_TERMCAP_mb \e'[01;31m'
# set -gx PAGER "lv -c"
set -gx PAGER "less"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p --style=numbers'"
set -gx BAT_THEME "Monokai Extended Origin"
set -gx LV "-Ou8 -c -Sh1;36 -Su1;4;32 -Ss7;37;1;33"

# Grep
set -x GREP_OPTIONS "--color=always"

# asdf
source (brew --prefix asdf)/libexec/asdf.fish

# Ruby
set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@3)"

# Node.js
set -gx NODE_ENV development

# Homebrew
switch (uname -m)
  case arm64
    set -gx HOMEBREW_PREFIX /opt/homebrew
  case "*"
    set -gx HOMEBREW_PREFIX /usr/local
end

if test -d $HOMEBREW_PREFIX
  set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
end


## Cask
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"

# GitHub
## hub
eval (hub alias -s)

# Fish Plugin
## Configure fish plugins
set fish_plugins theme peco git osx brew rails bundler gem pbcopy

## peco
function fish_user_key_bindings
  bind \cr peco_select_history # Bind for peco history to Ctrl+r
end

## fzf search
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100% --border"

## Done notification
set -x __done_min_cmd_duration 60000  # default: 5000 ms

# Wine
set -x PATH "/usr/local/opt/wine-6.1/bin" $PATH

set -gx OPENAI_API_KEY (security find-generic-password -s "OpenAI API Key" -w)
set -gx GOOGLE_API_KEY (security find-generic-password -s "Google API Key" -w)
