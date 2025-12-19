# -*-mode:fish-*- vim:ft=fish
function zellij-session -d "Select zellij session via fzf"
  zellij list-sessions | fzf --style full --prompt "  " --header "List of zellij sessions" \
      --layout=reverse --height "~40%" --exit-0 | read -l session
  zellij attach $session
end
