# -*-mode:zsh-*- vim:ft=zsh

function tldr() {
  local name=$(command tldr --list --color always | fzf --query "$1" --preview "command tldr --color always {}")
  command tldr $name
}
