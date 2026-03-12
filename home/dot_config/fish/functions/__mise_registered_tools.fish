# -*-mode:fish-*- vim:ft=fish

function __mise_registered_tools -d "Browse installed mise tools"
  mise registry | \
    fzf --prompt "  " --highlight-line \
        --header "List of registered mise tools" \
        --footer "Navigate with Ctrl + h/j/k/l or arrows" \
        --bind "ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview" \
        --exit-0 | read -l tool
  echo mise search $tool
  commandline -f repaint
end
