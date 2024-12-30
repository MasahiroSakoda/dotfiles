# -*-mode:fish-*- vim:ft=fish
function zellij-session -d "Select zellij session via fzf"
  zellij attach $(zellij list-sessions | fzf --ansi | awk 'print $1')
end
