# -*-mode:zsh-*- vim:ft=zsh

function _nvim_cd_plugin() {
  local plugin_dir="$XDG_DATA_HOME/nvim/lazy"
  local repo_dir="$(fd . ${plugin_dir} --full-path -min-depth=1 --max-depth=1 -t=d | fzf --preview 'bat --color=always' ${plugin_dir}/{1})"
  local dir="${plugin_dir}/${repo_dir}"
  [ -n "${dir}" ] && cd "${dir}" && nvim
  zle accept-line
  zle reset-prompt
}

zle -N _nvim_cd_plugin
bindkey "^x" _nvim_cd_plugin
