<div align="center">
  <p>&nbsp;</p>
  <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo-icon.png" height="100px" />

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

## Table of Contents
* [Features](#features)
* [Getting Started](#Getting-Started)
* [Usage](#Usage)
  * [Configure dotfiles](#Configure-dotfiles)
  * [Apply changes](#Apply-changes)
  * [Update](#Update)
* [Environment](#Environment)
  * [Homebrew packages](#Homebrew-packages)
    * [NeoVim](#NeoVim)
    * [asdf](#asdf)
  * [Homebrew cask packages](#Homebrew-cask-packages)
  * [App Store apps](#App-Store-apps)
* [ToDo](#ToDo)

---

## Features
* One Line Install
* dotfiles management using [chezmoi](https://github.com/twpayne/chezmoi)

## Getting Started
```bash
$ curl -fsSL https://raw.githubusercontent.com/MasahiroSakoda/dotfiles/main/install.sh | bash
```

## Usage

### Configure dotfiles
```bash
$ chezmoi edit $DOTFILES
```

### Apply changes
```bash
$ chezmoi apply
```

### Update
```bash
$ chezmoi diff
$ chezmoi update
```

## Environment

### Homebrew packages
| Package | Category         | Notes      |
| ------- | ---------------- | ---------- |
| [Fish](https://github.com/fish-shell/fish-shell)    | Shell            |            |
| [NeoVim](https://github.com/neovim/neovim)  | Editor           | See [Detail](#NeoVim) |
| [asdf](https://github.com/asdf-vm/asdf)    | Language version | See [Detail](#asdf) |
| [fzf](https://github.com/junegunn/fzf)     | Fuzzy finder     | [Wiki](https://github.com/junegunn/fzf/wiki)       |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` alternative | [User Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md) |
| [fd](https://github.com/sharkdp/fd)      | `find` alternative |            |
| [bat](https://github.com/sharkdp/bat)     | stdio            | [~/.config/bat/config](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/bat/config) |
| [bottom](https://github.com/ClementTsang/bottom)  | `top` alternative  | [~/.config/bottom/bottom.toml](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/bottom/bottom.toml) |

Other Homebrew packages: [Brewfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/homebrew/Brewfile.tmpl)

#### NeoVim
[Plugin list](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/nvim/lua/plugins/init.lua)

* Plugin managed by [`lazy.nvim`](https://github.com/folke/lazy.nvim)
* Builtin LSP with [`mason.nvim`](https://github.com/williamboman/mason.nvim), [`mason-lspconfig`](https://github.com/williamboman/mason-lspconfig.nvim), [`null-ls.nvim`](https://github.com/jose-elias-alvarez/null-ls.nvim)
  * `Lua`, `VimScript`
  * `Bash`
  * `C`, `C++`, `Rust`
  * `JavaScript`, `TypeScript`
  * `JSON`, `YAML`
  * `HTML`, `CSS`, `SCSS`, `LESS`, `Tailwind CSS`
  * `Python`
  * `Ruby`
  * `SQL`
  * `GraphQL`
  * `Dockerfile`
* DAP with [`nvim-dap`](https://github.com/mfussenegger/nvim-dap), [`nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui)
  * `Lua`: [`one-small-step-for-vimkind`](https://github.com/jbyuki/one-small-step-for-vimkind)
  * `Python`: [`nvim-dap-python`](https://github.com/mfussenegger/nvim-dap-python)
  * `Go`: [`nvim-dap-go`](https://github.com/leoluz/nvim-dap-go)
  * `JavaScript`/`TypeScript`: [`vscode-js-debug`](https://github.com/microsoft/vscode-js-debug), [`nvim-dap-vscode-js`](https://github.com/mxsdev/nvim-dap-vscode-js)
* Linter support
  * [codespell](https://github.com/codespell-project/codespell): Check code for common misspellings
  * [hadolint](https://github.com/hadolint/hadolint): `Dockerfile` linter
  * [markdownlint](https://github.com/igorshubovych/markdownlint-cli): `markdown` linter/formatter
  * [ruff](https://github.com/charliermarsh/ruff/): Fast `Python` Linter
  * [rubocop](https://rubocop.org): `Ruby` linter/formatter
  * [vint](https://github.com/Vimjas/vint): `VimScript` linter
  * [cmakelint](https://github.com/cmake-lint/cmake-lint): `CMake` linter
* Formatter support
  * [beautysh](https://github.com/lovesegfault/beautysh): `sh`, `bash`, `zsh` formatter
  * [black](https://pypi.org/project/black/): Fast `Python` formatter
  * [clang-format](https://pypi.org/project/clang-format/):
  * [jq](https://github.com/stedolan/jq): `JSON` formatter
  * [prettier](https://prettier.io)
  * [rustfmt](https://github.com/rust-lang/rustfmt): `Rust` formatter
  * [sql-formatter](https://sql-formatter-org.github.io/sql-formatter/): `SQL` formatter
  * [stylua](https://github.com/JohnnyMorganz/StyLua): `Lua` formatter
  * [xmlformatter](https://github.com/pamoller/xmlformatter): `XML` formatter
  * [yamlfmt](https://github.com/google/yamlfmt): `YAML` formatter
* Snippet support: [`LuaSnip`](https://github.com/L3MON4D3/LuaSnip), [`friendly-snippets`](https://github.com/rafamadriz/friendly-snippets)
* Fuzzy Finder: [Telescope](https://github.com/nvim-telescope/telescope.nvim)
  * [telescope-frecency](https://github.com/nvim-telescope/telescope-frecency.nvim)
  * [telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)
  * [telescope-lazy](https://github.com/tsakirist/telescope-lazy.nvim)
  * [telescope-tabs](https://github.com/LukasPietzschmann/telescope-tabs)
  * [telescope-dap](https://github.com/nvim-telescope/telescope-dap.nvim)
* AI Assistants
  * [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim)
  * [neoai.nvim](https://github.com/Bryley/neoai.nvim)

#### asdf
Programming language version management tool
* [`asdf-python`](https://github.com/asdf-community/asdf-python)
  * [`Poetry`](https://github.com/python-poetry/poetry)
* [`asdf-ruby`](https://github.com/asdf-vm/asdf-ruby)
* [`asdf-nodejs`](https://github.com/asdf-vm/asdf-nodejs)
* [`asdf-deno`](https://github.com/asdf-community/asdf-deno)

### Homebrew cask packages
| Package            | Category               | Configuration file |
| ------------------ | ---------------------- | ------------------ |
| [Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements) | Keyboard customization | [~/.config/karabiner](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/private_karabiner) |
| [yabai](https://github.com/koekeishiya/yabai)              | Window Manager         | [~/.config/yabai/yabairc](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/yabai/yabairc) |
| [skhd](https://github.com/koekeishiya/skhd)               | Hotkey daemon          | [~/.config/skhd/skhdrc](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/skhd/skhdrc) |
| [sketchybar](https://github.com/FelixKratz/SketchyBar)         | Status bar             | [~/.config/sketchybar/sketchybarrc](https://github.com/MasahiroSakoda/dotfiles/blob/main/dot_config/sketchybar/sketchybarrc) |

Other Homebrew cask packages: [Caskfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/homebrew/Caskfile.tmpl)

### App Store apps
See [Masfile](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/homebrew/Masfile.tmpl)

## ToDo
* [ ] Fix script attributes in `.chezmoiscripts`
* [ ] VSCode support
* [ ] Cross platform support
* [ ] activate switching for personal/work usage
