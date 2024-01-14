# Fish

## Prompt
abbr -a cl clear
abbr -a x exit

## File
abbr -a o open
abbr -a oa open -a
abbr -a mv mv -iv
abbr -a cp cp -iv
abbr -a cpr cp -R
abbr -a rm rm -iv
abbr -a rmf rm -if
abbr -a rmrf rm -rf

## Directory
abbr -a cwd "pwd | pbcopy"
abbr -a mkdir mkdir -pv

abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .... "cd ../../.."
abbr -a .2 "cd ../../"
abbr -a .3 "cd ../../../"
abbr -a .4 "cd ../../../../"
abbr -a .5 "cd ../../../../../"


## Permission
abbr -a co chown -v
abbr -a cmx chmod +x
abbr -a cmr chmod -R


# Vim / NeoVim
abbr -a fishrc chezmoi edit $HOME/.config/fish/config.fish


# tmux
abbr -a tm tmux
abbr -a tmd "tmux a -t default || tmux new -s default\; source $HOME/.config/tmux/default.session.conf"
abbr -a tmn tmux new -s


# Git
abbr -a g git
abbr -a lg lazygit

## status
abbr -a gs git status
abbr -a gss git status --short
abbr -a gsb git status --short --branch

## log
abbr -a gl git log --graph --all

## diff
abbr -a gd git diff

## add / rm / mv
abbr -a ga git add --verbose
abbr -a gaa git add --verbose --all
abbr -a grm git rm --verbose
abbr -a gmv git mv --verbose

## merge
abbr -a gm git merge --verbose
abbr -a gma git merge --abort
abbr -a gms git merge --squash

## cherry-pick
abbr -a gcp git cherry-pick
abbr -a gcpe git cherry-pick -e
abbr -a gcpn git cherry-pick -n
abbr -a gcpa git cherry-pick --abort
abbr -a gcpc git cherry-pick --continue

## branch
abbr -a gb git branch --all
abbr -a gbd git branch -d

## checkout
abbr -a gco git checkout
abbr -a gcob git checkout -b
abbr -a gcoo git checkout --ours
abbr -a gcot git checkout --theirs

## clone / fetch
abbr -a gcl git clone
abbr -a gf git fetch origin

# pull
abbr -a gpl git pull origin
abbr -a gplu git pull upstream
abbr -a gplr git pull --rebase

# pull-request
abbr -a gpr git pull-request
abbr -a gprd git pull-request -d
abbr -a gprp git pull-request -p

# push
abbr -a gps git push origin
abbr -a gpsu git push upstream
abbr -a gpsd git push --dry-run

## rebase
abbr -a grb git rebase
abbr -a grba git rebase --abort
abbr -a grbc git rebase --continue
abbr -a grbi git rebase --interactive
abbr -a grbs git rebase --skip

## tag
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
abbr -a d docker
abbr -a dps docker ps
abbr -a dk docker kill
abbr -a dp docker pull
abbr -a dP docker push
abbr -a dr docker run --rm

## docker-compose
abbr -a dc docker-compose
abbr -a dcb docker-compose build
abbr -a dcu docker-compose up --build -d
abbr -a dcd docker-compose down
abbr -a dcl docker-compose logs
abbr -a dcr docker-compose run --rm
abbr -a dce docker-compose exec
abbr -a dcs docker-compose stop


# chezmoi
abbr -a .d "chezmoi diff | bat"
abbr -a .D chezmoi doctor
abbr -a .u chezmoi update
abbr -a .a chezmoi apply
abbr -a .c chezmoi cd
abbr -a .C chezmoi chattr

## init
abbr -a .i chezmoi init
abbr -a .ia chezmoi init --apply

## add
abbr -a .Ad chezmoi add --verbose
abbr -a .At chezmoi add --template

## remove
abbr -a .r chezmoi remove --verbose
abbr -a .rf chezmoi remove --force

## edit
abbr -a .e chezmoi edit --watch
abbr -a .ea chezmoi edit --apply


# Homebrew
abbr -a b brew
abbr -a bwre brew
abbr -a bwre brew

abbr -a bt brew tap
abbr -a but brew untap

abbr -a buse brew uses --recursive --installed
abbr -a bdep brew deps --tree --installed

abbr -a bi brew install
abbr -a bic brew install --cask
abbr -a bif brew install --force
abbr -a bri brew reinstall

abbr -a bo brew outdated
abbr -a bug brew upgrade

abbr -a bl brew link
abbr -a bul brew unlink

# cht.sh
abbr -a chtsh cht.sh --shell


# Node.js
## npm
abbr -a nl npm list
abbr -a ni npm install
abbr -a nid npm install -D
abbr -a nig npm install -d
abbr -a nu npm update
abbr -a nt npm run test
abbr -a nb npm run build
abbr -a nd npm run dev
abbr -a nci npm ci

## pnpm
abbr -a p pnpm
abbr -a pa pnpm add
abbr -a pe pnpm exec
abbr -a ph pnpm help
abbr -a pi pnpm install
abbr -a pid pnpm install -D
abbr -a pim pnpm import
abbr -a pls pnpm ls
abbr -a psa pnpm store add
abbr -a psp pnpm store prune
abbr -a pss pnpm store status
abbr -a pst pnpm start
abbr -a pt pnpm test

### pnpm scripts
abbr -a pb pnpm build
abbr -a pr pnpm rebuild
abbr -a pd pnpm dev
abbr -a pe pnpm e2e
abbr -a pu pnpm unit

## deno
abbr -a dn deno
abbr -a dnh "deno help | bat"
abbr -a dnt deno task
abbr -a dnr deno run


# Rails
abbr -a rn rails new
abbr -a rr rails routes
abbr -a rs rails server
abbr -a rd rails destroy

## rails generate
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
