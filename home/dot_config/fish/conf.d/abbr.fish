# Fish
abbr -a fishrc chezmoi edit $HOME/.config/fish/config.fish

# Prompt
abbr -a cl clear

# File
abbr -a o open
abbr -a oa open -a
abbr -a cpr "cp -R"
abbr -a rmf "rm -f"
abbr -a rmrf "rm -rf"

# Directory
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .... "cd ../../.."
abbr -a .2 "cd ../../"
abbr -a .3 "cd ../../../"
abbr -a .4 "cd ../../../../"
abbr -a .5 "cd ../../../../../"
abbr -a cwd "pwd | pbcopy"

# Permission
abbr -a chx "chmod +x"
abbr -a chR "chmod -R"

# Git
abbr -a g git
abbr -a gs git status
abbr -a gl git log --graph --all
abbr -a gla git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gb git branch
abbr -a ga git add
abbr -a gc git commit -m
abbr -a gco git checkout
abbr -a gm git merge
abbr -a gps git push
abbr -a gpl git pull
abbr -a gcl git clone
abbr -a clone git clone

# Docker
## docker-compose
abbr -a dc docker-compose
abbr -a dcu docker-compose up
abbr -a dcd docker-compose down

# chezmoi
abbr -a cz chezmoi
abbr -a czd "chezmoi diff | bat"
abbr -a czD chezmoi doctor
abbr -a czu chezmoi update
abbr -a czap chezmoi apply

## init
abbr -a czi chezmoi init
abbr -a czia chezmoi init --apply

## add
abbr -a czad chezmoi add
abbr -a czat chezmoi add --template

## remove
abbr -a czr chezmoi remove
abbr -a czrf chezmoi remove --force

## edit
abbr -a cze chezmoi edit
abbr -a czea chezmoi edit --apply

# Homebrew
abbr -a b brew
abbr -a bi brew install
abbr -a bic brew install --cask
abbr -a bri brew reinstall
abbr -a bif brew info
abbr -a bo brew outdated
abbr -a bu brew update
abbr -a bug brew upgrade

# Node.js
## npm
abbr -a ni npm install
abbr -a nt npm run test
abbr -a nb npm run build
abbr -a nd npm run dev

## yarn
abbr -a y yarn
abbr -a ya yarn add
abbr -a yad yarn add -D
abbr -a yb yarn build
abbr -a yd yarn dev
abbr -a ye yarn e2e
abbr -a yg yarn generate
abbr -a yl yarn lint
abbr -a yp yarn plop
abbr -a yt yarn test
abbr -a ys yarn server
abbr -a yu yarn ui
abbr -a yw yarn web

# Rails
abbr -a rn rails new
abbr -a rs rails server

# Downloader
## yt-dlp
abbr -a yt yt-dlp -civ
