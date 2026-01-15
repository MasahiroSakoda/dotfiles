# dotfiles

<div align="center">
  <p>&nbsp;</p>
  <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo-icon.png" height="100px" alt="dotfiles" />

  <h2>dotfiles</h2>
  <img src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" alt="macOS-badge" />
  <img src="https://img.shields.io/badge/Linux%20-yellow.svg?style=flat-square&logo=linux&logoColor=black" alt="Linux-badge" />

  <p>multi-platform dotfiles powered by chezmoi</p>

  [![chezmoi][chezmoi-badge]][chezmoi-web]
  [![license][license-badge]][license-file]
  [![commit activity](https://img.shields.io/github/commit-activity/m/MasahiroSakoda/dotfiles)](https://github.com/MasahiroSakoda/dotfiles/graphs/commit-activity)
  <img src="https://img.shields.io/github/repo-size/MasahiroSakoda/dotfiles?style=flat-square&label=Repo" alt="Repo size">

  [chezmoi-web]:   https://github.com/twpayne/chezmoi
  [chezmoi-badge]: https://img.shields.io/badge/Powered%20by-chezmoi-blue.svg
  [license-badge]: https://img.shields.io/github/license/MasahiroSakoda/dotfiles
  [license-file]:  https://github.com/MasahiroSakoda/dotfiles/blob/main/LICENSE

  [![linter](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/linter.yml/badge.svg)](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/linter.yml)
  [![ci](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/ci.yml/badge.svg?event=pull_request)](https://github.com/MasahiroSakoda/dotfiles/actions/workflows/ci.yml)
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
      * [LSP](#lsp)
      * [DAP](#dap)
      * [Linter](#linter)
      * [Formatter](#formatter)
    * [mise](#mise)
  * [Homebrew cask packages](#homebrew-cask-packages)
  * [App Store apps](#app-store-apps)

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

| Package | Category | Notes |
| :------ | :------- | :---- |
| [**Fish**](https://github.com/fish-shell/fish-shell) | Shell | |
| [**starship**](https://starship.rs/) | Prompt | |
| [**tmux**](https://github.com/tmux/tmux) | Screen | See [Detail](#tmux) |
| [**zellij**](https://github.com/zellij-org/zellij) | Screen | See [Detail](#zellij) |
| [**NeoVim**](https://github.com/neovim/neovim) | Editor | See [Detail](#neovim) |
| [**mise**](https://github.com/jdx/mise) | Version Control | See [Detail](#mise) |
| [**fzf**](https://github.com/junegunn/fzf) | Fuzzy finder | [Wiki](https://github.com/junegunn/fzf/wiki) |
| [**ripgrep**](https://github.com/BurntSushi/ripgrep) | `grep` alternative | [User Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md) |
| [**fd**](https://github.com/sharkdp/fd) | `find` alternative | |
| [**bat**](https://github.com/sharkdp/bat) | `cat` alternative | [config](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/bat/config) |
| [**bottom**](https://github.com/ClementTsang/bottom) | `top` alternative | [bottom.toml](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/bottom/bottom.toml) |

Other Homebrew packages: [**`Brewfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Brewfile.tmpl)

#### fish shell

| Plugin | Notes |
| :----- | :---- |
| [fisher](https://github.com/jorgebucaran/fisher) | A plugin manager for Fish |
| [fzf](https://github.com/jethrokuan/fzf) | Ef-🐟-ient fish keybindings for fzf |
| [z](https://github.com/jethrokuan/z) | Pure-fish z directory jumping |
| [dracula](https://github.com/dracula/fish) | 🧛🏻‍♂️ Dark theme for fish |
| [autopair.fish](https://github.com/jorgebucaran/autopair.fish) | Auto-complete matching pairs in the Fish command line |
| [done](https://github.com/franciscolourenco/done) | A notifier for fish process |
| [bass](https://github.com/edc/bass) | Make Bash utilities usable in fish shell |
| [sponge](https://github.com/meaningful-ooo/sponge) | cleean typos from history |

#### Terminal

##### Tmux
- [`tmux-plugins/tpm`](https://github.com/tmux-plugins/tpm)
- [`tmux-plugins/tmux-logging`](https://github.com/tmux-plugins/tmux-logging)
- [`tmux-plugins/tmux-sensible`](https://github.com/tmux-plugins/tmux-sensible)
- [`tmux-plugins/tmux-resurrect`](https://github.com/tmux-plugins/tmux-resurrect)
- [`tmux-plugins/tmux-continuum`](https://github.com/tmux-plugins/tmux-continuum)
- [`tmux-plugins/tmux-pain-control`](https://github.com/tmux-plugins/tmux-pain-control)
- [`tmux-plugins/tmux-open`](https://github.com/tmux-plugins/tmux-open)
- [`fabioluciano/tmux-powerkit`](https://github.com/fabioluciano/tmux-powerkit)

##### Zellij
- [`imsnif/multitask`](https://github.com/imsnif/multitask)
- [`fresh2dev/zellij-autolock`](https://github.com/fresh2dev/zellij-autolock)
- [`dj95/zjstatus`](https://github.com/dj95/zjstatus)
- [`dj95/zjframes`](https://github.com/dj95/zjstatus)
- [`b0o/zjstatus-hints`](https:/github.com/b0o/zjstatus-hints)
- [`hiasr/vim-zellij-navigator`](https://github.com/hiasr/vim-zellij-navigator)

#### NeoVim

* [Builtin LSP Supported](#lsp)
* [DAP supported](#dap) with [**`nvim-dap`**](https://github.com/mfussenegger/nvim-dap), [**`nvim-dap-ui`**](https://github.com/rcarriga/nvim-dap-ui)
* Addtional completion with [blink.cmp](https://github.com/saghen/blink.cmp)
* [Linter support](#linter)
* [Formatter support](#formatter)
* Snippet support: [**`LuaSnip`**](https://github.com/L3MON4D3/LuaSnip), [**`friendly-snippets`**](https://github.com/rafamadriz/friendly-snippets)
* Fuzzy Finder: [**`Snacks.picker`**](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
* [AI Assistant](#ai-assistant) available

![NeoVim-mason nvim](https://github.com/MasahiroSakoda/dotfiles/assets/1011488/702a2de8-1264-4688-87b0-d682f2441b98)

Plugin managed by [**`lazy.nvim`**](https://github.com/folke/lazy.nvim)
See also: [Plugin list](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/nvim/lua/plugins/init.lua)

##### LSP

| Language Server | Language |
| :-------------- | :------- |
| [**copilot-language-server**](https://github.com/orgs/github/packages/npm/package/copilot-language-server) | Next Edit Suggestions |
| [**bash-language-server**](https://github.com/bash-lsp/bash-language-server) | Bash |
| [**clangd**](https://clangd.llvm.org) | C/C++ |
| [**rust-analyzer**](https://github.com/rust-lang/rust-analyzer) | Rust |
| [**gopls**](https://pkg.go.dev/golang.org/x/tools/gopls) | Go |
| [**pyright**](https://github.com/microsoft/pyright) | Python |
| [**ruby-lsp**](https://github.com/Shopify/ruby-lsp) | Ruby |
| [**deno**](https://deno.land) | JS / TS |
| [**ts_ls**](https://github.com/typescript-language-server/typescript-language-server) | JS / TS |
| [**lua_ls**](https://github.com/LuaLS/lua-language-server) | Lua |
| [**html-lsp**](https://github.com/microsoft/vscode-html-languageservice) | HTML |
| [**css-lsp**](https://github.com/microsoft/vscode-css-languageservice) | CSS, SCSS, LESS |
| [**json-lsp**](https://github.com/microsoft/vscode-json-languageservice) | JSON |
| [**yaml-language-server**](https://github.com/redhat-developer/yaml-language-server) | YAML |
| [**graphql-language-service**](https://www.npmjs.com/package/graphql-language-service-cli) | GraphQL |
| [**dockerfile-language-server**](https://github.com/rcjsuen/dockerfile-language-server-nodejs) | Dockerfile |
| [**terraform-ls**](https://github.com/hashicorp/terraform-ls) | Terraform |
| [**Marksman**](https://github.com/artempyanykh/marksman) | Markdown |
| [**texlab**](https://github.com/latex-lsp/texlab) | LaTex |

![NeoVim-LSP](https://github.com/MasahiroSakoda/dotfiles/assets/1011488/d20f648c-f520-485c-ad2b-3762ee60dfc1)

##### DAP

| Adapter | Language |
| :------ | :------- |
| [**codelldb**](https://github.com/vadimcn/vscode-lldb) | C/C++, Rust |
| [**delve**](https://github.com/go-delve/delve) | Go |
| [**debugpy**](https://github.com/microsoft/debugpy) | Python |
| [**js-debug-adapter**](https://github.com/microsoft/vscode-js-debug) | Javascript/TyptScript |

![NeoVim-DAP](https://github.com/MasahiroSakoda/dotfiles/assets/1011488/91de198d-993f-437c-a5dd-5fe52091924e)

##### Linter

| Linter | Notes |
| :----- | :---- |
| [**typos**](https://github.com/crate-ci/typos) | Source code spell checker |
| [**golangci-lint**](https://golangci-lint.run) | Go linters aggregator |
| [**ruff-lsp**](https://github.com/astral-sh/ruff-lsp/) | Python Linter/Formatter |
| [**rubocop**](https://rubocop.org) | Ruby linter/formatter |
| [**vint**](https://github.com/Vimjas/vint) | `VimScript` linter |
| [**sqruff**](https://github.com/quarylabs/sqruff) | SQL Linter |
| [**biome**](https://github.com/biomejs/biome) | `eslint` & `prettier` alternative |
| [**hadolint**](https://github.com/hadolint/hadolint) | `Dockerfile` linter |
| [**markdownlint**](https://github.com/igorshubovych/markdownlint-cli) | `markdown` linter/formatter |

##### Formatter

| Formatter | Notes |
| :-------- | :---- |
| [**clang-format**](https://pypi.org/project/clang-format/) | `C++`formatter |
| [**jq**](https://github.com/stedolan/jq) | `JSON` formatter |
| [**yq**](https://github.com/mikefarah/yq) | `YAML` formatter |
| [**sql-formatter**](https://sql-formatter-org.github.io/sql-formatter/) | `SQL` formatter |
| [**stylua**](https://github.com/JohnnyMorganz/StyLua) | `Lua` formatter |
| [**yamlfmt**](https://github.com/google/yamlfmt) | `YAML` formatter |

##### AI Assistant

| Plugin | Notes |
| :----- | :---- |
| [**sidekick.nvim**](https://github.com/folke/sidekick.nvim) | Agent Integration & Next Edit Suggestion via Copilot |


#### mise

Runtime version management tool

`.tool-versions` used by `asdf` is deactivated to prevent confliction & confusion.

global language environment predefined in [**`.chezmoidata.toml`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/.chezmoidata.toml)

| File | Usage |
| :--- | :---- |
| [**`~/.config/mise/settings.toml`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/mise/settings.toml.tmpl) | System settings |
| [**`~/.config/mise/config.toml`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/mise/config.toml.tmpl) | Global config |
| `.mise.toml` | Local config |

##### configured tools

| Runtime | Version |
| :------ | :------ |
| [**`Go`**](https://mise.jdx.dev/lang/go.html) | latest |
| [**`Python`**](https://mise.jdx.dev/lang/python.html) | 3.14.x |
| [**`Ruby`**](https://mise.jdx.dev/lang/ruby.html) | 3.4.x |
| [**`Node.js`**](https://mise.jdx.dev/lang/node.html) | 24.x |
| [**`Deno`**](https://mise.jdx.dev/lang/deno.html) | 2.x |
| [**`Bun`**](https://mise.jdx.dev/lang/bun.html) | 1.x |


#### AI Tools

| Tool | Description |
|:-----|:------------|
| [`**OpenCode**`](https://opencode.ai) | Open Source AI Agent  |
| [`**superpowers**`](https://github.com/obra/superpowers) | Core skills library |
| [`**Awesome Claude Code Subagents**`](https://github.com/VoltAgent/awesome-claude-code-subagents) | The awesome collection of Claude Code subagents. |


### Homebrew cask packages

#### Keyboard

| Package | Configuration files |
| :------ | :------------------ |
| [**Karabiner-Elements**](https://karabiner-elements.pqrs.org/) | [~/.config/karabiner](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/private_karabiner) |

#### Fonts

| Package | Notes |
| :------ | :---- |
| [**font-jetbrains-mono-nerd-font**](https://www.jetbrains.com/ja-jp/mono/) | Open Source Font |
| [**font-plemol-jp-nf**](https://github.com/yuru7/PlemolJP) | IBM Plex Mono + IBM Plex Sans JP |
| [**font-udev-gothic-nf**](https://github.com/yuru7/udev-gothic) | BIZ UD Gothic + JetBrains Mono |

#### Dev packages

| Package | Category |
| :------ | :------- |
| [**wezterm**](https://github.com/wez/wezterm) | Terminal |
| [**Ghostty**](https://github.com/ghostty-org/ghostty) | Terminal |
| [**Visual Studio Code**](https://code.visualstudio.com/) | IDE |
| [**Docker**](https://www.docker.com/) | Container |
| [**TablePlus**](https://tableplus.com/) | Database |
| [**drawio**](https://www.drawio.com/) | Diagram |
| [**termshark**](https://github.com/gcla/termshark) | Network |
| [**TunnelBear**](https://www.tunnelbear.com/) | VPN |

Other Homebrew cask packages: [**`Caskfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Caskfile.tmpl)

### App Store apps

See [**`Masfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Masfile.tmpl)
