# dotfiles
Bootstrap scripts & build macOS development environment

## Features
* One Line Install
* dotfile management using chezmoi
* asdf version management
* LSP & DAP Configuration for NeoVim

## Components
* Shell: [Fish](https://github.com/fish-shell/fish-shell)
* Package Management: [Homebrew](https://brew.sh)
  * [Brewfile](https://github.com/MasahiroSakoda/dotfiles/tree/main/dot_config/homebrew/Brewfile.tmpl)
  * [Caskfile](https://github.com/MasahiroSakoda/dotfiles/tree/main/dot_config/homebrew/Caskfile.tmpl)
  * [Masfile](https://github.com/MasahiroSakoda/dotfiles/tree/main/dot_config/homebrew/Masfile)
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
curl -fsSL https://raw.githubusercontent.com/MasahiroSakoda/dotfiles/master/install.sh | bash
```

## ToDo
See [TODO.md](https://github.com/MasahiroSakoda/dotfiles/blob/main/TODO.md)
