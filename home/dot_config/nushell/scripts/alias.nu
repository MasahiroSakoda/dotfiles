# -*-mode:nu-*- vim:ft=nu

# Nushell export aliases
export alias cl = clear
export alias x  = exit

export alias rg = rg --no-heading --with-filename --line-number --column --smart-case --trim

## File
export alias o    = open
export alias mv   = mv -iv
export alias cp   = cp -iv
export alias cpr  = cp -r
export alias rm   = rm -iv
export alias rmf  = rm -iv
export alias rmrf = rm -iv

## Directory
export alias mkdir = mkdir -v
export alias ..    = cd ..
export alias ...   = cd ../..
export alias ....  = cd ../../..
export alias ..... = cd ../../../..

# Pager / Previewer
export alias cat = bat

# Editor
export alias v   = nvim
export alias vi  = nvim
export alias vim = nvim

## Git
export alias lg  = lazygit
export alias g   = git
export alias gs  = git status
export alias gss = git status --short
export alias gsb = git status --short --branch
export alias gl  = git log --graph --all

export alias gd  = git diff
export alias gds = git diff --staged

export alias ga  = git add --verbose
export alias gaa = git add --verbose --all
export alias grm = git rm
export alias gmv = git mv --verbose

export alias gm  = git merge --verbose
export alias gma = git merge --abort
export alias gms = git merge --squash

export alias gb   = git branch --all
export alias gbd  = git branch -d
export alias gco  = git checkout
export alias gcob = git checkout -b
export alias gcoo = git checkout --ours
export alias gcot = git checkout --theirs

export alias gcl = git clone
export alias gf  = git fetch

export alias gpl  = git pull origin
export alias gplu = git pull upstream
export alias gplr = git pull --rebase

export alias gpr  = git pull-request
export alias gprd = git pull-request -d
export alias gprp = git pull-request -P

export alias gps  = git push origin
export alias gpsu = git push upstream
export alias gpsd = git push --dry-run

export alias grb  = git rebase
export alias grba = git rebase --abort
export alias grbc = git rebase --continue
export alias grbi = git rebase --interactive
export alias grbs = git rebase --skip

export alias gt  = git tag -a
export alias gts = git tag --sign

## GitHub cLI
export alias ghd = gh dash
export alias ghg = gh graph
export alias ghn = gh notify
export alias ghs = gh s
export alias ghm = gh markdown-preview