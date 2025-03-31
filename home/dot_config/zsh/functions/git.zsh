# -*-mode:zsh-*- vim:ft=zsh

function checkout_branch() {
  local branch="$(git --no-pager branch --all | grep -v 'origin/HEAD' | sed -e 's/^.* //g' | fzf --prompt '  ' --preview 'git --no-pager log -20 --color=always {}' --bind 'ctrl-u:preview-up,ctrl-d:preview-down')"
  if [ -n "${branch}" ]; then
    git checkout ${branch}
    zle accept-line
  fi
  zle reset-prompt
}

zle -N checkout_branch
bindkey "^b" checkout_branch
