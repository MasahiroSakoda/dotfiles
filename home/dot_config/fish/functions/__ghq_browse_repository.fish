# -*-mode:fish-*- vim:ft=fish

function __ghq_browse_repository -d "Browse ghq repository"
  ghq list --full-path | \
    fzf --prompt "  " --preview "bat --color=always {}/README.md || echo 'No README.md'" \
        --bind "ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview" --exit-0 | \
    read -l repo_path

  [ -n "$repo_path" ]; and cd "$repo_path"; and nvim
  commandline -f repaint
end
