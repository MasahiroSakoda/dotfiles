# -*-mode:fish-*- vim:ft=fish

set -gx ZELLIJ_CONFIG_DIR "$XDG_CONFIG_HOME/zellij"
set -gx ZELLIJ_CONFIG_FILE "$ZELLIJ_CONFIG_DIR/config.kdl"
set -gx ZELLIJ_LAYOUTS_DIR "$ZELLIJ_CONFIG_DIR/layouts"

function zjs --description "Navigate Zellij sessions"
  zellij list-sessions --no-formatting --short 2>/dev/null | \
    fzf --prompt "  " --highlight-line \
      --header "List of Zellij sessions | Enter: Attach | Ctrl+x: Kill" \
      --footer "Navigate with Ctrl + h/j/k/l or arrows" \
      --preview "zellij list-sessions --no-formatting | rg -w {}" \
      --preview-window "down,1,border-line,nowrap,noinfo" \
      --bind "enter:become:zellij attach {}" \
      --bind "ctrl-x:execute-silent(zellij delete-session --force {})+reload(zellij list-sessions --no-formatting --short 2>/dev/null)" \
      --query "$argv"
  commandline -f repaint
end
