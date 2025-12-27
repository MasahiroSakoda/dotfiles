function ls --wraps="eza -a --grid --icons --color=automatic --group-directories-first --git-ignore" --description "Override `ls -a` cmd with `eza`"
  command eza --all --icons=auto --color=auto --group-directories-first --git-ignore --grid $argv
end
