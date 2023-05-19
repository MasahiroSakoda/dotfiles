# dotfiles
Bootstrap scripts & build macOS development environment

## Features
* One Line Install
* Install packages with Makefile
* asdf version management
* LSP & DAP Configuration for NeoVim

## Components
* Shell: [Fish](https://github.com/fish-shell/fish-shell)
* Package Management: [Homebrew](https://brew.sh)
* Source Version Management: [Git](https://github.com/git/git)
* Language Version Management: [asdf](https://github.com/asdf-vm/asdf)
  * [Python](https://www.python.org/)
  * [Ruby](https://www.ruby-lang.org/)
  * [Node.js](https://nodejs.org/)
  * [deno](https://deno.com/)
* Editor: [NeoVim](https://github.com/neovim/neovim)
* Pager: [bat](https://github.com/sharkdp/bat)
* Performance Monitor: [bottom](https://github.com/ClementTsang/bottom)
* Keyboard Mapping: [Karabiner-Elements](https://karabiner-elements.pqrs.org/)

# TODO
* .ssh
* .vscode
* .gemrc
* .tigrc

## Usage
##### Install Homebrew packages
```
$ make install
```

##### Install asdf packages
```
$ make asdf
```

##### Deploy symbolic link with GNU stow
```
$ make deploy
```

## Package Management
* [Homebrew](https://github.com/Homebrew/brew) with [Brewfile](https://github.com/MasahiroSakoda/dotfiles/blog/main/etc/macos/Brewfile)
* [Homebrew Cask](https://github.com/Homebrew/homebrew-cask) with [Caskfile](https://github.com/MasahiroSakoda/dotfiles/blog/main/etc/macos/Caskfile)
* App Store apps with [mas](https://github.com/mas-cli/mas)

## Installation
```
curl -fsSL https://raw.githubusercontent.com/MasahiroSakoda/dotfiles/master/bootstrap.sh | bash
```

## ToDo
* Update management
* install global tools (e.g. neovim via pip/gem)
