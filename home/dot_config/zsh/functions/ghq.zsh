# -*-mode:zsh-*- vim:ft=zsh

function _ghq_browse_repository() {
  local repo="$(ghq list --full-path | \
      fzf --prompt='  ' --highlight-line \
          --header "List of repositories managed by ghq | Enter: Browse | Esc: Exit" \
          --footer "Navigate with Ctrl + h/j/k/l or arrows" \
          --preview 'bat --color=always {}/README.md || echo "No README.md"' \
          --bind 'ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview' --exit-0)"
  [ -n "${repo}" ] && cd "${repo}" && nvim
  zle accept-line
  zle reset-prompt
}

zle -N _ghq_browse_repository
bindkey "^g" _ghq_browse_repository
