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
| [**mise**](https://github.com/jdx/mise) | Version Control | See [Detail](#mise) |

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

##### Zellij
- [`imsnif/multitask`](https://github.com/imsnif/multitask)
- [`fresh2dev/zellij-autolock`](https://github.com/fresh2dev/zellij-autolock)
- [`dj95/zjstatus`](https://github.com/dj95/zjstatus)
- [`dj95/zjframes`](https://github.com/dj95/zjstatus)
- [`b0o/zjstatus-hints`](https:/github.com/b0o/zjstatus-hints)

#### NeoVim

* [Builtin LSP Supported](#lsp)
* [DAP supported](#dap) with [**`nvim-dap`**](https://github.com/mfussenegger/nvim-dap), [**`nvim-dap-view`**](https://github.com/igorlfs/nvim-dap-view)
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
| [**bash-language-server**](https://github.com/bash-lsp/bash-language-server) | Bash |
| [**fish-lsp**](https://github.com/ndonfris/fish-lsp) | Fish |
| [**clangd**](https://clangd.llvm.org) | C/C++ |
| [**rust-analyzer**](https://github.com/rust-lang/rust-analyzer) | Rust |
| [**gopls**](https://pkg.go.dev/golang.org/x/tools/gopls) | Go |
| [**pyright**](https://github.com/microsoft/pyright) | Python |
| [**just**](https://github.com/terror/just-lsp) | Justfile |
| [**ruby-lsp**](https://github.com/Shopify/ruby-lsp) | Ruby |
| [**deno**](https://deno.land) | JS / TS |
| [**ts_ls**](https://github.com/typescript-language-server/typescript-language-server) | JS / TS |
| [**lua_ls**](https://github.com/LuaLS/lua-language-server) | Lua |
| [**json-lsp**](https://github.com/microsoft/vscode-json-languageservice) | JSON |
| [**yaml-language-server**](https://github.com/redhat-developer/yaml-language-server) | YAML |
| [**tailwindcss-language-server**](https://github.com/tailwindlabs/tailwindcss-intellisense) | Tailwind CSS |
| [**dockerfile-language-server**](https://github.com/rcjsuen/dockerfile-language-server-nodejs) | Dockerfile |
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
| [**rubocop**](https://rubocop.org) | Ruby linter/formatter |
| [**sqruff**](https://github.com/quarylabs/sqruff) | SQL Linter |
| [**markdownlint**](https://github.com/igorshubovych/markdownlint-cli) | `markdown` linter/formatter |

##### Formatter

| Formatter | Notes |
| :-------- | :---- |
| [**clang-format**](https://pypi.org/project/clang-format/) | `C++`formatter |
| [**sql-formatter**](https://sql-formatter-org.github.io/sql-formatter/) | `SQL` formatter |

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

##### Configured Languages & Runtime

| Runtime | Version |
| :------ | :------ |
| [**`Go`**](https://mise.jdx.dev/lang/go.html) | latest |
| [**`Python`**](https://mise.jdx.dev/lang/python.html) | 3.14.x |
| [**`Ruby`**](https://mise.jdx.dev/lang/ruby.html) | 3.4.x |
| [**`Node.js`**](https://mise.jdx.dev/lang/node.html) | 24.x |
| [**`Deno`**](https://mise.jdx.dev/lang/deno.html) | 2.x |
| [**`Bun`**](https://mise.jdx.dev/lang/bun.html) | 1.x |

##### CLI Tools

| Tools | Description |
|:------|:------------|
| [**`zellij`**](https://github.com/zellij-org/zellij) | Terminal Multiplexer |
| [**`starship`**](https://github.com/starship/starship) | Shell prompt |
| [**`sheldon`**](https://github.com/rossmacarthur/sheldon) | Shell plugin manager |
| [**`neovim`**](https://github.com/neovim/neovim) | Hyper extensive editor |
| [**`tree-sitter`**](https://github.com/tree-sitter/tree-sitter) | Language Parser |
| [**`cmake`**](https://github.com/Kitware/Cmake) | Build system generator |
| [**`just`**](https://github.com/casey/just) | Just a command runner |
| [**`zoxide`**](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` command |
| [**`bat`**](https://github.com/sharkdp/bat) | `cat` alternative |
| [**`fd`**](https://github.com/sharkdp/fd) | `find` alternative |
| [**`ripgrep`**](https://github.com/BurntSushi/ripgrep) | `grep` alternative |
| [**`ripgrep-all`**](https://github.com/phiresky/ripgrep-all) | extended `rg` for docs, image, movies |
| [**`fzf`**](https://github.com/junegunn/fzf) | Fuzzy Finder |
| [**`bottom`**](https://github.com/ClementTsang/bottom) | Process Monitor |
| [**`watchexec`**](https://github.com/watchexec/watchexec) | Modify detector |
| [**`dua`**](https://github.com/ClementTsang/bottom) | Disk Usage |
| [**`yazi`**](https://github.com/sxyazi/yazi) | Modern TUI Explorer |
| [**`hyperfine`**](https://github.com/sharkdp/hyperfine) | Benchmark Tool |
| [**`genact`**](https://github.com/svenstaro/genact) | nonsense activity generator |
| [**`tealdeer`**](https://github.com/tealdeer-rs/tealdeer) | TL; DR |
| [**`yt-dlp`**](https://github.com/yt-dlp/yt-dlp) | Downloader |
| [**`onefetch`**](https://github.com/o2sh/onefetch) | Repository information |
| [**`gitui`**](https://github.com/gitui-org/gitui) | Git TUI |
| [**`delta`**](https://github.com/dandavison/delta) | `diff` alternavtive for `git` |
| [**`pre-commit`**](https://github.com/pre-commit/pre-commit) | pre-commit hook |
| [**`git-cliff`**](https://github.com/orhun/git-cliff) | Changelog generator |
| [**`gibo`**](https://github.com/simonwhitaker/gibo) | `.gitignore` boilerplates |
| [**`commitizen`**](https://github.com/) | Commit message utiility |
| [**`cz-conventional-changelog`**](https://github.com/) | Formatter |
| [**`gh`**](https://github.com/cli/cli) | GitHub CLI |
| [**`ghq`**](https://github.com/x-motemen/ghq) | Git secret detector |
| [**`pinact`**](https://github.com/suzuki-shunsuke/pinact) | Version pinner for GitHub Actions |
| [**`chezmoi`**](https://github.com/twpayne/chezmoi) | Dotfiles manager |
| [**`gitleaks`**](https://github.com/gitleaks/gitleaks) | Git secret detector |
| [**`age`**](https://github.com/FiloSottile/age) | Simple encrypt / decrypt tool |
| [**`lima`**](https://github.com/lima-vm/lima) | Docker alternative |
| [**`colima`**](https://github.com/abisoft/colima) | Lightweight `lima` frontend |
| [**`docker`**](https://github.com/docker/cli) | Docker CLI |
| [**`buildx`**](https://github.com/docker/buildx) | Extended build capabilities with BuildKit |
| [**`compose`**](https://github.com/docker/compose) | multi-container interface with Docker |
| [**`dive`**](https://github.com/wagoodman/dive) | Exploring each layer in a docker image |
| [**`lazydocker`**](https://github.com/jesseduffield/lazydocker) | TUI tool for `docker` |
| [**`ollama`**](https://github.com/ollama/ollama) | llama.cpp frontend |
| [**`opencode`**](https://github.com/anomalco/opencode) | Coding agent supports multi-provider |
| [**`gemini-cli`**](https://github.com/google-gemini/gemini-cli) | Coding Agent powered by Gemini |

##### Linter / Formatter

| Tools | Description |
|:------|:------------|
| [**`shfmt`**](https://github.com/mvdan/sh) | Shell Formatter |
| [**`biome`**](https://github.com/biomejs/biome) | ESLint & Prettier replacement |
| [**`ruff`**](https://github.com/astral-sh/ruff) | Python Linter / Formatter |
| [**`tombi`**](https://github.com/tombi-toml/tombi) | TOML Linter / Formatter / Language Server |
| [**`yamlfmt`**](https://github.com/google/yamlfmt) | YAML Formatter |
| [**`actionlint`**](https://github.com/rhysd/actionlint) | YAML Linter for GitHub Actions workflows |
| [**`hadolint`**](https://github.com/hadolint/hadolint) | Dockerfile Linter |
| [**`golangci-lint`**](https://github.com/golangci/golangci-lint) | Go Linter aggregator |
| [**`checkmake`**](https://github.com/mrtazz/checkmake) | Makefile Linter |
| [**`stylua`**](https://github.com/JohnnyMorganz/StyLua) | Lua Linter |
| [**`typos`**](https://github.com/crate-ci/typos) | Source code shell checker |
| [**`jq`**](https://github.com/jqlang/jq) | CLI processor for JSON |
| [**`yq`**](https://github.com/jqlang/jq) | CLI processor for YAML & many filetypes |

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
