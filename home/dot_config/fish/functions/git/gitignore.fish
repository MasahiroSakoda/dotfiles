# -*-mode:fish-*- vim:ft=fish

command -v gibo >/dev/null 2>&1

function gitignore -d "Generate .gitignore with incremental search"
  command gibo list | \
    fzf --multi --preview "bat --color=always $XDG_DATA_HOME/gibo/**/{}.gitignore" | \
    xargs gibo dump >> ./.gitignore
end
