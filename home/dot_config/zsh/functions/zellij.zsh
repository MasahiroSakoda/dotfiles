# -*-mode:zsh-*- vim:ft=zsh

function zellij-default() {
  zellij --layout default
}

function zellij-coding() {
  zellij --layout coding
}

function zellij-jsdev() {
  zellij --layout jsdev
}

function zellij-monitor() {
  zellij --layout monitor
}

function zellij-session() {
  zellij attach $(zellij list-sessions | fzf --ansi | awk 'print $1')
}

function zellij-layout() {
  local layout_dir="$XDG_CONFIG_HOME/zellij/layouts"
  local layout="$(fd . ${layout_dir} --full-path -min-depth=1 --max-depth=1 --extension kdl | fzf --ansi)"
  [ -n "$layout" ] && zellij --layout $layout
  zle accept-line
  zle reset-prompt
}
