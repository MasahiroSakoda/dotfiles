# -*-mode:zsh-*- vim:ft=zsh

function tldr() {
  local name=$(command tldr --list --color always | fzf --query "$1" --preview "command tldr --color always {}" --exit-0)
  command tldr $name
}
