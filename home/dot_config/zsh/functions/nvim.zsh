# -*-mode:zsh-*- vim:ft=zsh

function _nvim_browse_plugin() {
  local repo="$(fd . $XDG_DATA_HOME/nvim/lazy --full-path --min-depth=1 --max-depth=1 -t=d | \
      fzf --prompt '  ' --highlight-line \
          --border --border-label "Browse NeoVim plugin repository" --border-label-pos 0 \
          --header "List of NeoVim plugins | Enter: Browse | Esc: Exit" \
          --footer "Navigate with Ctrl + h/j/k/l or arrows" \
          --preview 'bat --color=always {}/README.md || echo "No README.md"' \
          --bind 'ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview' --exit-0)"
  [ -n "${repo}" ] && cd "${repo}" && nvim
  zle accept-line
  zle reset-prompt
}

zle -N _nvim_browse_plugin
bindkey "^x" _nvim_browse_plugin
