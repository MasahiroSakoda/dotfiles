alias vi="nvim"
alias vim="nvim"

alias o="open"
alias c="clear"
alias cl="clear"
alias cat="bat"
alias lg="lazygit"
alias g="git"

alias w3m='/usr/local/bin/w3m -I utf-8 -O utf-8 -m -num -s'

# Navigation
alias ...="cd ../../"
alias ....="cd ../../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../../"

# YouTube
alias audio-dl="yt-dlp -civ --external-downloader aria2c --external-downloader-args '-c -x 5 -k 2M' --extract-audio --audio-format mp3 --audio-quality 320k -o '%(title)s.%(ext)s' "
alias video-dl="yt-dlp -civ --write-auto-sub --sub-format vtt --sub-lang en --embed-subs --external-downloader aria2c --external-downloader-args '-c -x 5 -k 2M' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o '%(title)s.%(ext)s' "

# Apps
alias 0xed="open -a ~/Applications/0xED.app"
