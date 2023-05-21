<div align="center">
  <p>&nbsp;</p>

  <img
    src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo-icon.png"
    height="100px"
  />

  <h1>dotfiles</h1>
  <img src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" />
  <p>Bootstrap & build macOS development environment</p>

  [![chezmoi][chezmoi-badge]][chezmoi-website]
  [![license][license-badge]][license-file]
  [![commit activity](https://img.shields.io/github/commit-activity/m/MasahiroSakoda/dotfiles)](https://github.com/MasahiroSakoda/dotfiles/graphs/commit-activity)

  [chezmoi-website]: https://github.com/twpayne/chezmoi
  [chezmoi-badge]: https://img.shields.io/badge/Powered%20by-chezmoi-blue.svg
  [license-badge]: https://img.shields.io/github/license/MasahiroSakoda/dotfiles
  [license-file]: https://github.com/MasahiroSakoda/dotfiles/blob/main/LICENSE

  [![Codacy Security Scan](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/codacy.yml/badge.svg)](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/codacy.yml)
  [![ci](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/ci.yml)
  [![lint](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/lint.yml)
</div>

---

## Contents
* [Features](#features)
* [Environment](#Environment)
* [Installation](#Installation)
* [ToDo](#ToDo)

## Features
* [One Line Install](#Installation)
* dotfiles management using [chezmoi](https://github.com/twpayne/chezmoi)

## Environment
#### Shell: [Fish](https://github.com/fish-shell/fish-shell)
* Support [fzf](https://github.com/junegunn/fzf)

#### Package Management: [Homebrew](https://brew.sh)
* [Brewfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/homebrew/Brewfile.tmpl)
* [Caskfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/homebrew/Caskfile.tmpl)
* AppStore app: [Masfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/homebrew/Masfile)

#### Source Version Management: [Git](https://github.com/git/git)

#### Language Version Management: [asdf](https://github.com/asdf-vm/asdf)
* [Python](https://www.python.org/) from [asdf-python](https://github.com/asdf-community/asdf-python)
* [Ruby](https://www.ruby-lang.org/) from [asdf-ruby](https://github.com/asdf-vm/asdf-ruby)
* [Node.js](https://nodejs.org/) from [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs)
* [deno](https://deno.com/) from [asdf-deno](https://github.com/asdf-community/asdf-deno)

#### Editor: [NeoVim](https://github.com/neovim/neovim)
* Builtin LSP via [mason.nvim](https://github.com/williamboman/mason.nvim)
* DAP via [nvim-dap](https://github.com/mfussenegger/nvim-dap)
* Support snippet
* Fuzzy Finder: [Telescope](https://github.com/nvim-telescope/telescope.nvim)
* AI Assistant: [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim), [neoai.nvim](https://github.com/Bryley/neoai.nvim)

[Plugin list](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/nvim/lua/plugins/init.lua)

#### Pager: [bat](https://github.com/sharkdp/bat)

#### Performance Monitor: [bottom](https://github.com/ClementTsang/bottom)

#### Keyboard Mapping: [Karabiner-Elements](https://karabiner-elements.pqrs.org/)

## Installation
```
curl -fsSL https://raw.githubusercontent.com/MasahiroSakoda/dotfiles/main/install.sh | bash
```

## ToDo
* [ ] VSCode support
* [ ] Cross platform support
* [ ] activate switching for personal/work usage
