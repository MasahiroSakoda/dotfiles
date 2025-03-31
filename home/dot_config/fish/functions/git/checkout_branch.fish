# -*-mode:fish-*- vim:ft=fish

function checkout_beanch -d "checkout branch with fuzzy search"
  set -l branch (
    git --no-pager branch --all | grep -v "origin/HEAD" | sed -e "s/^.* //g" |
    fzf --no-multi --prompt "  " --preview "git --no-pager log -20 --color=always {}" --bind "ctrl-u:preview-up,ctrl-d:preview-down"
  )

  if test -n "$branch"
    git checkout $branch
  end
end
