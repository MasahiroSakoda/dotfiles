# -*-mode:fish-*- vim:ft=fish

function __mise_installed_tools -d "Browse installed mise tools"
  mise ls | grep -v '$Version' | tr '\t' ' ' | cut -d ' ' -f 1 | \
    fzf --prompt "  " --highlight-line \
        --border --border-label "Browse installed mise tools" --border-label-pos 0 \
        --header "List of installed mise tools" \
        --footer "Navigate with Ctrl + h/j/k/l or arrows" \
        --preview "mise tool {}" \
        --bind "ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview" \
        --exit-0 | read -l tool
  echo mise tool $tool
  commandline -f repaint
end
