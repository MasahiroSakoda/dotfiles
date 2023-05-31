<div align="center">
  <p>&nbsp;</p>
  <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo-icon.png" height="100px" />

  <h1>dotfiles</h1>
  <img src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" />

  <p>Bootstrap & build macOS development environment</p>

  [![chezmoi][chezmoi-badge]][chezmoi-website]
  [![license][license-badge]][license-file]
  [![commit activity](https://img.shields.io/github/commit-activity/m/MasahiroSakoda/dotfiles)](https://github.com/MasahiroSakoda/dotfiles/graphs/commit-activity)
  <img src="https://img.shields.io/github/repo-size/MasahiroSakoda/dotfiles?style=flat-square&label=Repo" alt="Repo size">

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
* [Getting Started](#getting-started)
* [Usage](#usage)
  * [Configure dotfiles](#configure-dotfiles)
  * [Apply changes](#apply-changes)
  * [Update](#update)
* [Environment](#environment)
  * [Homebrew packages](#homebrew-packages)
    * [fish shell](#fish-shell)
    * [NeoVim](#neovim)
      * [Configured Languages for LSP](#configured-languages-for-lsp)
      * [Configured Languages for DAP](#configured-languages-for-dap)
      * [Configured Linter](#configured-linter)
      * [Configured Formatter](#configured-formatter)
    * [asdf](#asdf)
  * [Homebrew cask packages](#homebrew-cask-packages)
  * [App Store apps](#app-store-apps)
* [ToDo](#todo)

---

## Features

* One Line Install
* dotfiles management using [**`chezmoi`**](https://github.com/twpayne/chezmoi)

## Getting Started

```bash
curl -fsSL https://raw.githubusercontent.com/MasahiroSakoda/dotfiles/main/install.sh | bash
```

## Usage

### Configure dotfiles

```bash
chezmoi edit $DOTFILES
```

### Apply changes

```bash
chezmoi apply
```

### Update

```bash
chezmoi diff
chezmoi update
```

## Environment

### Homebrew packages

| Package | Category         | Notes      |
| ------- | ---------------- | ---------- |
| [**Fish**][fish]    | Shell            |            |
| [**tmux**][tmux]    | Screen           | [~/.config/tmux/tmux.conf][tmux.conf] |
| [**NeoVim**][neovim]  | Editor           | See [Detail](#neovim) |
| [**asdf**][asdf]    | Language version | See [Detail](#asdf) |
| [**fzf**][fzf]     | Fuzzy finder     | [Wiki](https://github.com/junegunn/fzf/wiki)       |
| [**ripgrep**][ripgrep] | `grep` alternative | [User Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md) |
| [**fd**][fd]      | `find` alternative |            |
| [**bat**][bat]     | `cat` alternative  | [~/.config/bat/config][batconfig] |
| [**bottom**][bottom]  | `top` alternative  | [~/.config/bottom/bottom.toml][bottom.toml] |

[fish]: https://github.com/fish-shell/fish-shell
[tmux]: https://github.com/tmux/tmux
[neovim]: https://github.com/neovim/neovim
[asdf]: https://github.com/asdf-vm/asdf
[fzf]: https://github.com/junegunn/fzf
[ripgrep]: https://github.com/BurntSushi/ripgrep
[fd]: https://github.com/sharkdp/fd
[bat]: https://github.com/sharkdp/bat
[bottom]: https://github.com/ClementTsang/bottom

[tmux.conf]: https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/tmux/tmux.conf.tmpl
[batconfig]: https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/bat/config
[bottom.toml]: https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/bottom/bottom.toml

Other Homebrew packages: [**`Brewfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Brewfile.tmpl)

#### fish shell

| Plugin                        | Notes            |
| ----------------------------- | ---------------- |
| [jorgebucaran/fisher](https://github.com/jorgebucaran/fisher)           | A plugin manager for Fish |
| [oh-my-fish/theme-bobthefish](https://github.com/oh-my-fish/theme-bobthefish)   | A Powerline-style, Git-aware fish theme optimized for awesome. |
| [jethrokuan/fzf](https://github.com/jethrokuan/fzf)                | Ef-🐟-ient fish keybindings for fzf |
| [jethrokuan/z](https://github.com/jethrokuan/z)                  | Pure-fish z directory jumping |
| [dracula/fish](https://github.com/dracula/fish)                  | 🧛🏻‍♂️ Dark theme for fish |
| [franciscolourenco/done](https://github.com/franciscolourenco/done)        | A fish-shell package to automatically receive notifications when long processes finish. |
| [jorgebucaran/autopair.fish](https://github.com/jorgebucaran/autopair.fish)    | Auto-complete matching pairs in the Fish command line |

#### NeoVim

<a href="img/NeoVim-mason.nvim.png" target="_blank"><img src="img/NeoVim-mason.nvim.png" align="right" width="450px" /></a>

* [Builtin LSP Supported](#configured-languages-for-lsp)
* [DAP supported](#configured-languages-for-dap) with [**`nvim-dap`**][nvim-dap], [**`nvim-dap-ui`**][nvim-dap-ui]
* [Linter support](#configured-linter)
* [Formatter support](#configured-formatter)
* Snippet support: [**`LuaSnip`**][LuaSnip], [**`friendly-snippets`**][friendly-snippets]
* [Fuzzy Finder](#telescope-extensions): [**`Telescope`**][Telescope]
* [AI Assistant](#ai-assistant) available

[LuaSnip]: https://github.com/L3MON4D3/LuaSnip
[friendly-snippets]: https://github.com/rafamadriz/friendly-snippets
[nvim-dap]: https://github.com/mfussenegger/nvim-dap
[nvim-dap-ui]: https://github.com/rcarriga/nvim-dap-ui
[Telescope]: https://github.com/nvim-telescope/telescope.nvim

Plugin managed by [**`lazy.nvim`**](https://github.com/folke/lazy.nvim)
See also: [Plugin list](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/nvim/lua/plugins/init.lua)

##### Configured Languages for LSP

<a href="img/NeoVim-LSP.png" target="_blank"><img src="img/NeoVim-LSP.png" align="right" width="450px" /></a>

* `Lua`,
* `VimScript`
* `Bash`
* `C`/`C++`,
* `Rust`
* `JavaScript`,
* `TypeScript`
* `JSON`, `YAML`
* `HTML`,
* `CSS`, `SCSS`, `LESS`, `Tailwind CSS`
* `Python`
* `Ruby`
* `SQL`
* `GraphQL`
* `Dockerfile`

<a href="img/NeoVim-DAP.png" target="_blank"><img src="img/NeoVim-DAP.png" align="right" width="450px" /></a>

##### Configured Languages for DAP

* `Lua`: [**`one-small-step-for-vimkind`**][one-small-step-for-vimkind]
* `Python`: [**`nvim-dap-python`**][nvim-dap-python]
* `Go`: [**`nvim-dap-go`**][nvim-dap-go]
* `js`/`ts`: [**`vscode-js-debug`**][vscode-js-debug], [**`nvim-dap-vscode-js`**][nvim-dap-vscode-js]

[one-small-step-for-vimkind]: https://github.com/jbyuki/one-small-step-for-vimkind
[nvim-dap-python]: https://github.com/mfussenegger/nvim-dap-python
[nvim-dap-go]: https://github.com/leoluz/nvim-dap-go
[vscode-js-debug]: https://github.com/microsoft/vscode-js-debug
[nvim-dap-vscode-js]: https://github.com/mxsdev/nvim-dap-vscode-js

##### Configured Linter

| Linter       | Notes                              |
| ------------ | ---------------------------------- |
| [**codespell**][codespell]    | Check code for common misspellings |
| [**hadolint**][hadolint]     | `Dockerfile` linter |
| [**markdownlint**][markdownlint] | `markdown` linter/formatter |
| [**ruff**][ruff]         | Fast `Python` Linter |
| [**rubocop**][rubocop]      | `Ruby` linter/formatter |
| [**vint**][vint]         | `VimScript` linter |
| [**cmakelint**][cmakelint]    | `CMake` linter |

[codespell]: https://github.com/codespell-project/codespell
[hadolint]: https://github.com/hadolint/hadolint
[markdownlint]: https://github.com/igorshubovych/markdownlint-cli
[ruff]: https://github.com/charliermarsh/ruff
[rubocop]: https://rubocop.org
[vint]: https://github.com/Vimjas/vint
[cmakelint]: https://github.com/cmake-lint/cmake-lint

##### Configured Formatter

| Formatter     | Notes                      |
| ------------- | -------------------------- |
| [**beautysh**][beautysh]      | `sh`, `bash`, `zsh` formatter |
| [**black**][black]         | Fast `Python` formatter |
| [**clang-format**][clang-format]  | `C++`formatter |
| [**jq**][jq]            | `JSON` formatter |
| [**prettier**][prettier]      | Opinionated Code Formatter |
| [**rustfmt**][rustfmt]       | `Rust` formatter |
| [**sql-formatter**][sql-formatter] | `SQL` formatter |
| [**stylua**][stylua]        | `Lua` formatter |
| [**xmlformatter**][xmlformatter]  | `XML` formatter |
| [**yamlfmt**][yamlfmt]       | `YAML` formatter |

[beautysh]: https://github.com/lovesegfault/beautysh
[black]: https://pypi.org/project/black/
[clang-format]: https://pypi.org/project/clang-format/
[jq]: https://github.com/stedolan/jq
[prettier]: https://prettier.io
[rustfmt]: https://github.com/rust-lang/rustfmt
[sql-formatter]: https://sql-formatter-org.github.io/sql-formatter/
[stylua]: https://github.com/JohnnyMorganz/StyLua
[xmlformatter]: https://github.com/pamoller/xmlformatter
[yamlfmt]: https://github.com/google/yamlfmt

##### Telescope extensions

<a href="img/NeoVim-telescope.nvim.png" target="_blank"><img src="img/NeoVim-telescope.nvim.png" align="right" width="450px" /></a>

* [**telescope-frecency**][telescope-frecency]: [`Frecency algorithm`](https://web.archive.org/web/20210421120120/https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places/Frecency_algorithm) search
* [**telescope-file-browser**][telescope-file-browser]: File Browser
* [**telescope-lazy**][telescope-lazy]: [`lazy.nvim`](https://github.com/folke/lazy.nvim) extension
* [**telescope-tabs**][telescope-tabs]: Tab extension
* [**telescope-dap**][telescope-dap]: DAP Extension

[telescope-frecency]: https://github.com/nvim-telescope/telescope-frecency.nvim
[telescope-file-browser]: https://github.com/nvim-telescope/telescope-file-browser.nvim
[telescope-lazy]: https://github.com/tsakirist/telescope-lazy.nvim
[telescope-tabs]: https://github.com/LukasPietzschmann/telescope-tabs
[telescope-dap]: https://github.com/nvim-telescope/telescope-dap.nvim

##### AI Assistant

* [**ChatGPT.nvim**](https://github.com/jackMort/ChatGPT.nvim)
* [**neoai.nvim**](https://github.com/Bryley/neoai.nvim)

#### asdf

Programming language version management tool

* [**`asdf-python`**](https://github.com/asdf-community/asdf-python)
  * [`Poetry`](https://github.com/python-poetry/poetry)
* [**`asdf-ruby`**](https://github.com/asdf-vm/asdf-ruby)
* [**`asdf-nodejs`**](https://github.com/asdf-vm/asdf-nodejs)
* [**`asdf-deno`**](https://github.com/asdf-community/asdf-deno)

### Homebrew cask packages

#### Keyboard

| Package             | Configuration files |
| ------------------- | ------------------- |
| [**Karabiner-Elements**][karabiner-elements]  | [~/.config/karabiner](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/private_karabiner) |
| [**Hammerspoon**][hammerspoon]         | [~/.hammerspoon](https://github.com/MasahiroSakoda/dotfiles/tree/main/home/dot_hammerspoon)      |

[karabiner-elements]: https://karabiner-elements.pqrs.org/
[hammerspoon]: https://www.hammerspoon.org/

#### Fonts

| Package                        | Notes                           |
| ------------------------------ | ------------------------------- |
| [**font-codicon**][codicon]                   | Icon Font                       |
| [**font-hack-nerd-font**][hack-nerd-font]            | Nerd Font                       |
| [**font-jetbrains-mono-nerd-font**][jetbrains-mono-nerd-font]  | Open Source Font                |
| [**font-cica**][cica]                      | Monospaced Font for Japanese    |
| [**font-hackgen**][hackgen]                   | Programming Font for Japanese   |
| [**font-hackgen-nerd**][hackgen]              | Programming Font for Japanese   |
| [**font-plemol-jp-nf**][plemoljp]              | IBM Plex base Font for Japanese |
| [**font-plemol-jp-nfj**][plemoljp]             | IBM Plex base Font for Japanese |

[codicon]: https://github.com/microsoft/vscode-codicons
[hack-nerd-font]: https://github.com/ryanoasis/nerd-fonts
[jetbrains-mono-nerd-font]: https://www.jetbrains.com/ja-jp/lp/mono/
[cica]: https://github.com/miiton/Cica
[hackgen]: https://github.com/yuru7/HackGen
[plemoljp]: https://github.com/yuru7/PlemolJP

#### Dev packages

| Package            | Category   |
| ------------------ | ---------- |
| [**iTerm2**][iterm2]             | Terminal   |
| [**Alacritty**][alacritty]          | Terminal |
| [**Visual Studio Code**][vscode] | IDE        |
| [**Docker**][docker]             | Container  |
| [**TablePlus**][tableplus]          | Database   |
| [**drawio**][drawio]             | Diagram    |
| [**wireshark-chmodbpf**][wireshark] | Network    |
| [**TunnelBear**][tunnelbear]         | VPN        |

[iTerm2]: https://iterm2.com/
[alacritty]: https://github.com/alacritty/alacritty
[vscode]: https://code.visualstudio.com/
[docker]: https://www.docker.com/
[tableplus]: https://tableplus.com/
[drawio]: https://www.drawio.com/
[wireshark]: https://www.wireshark.org/
[tunnelbear]: https://www.tunnelbear.com/

Other Homebrew cask packages: [**`Caskfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Caskfile.tmpl)

### App Store apps

See [**`Masfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Masfile.tmpl)

## ToDo

* [ ] Fix script attributes in [**`.chezmoiscripts`**](https://github.com/MasahiroSakoda/dotfiles/tree/main/home/.chezmoiscripts)
* [ ] VSCode support
* [ ] Cross platform support
* [ ] activate switching for personal/work usage
