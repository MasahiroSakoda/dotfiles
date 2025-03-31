# -*-mode:fish-*- vim:ft=fish
function zellij-layout -d "Select zellij layout via `fzf`"
  fd . $XDG_CONFIG_HOME/zellij/layouts --full-path --min-depth=1 --max-depth=1 --extension kdl | \
    fzf --ansi | read -l layout
  [ -n "$layout" ]; and zellij --layout $layout
end

# bind \c
