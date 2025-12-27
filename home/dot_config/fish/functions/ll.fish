function ll --wraps="eza --all --long --icons --header --time-style=iso --color=automatic --group-directories-first --git-ignore" --description "Override `ls -al` cmd with `eza`"
  command eza --all --long --icons=auto --color=auto --group-directories-first --git-ignore --header --time-style=iso $argv
end
