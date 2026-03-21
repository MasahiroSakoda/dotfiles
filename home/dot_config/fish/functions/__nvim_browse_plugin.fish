# -*-mode:fish-*- vim:ft=fish

function __nvim_browse_plugin -d "Browse NeoVim plugin repository"
  fd . $XDG_DATA_HOME/nvim/lazy --full-path --min-depth=1 --max-depth=1 -t=d | \
    fzf --prompt "  "  --highlight-line \
        --border --border-label "Browse NeoVim plugin repository" --border-label-pos 0 \
        --header "List of NeoVim plugins | Enter: Browse | Esc: Exit" \
        --footer "Navigate with Ctrl + h/j/k/l or arrows" \
        --preview "bat --color=always {}/README.md || echo 'No README.md'" \
        --bind "ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview" \
        --exit-0 | read -l repo_path
  [ -n "$repo_path" ]; and cd "$repo_path"; and nvim
  commandline -f repaint
end
