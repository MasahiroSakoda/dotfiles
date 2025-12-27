function lt --wraps="eza --all --tree --icons --header --time-style=iso --color=automatic --group-directories-first --git-ignore" --description "Override `ls -al` cmd with `eza`"
  command eza --tree --icons=auto --color=auto --group-directories-first --git-ignore $argv
end
