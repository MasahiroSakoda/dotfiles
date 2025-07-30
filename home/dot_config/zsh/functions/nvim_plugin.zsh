# -*-mode:zsh-*- vim:ft=zsh

function _nvim_cd_plugin() {
  local repo="$(fd . $XDG_DATA_HOME/nvim/lazy --full-path --min-depth=1 --max-depth=1 -t=d | fzf --prompt '  ' --preview 'bat --color=always {}/README.md || echo "No README.md"' --bind 'ctrl-u:preview-up,ctrl-d:preview-down,ctrl-/:toggle-preview' --exit-0)"
  [ -n "${repo}" ] && cd "${repo}"
  zle accept-line
  zle reset-prompt
}

zle -N _nvim_cd_plugin
bindkey "^x" _nvim_cd_plugin
