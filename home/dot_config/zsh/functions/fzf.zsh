# -*-mode:zsh-*- vim:ft=zsh

function _fzf_cd_ghq() {
  local repo="$(ghq list --full-path | fzf --prompt='  ' --preview 'bat --color=always {}/README.md || echo "No README.md"' --bind 'ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview' --exit-0)"
  [ -n "${repo}" ] && cd "${repo}"
  zle accept-line
  zle reset-prompt
}

zle -N _fzf_cd_ghq
bindkey "^g" _fzf_cd_ghq
