# -*-mode:fish-*- vim:ft=fish

function zellij_picker --description "Control Zellij session with fzf"
  set -l OPENER "zellij attach {1}"
  zellij list-sessions 2>/dev/null | sed "s/\x1b\[[0-9;]*m//g" | awk "{print $1}" | \
    fzf --prompt "  " \
      # --layout reverse --height "~40%" \
      --header "List of Zellij sessions: Ctrl+x: Kill sessions" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-x:execute-silent(zellij delete-session --force {})+reload(zellij list-sessions 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | awk '{print \$1}')" \
      --preview "zellij list-sessions | rg {1}" \
      --preview "down,1,border-line,nowrap,noinfo" \
      --query "$argv"
end
