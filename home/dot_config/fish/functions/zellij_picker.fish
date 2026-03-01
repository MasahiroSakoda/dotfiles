# -*-mode:fish-*- vim:ft=fish

function zellij_picker --description "Control Zellij session with fzf"
  zellij list-sessions --no-formatting --short 2>/dev/null | \
    fzf --prompt "  " \
      --header "List of Zellij sessions | Enter: Attach | Ctrl+x: Kill" \
      --bind "enter:become:zellij attach {}" \
      --bind "ctrl-x:execute-silent(zellij delete-session --force {})+reload(zellij list-sessions --no-formatting --short 2>/dev/null)" \
      --preview "zellij list-sessions --no-formatting | rg -w {}" \
      --preview-window "down,1,border-line,nowrap,noinfo" \
      --query "$argv"
end
