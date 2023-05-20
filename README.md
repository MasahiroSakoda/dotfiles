# dotfiles
Bootstrap scripts & build macOS development environment

![last commit](https://img.shields.io/github/last-commit/MasahiroSakoda/dotfiles)
![commit activity](https://img.shields.io/github/languages/top/MasahiroSakoda/dotfiles)
![license](https://img.shields.io/github/license/MasahiroSakoda/dotfiles)
[![lint](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/lint.yml)
---

## Features
* One Line Install
* dotfiles management using [chezmoi](https://github.com/twpayne/chezmoi)
* LSP & DAP Configuration for NeoVim

## Components
* Shell: [Fish](https://github.com/fish-shell/fish-shell)
* Package Management: [Homebrew](https://brew.sh)
  * [Brewfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/homebrew/Brewfile.tmpl)
  * [Caskfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/homebrew/Caskfile.tmpl)
  * [Masfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/homebrew/Masfile)
* Source Version Management: [Git](https://github.com/git/git)
* Language Version Management: [asdf](https://github.com/asdf-vm/asdf)
  * [Python](https://www.python.org/) from [asdf-python](https://github.com/asdf-community/asdf-python)
  * [Ruby](https://www.ruby-lang.org/) from [asdf-ruby](https://github.com/asdf-vm/asdf-ruby)
  * [Node.js](https://nodejs.org/) from [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs)
  * [deno](https://deno.com/) from [asdf-deno](https://github.com/asdf-community/asdf-deno)
* Editor: [NeoVim](https://github.com/neovim/neovim)
* Pager: [bat](https://github.com/sharkdp/bat)
* Performance Monitor: [bottom](https://github.com/ClementTsang/bottom)
* Keyboard Mapping: [Karabiner-Elements](https://karabiner-elements.pqrs.org/)

## Installation
```
curl -fsSL https://raw.githubusercontent.com/MasahiroSakoda/dotfiles/main/install.sh | bash
```

## ToDo
See [TODO.md](https://github.com/MasahiroSakoda/dotfiles/blob/main/TODO.md)
