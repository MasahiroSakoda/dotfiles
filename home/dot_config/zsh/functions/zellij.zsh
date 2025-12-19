# -*-mode:zsh-*- vim:ft=zsh

function zellij-session() {
local session="$(zellij list-sessions | fzf --style full --prompt "  " --header "List of zellij sessions" --layout=reverse --height "~40%" --exit-0)"
[ -n "${session}" ] && zellij attach "${session}"
  zle accept-line
  zle reset-prompt
}
