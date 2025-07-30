# -*-mode:fish-*- vim:ft=fish

function tldr --description "Too long, Don't read"
  set name (command tldr --list --color always | fzf --query "$argv" --preview "command tldr --color=always {}" --exit-0 )
  and command tldr $name
  commandline -f repaint
end
