# -*-mode:fish-*- vim:ft=fish

function __nvim_browse_plugin -d "Browse NeoVim plugin repository"
  fd . $XDG_DATA_HOME/nvim/lazy --full-path --min-depth=1 --max-depth=1 -t=d | \
    fzf --preview "bat --color=always {}/README.md || echo 'No README.md'" \
        --bind "ctrl-u:preview-up,ctrl-d:preview-down" --exit-0 | \
    read -l repo_path
  [ -n "$repo_path" ]; and cd "$repo_path"; and nvim
  commandline -f repaint
end
