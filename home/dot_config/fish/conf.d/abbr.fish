# Fish
abbr -a fishrc chezmoi edit $HOME/.config/fish/config.fish

# Prompt
abbr -a cl clear
abbr -a x exit

# tmux
abbr -a tm tmux
abbr -a tmd "tmux a -t default || tmux new -s default\; source $HOME/.config/tmux/default.session.conf"

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

## git status
abbr -a gs git status
abbr -a gss git status --short
abbr -a gsb git status --short --branch

## git add
abbr -a ga git add --verbose
abbr -a gaa git add --verbose --all

abbr -a gf git fetch
abbr -a gfo git fetch origin

abbr -a gm git merge
abbr -a gma git merge --abort
abbr -a gms git merge --squash

## git rm
abbr -a grm git rm
abbr -a grmc git rm --cached

## git clone
abbr -a gcl git clone
abbr -a clone git clone

## git log
abbr -a gl git log --graph --all
abbr -a gla git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'

## git diff
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gdc git diff --cached

## git commit
abbr -a gcm git commit -m
abbr -a gcma git commit --amend

## git cherry-pick
abbr -a gcp git cherry-pick
abbr -a gcpe git cherry-pick -e
abbr -a gcpn git cherry-pick -n
abbr -a gcpa git cherry-pick --abort
abbr -a gcpc git cherry-pick --continue

## git branch
abbr -a gb git branch
abbr -a gba git branch -a
abbr -a gbd git branch -d

## git checkout
abbr -a gco git checkout
abbr -a gcob git checkout -b
abbr -a gcoo git checkout --ours
abbr -a gcot git checkout --theirs

# git pull
abbr -a gpl git pull
abbr -a gplo git pull origin
abbr -a gplu git pull upstream
abbr -a gplr git pull --rebase

# git pull-request
abbr -a gpr git pull-request
abbr -a gprd git pull-request -d
abbr -a gprp git pull-request -p

# git push
abbr -a gps git push
abbr -a gpsu git push upstream
abbr -a gpsd git push --dry-run

## git rebase
abbr -a grb git rebase
abbr -a grba git rebase --abort
abbr -a grbc git rebase --continue
abbr -a grbi git rebase --interactive
abbr -a grbs git rebase --skip

## git tag
abbr -a gt git tag -a
abbr -a gts git tag --sign

## GitHub CLI
abbr -a ghs gh status

### issue
abbr -a ghi gh issue
abbr -a ghil gh issue list
abbr -a ghis gh issue status
abbr -a ghic gh issue create
abbr -a ghiC gh issue close
abbr -a ghiv gh issue view

### GitHub Actions
abbr -a ghw gh workflow
abbr -a ghwl gh workflow list

### gh extension
abbr -a ghe gh extension
abbr -a ghel gh extension list
abbr -a ghes gh extension search
abbr -a gheb gh extension browse
abbr -a ghei gh extension install
abbr -a gher gh extension remove

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
abbr -a czew chezmoi edit --watch

# Homebrew
abbr -a b brew
abbr -a bi brew install
abbr -a bic brew install --cask
abbr -a bri brew reinstall
abbr -a bif brew info
abbr -a bo brew outdated
abbr -a bu brew update
abbr -a bug brew upgrade

# cht.sh
abbr -a chtsh cht.sh --shell

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
abbr -a rr rails routes
abbr -a rs rails server
abbr -a rd rails destroy

## rails generate
abbr -a rg rails generate
abbr -a rgs rails generate scaffold
abbr -a rgc rails generate controller
abbr -a rgmi rails generate migration
abbr -a rgmo rails generate model

## rails db
abbr -a rdb rails db:
abbr -a rdbc rails db:create
abbr -a rdbm rails db:migrate
abbr -a rdbp rails db:prepare
abbr -a rdbd rails db:drop
abbr -a rdbr rails db:reset
abbr -a rdbs rails db:seed

# Downloader
## yt-dlp
abbr -a yt yt-dlp -civ
