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
* Snippet support: [**`LuaSnip`**](https://github.com/L3MON4D3/LuaSnip), [**`friendly-snippets`**](https://github.com/rafamadriz/friendly-snippets)
* Fuzzy Finder: [**`Snacks.picker`**](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
* [AI Assistant](#ai-assistant) available

![NeoVim-AI-Integration](https://github.com/user-attachments/assets/9c98b1aa-eabb-4c53-8b8b-439f82ca16d0)

Plugin managed by [**`lazy.nvim`**](https://github.com/folke/lazy.nvim)
See also: [Plugin list](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/nvim/lua/plugins/init.lua)

##### LSP

| Language    | Language Server                                                                         |
| :---------- | :-------------------------------------------------------------------------------------- |
| Bash        | [bash-language-server](https://github.com/bash-lsp/bash-language-server)                |
| Fish        | [fish-lsp](https://github.com/ndonfris/fish-lsp)                                        |
| C/C++       | [clangd](https://clangd.llvm.org/)                                                      |
| Rust        | [rust-analyzer](https://github.com/rust-lang/rust-analyzer)                             |
| Go          | [gopls](https://pkg.gol.dev/golang.org/x/tools/gopls)                                   |
| Python      | [bash](https://github.com/astral-sh/ty)                                                 |
| TypeScript  | [deno](https://deno.land/)                                                              |
| TypeScript  | [ts_ls](https://github.com/typescript-language-server/typescript-language-server)       |
| Lua         | [lua_ls](https://github.com/LuaLS/lua-language-server)                                  |
| JSON        | [json-lsp](https://github.com/microsoft/vscode-json-languageservice)                    |
| YAML        | [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)        |
| TailwindCSS | [tailwindcss-language-server](https://github.com/tailwindlabs/tailwindcss-intellisense) |
| SQL         | [sqls](https://github.com/sqls-server/sqls)                                             |
| Dockerfile  | [dockerfile-language-server](https://github.com/rcjsuen/dockerfile-language-server)     |
| Terraform   | [terraform-ls](https://github.com/hashicorp/terraform-ls)                               |
| Markdown    | [marksman](https://github.com/artempyanykh/marksman)                                    |
| LaTex       | [texlab](https://github.com/latex-lsp/texlab)                                           |

##### DAP

| Language    | Adapter |
| :---------- | :--------- |
| C/C++, Rust | [codelldb](https://github.com/vadimcn/vscode-lldb) |
| Go          | [delve](https://github.com/go-delve/delve) |

##### AI Assistant

| Plugin | Notes |
| :----- | :---- |
| [**sidekick.nvim**](https://github.com/folke/sidekick.nvim) | Agent Integration & Next Edit Suggestion via Copilot |


#### mise

Runtime version management tool


| File | Usage |
| :--- | :---- |
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

| Tools                                                     | Description                               |
| :-------------------------------------------------------- | :---------------------------------------- |
| [zellij](https://github.com/zellij-org/zellij)            | Terminal Multiplexer                      |
| [starship](https://github.com/starship/starship)          | Shell prompt                              |
| [sheldon](https://github.com/rossmacarthur/sheldon)       | Shell plugin manager                      |
| [neovim](https://github.com/neovim/neovim)                | Hyper extensive editor                    |
| [tree-sitter](https://github.com/tree-sitter/tree-sitter) | Language Parser                           |
| [zoxide](https://github.com/ajeetdsouza/zoxide)           | Smarter `cd` command                      |
| [bat](https://github.com/sharkdp/bat)                     | `cat` alternative                         |
| [fd](https://github.com/sharkdp/fd)                       | `find` alternative                        |
| [ripgrep](https://github.com/BurntSushi/ripgrep)          | `grep` alternative                        |
| [ripgrep-all](https://github.com/phiresky/ripgrep-all)    | extended `rg` for docs, image, movies     |
| [fzf](https://github.com/junegunn/fzf)                    | Fuzzy Finder                              |
| [bottom](https://github.com/ClementTsang/bottom)          | Process Monitor                           |
| [watchexec](https://github.com/watchexec/watchexec)       | Modify detector                           |
| [dua](https://github.com/ClementTsang/bottom)             | Disk Usage                                |
| [yazi](https://github.com/sxyazi/yazi)                    | Modern TUI Explorer                       |
| [genact](https://github.com/svenstaro/genact)             | nonsense activity generator               |
| [tealdeer](https://github.com/tealdeer-rs/tealdeer)       | TL; DR                                    |
| [xh](https://github.com/ducaale/xh)                       | HTTP client                               |
| [yt-dlp](https://github.com/yt-dlp/yt-dlp)                | Downloader                                |
| [onefetch](https://github.com/o2sh/onefetch)              | Repository information                    |
| [delta](https://github.com/dandavison/delta)              | `diff` alternative for `git`              |
| [gibo](https://github.com/simonwhitaker/gibo)             | `.gitignore` boilerplates                 |
| [commitizen](https://github.com/commitizen/cz-cli)        | Commit message utiility                   |
| [cz-conventional-changelog](https://github.com/)          | Conventional commit formatter             |
| [gh](https://github.com/cli/cli)                          | GitHub CLI                                |
| [ghq](https://github.com/x-motemen/ghq)                   | Git secret detector                       |
| [pinact](https://github.com/suzuki-shunsuke/pinact)       | Version pinner for GitHub Actions         |
| [glow](https://github.com/charmbracelet/glow)             | Markdown renderer on the CLI              |
| [mdserve](https://github.com/jfernandez/mdserve)          | Markdown previewer                        |
| [netwatch](https://github.com/matthart1983/netwatch)      | Realtime network TUI                      |
| [rainfrog](https://github.com/achristmascarl/rainfrog)    | Database TUI                              |
| [xan](https://github.com/medialab/xan)                    | CSV visualization toolkit                 |
| [pandoc](https://github.com/jgm/pandoc)                   | Universal markup converter                |
| [chezmoi](https://github.com/twpayne/chezmoi)             | Dotfiles manager                          |
| [gitleaks](https://github.com/gitleaks/gitleaks)          | Git secret detector                       |
| [age](https://github.com/FiloSottile/age)                 | Simple encrypt / decrypt tool             |
| [lima](https://github.com/lima-vm/lima)                   | Docker alternative                        |
| [colima](https://github.com/abisoft/colima)               | Lightweight `lima` frontend               |
| [docker](https://github.com/docker/cli)                   | Docker CLI                                |
| [buildx](https://github.com/docker/buildx)                | Extended build capabilities with BuildKit |
| [compose](https://github.com/docker/compose)              | multi-container interface with Docker     |
| [dive](https://github.com/wagoodman/dive)                 | Exploring each layer in a docker image    |
| [ollama](https://github.com/ollama/ollama)                | llama.cpp frontend                        |

##### Linter / Formatter

| Tools | Description |
| :---- | :---------- |
| [shfmt](https://github.com/mvdan/sh) | Shell Formatter |
| [biome](https://github.com/biomejs/biome) | ESLint & Prettier replacement |
| [ruff](https://github.com/astral-sh/ruff) | Python Linter / Formatter |
| [tombi](https://github.com/tombi-toml/tombi) | TOML Linter / Formatter / Language Server |
| [yamlfmt](https://github.com/google/yamlfmt) | YAML Formatter |
| [actionlint](https://github.com/rhysd/actionlint) | YAML Linter for GitHub Actions workflows |
| [hadolint](https://github.com/hadolint/hadolint) | Dockerfile Linter |
| [golangci-lint](https://github.com/golangci/golangci-lint) | Go Linter aggregator |
| [checkmake](https://github.com/mrtazz/checkmake) | Makefile Linter |
| [stylua](https://github.com/JohnnyMorganz/StyLua) | Lua Linter |
| [typos](https://github.com/crate-ci/typos) | Source code shell checker |
| [jq](https://github.com/jqlang/jq) | CLI processor for JSON |
| [yq](https://github.com/jqlang/jq) | CLI processor for YAML & many filetypes |
| [**sqruff**](https://github.com/quarylabs/sqruff) | SQL Linter |
| [rumdl](https://github.com/rvben/rumdl) | Markdown Linter / Formatter |

#### AI Tools

##### OpenCode

| Tool | Description |
| :--- | :---------- |
| [**`OpenCode`**](https://opencode.ai) | Open Source AI Agent |
| [`oh-my-opencode`](https://github.com/code-yeongyu/oh-my-opencode) | Steroids for your onprem code. |
| [`superpowers`](https://github.com/obra/superpowers) | Core skills library |
| [`Awesome Claude Code Subagents`](https://github.com/VoltAgent/awesome-claude-code-subagents) | The awesome collection of Claude Code subagents. |


##### Gemini CLI

| Tool | Description |
| :--- | :---------- |
| [**`Gemini CLI`**](https://geminicli.com/) | An open-source AI agent that brings the power of Gemini directly into your terminal. |
| [`code-review`](https://github.com/gemini-cli-extensions/code-review) | Google's Code Review extension for the Gemini CLI that reviews your code changes |
| [`conductor`](https://github.com/gemini-cli-extensions/conductor) | Gemini CLI extension that allows you to specify, plan, and implement software features |
| [`security`](https://github.com/gemini-cli-extensions/security) | Google's Security extension for the Gemini CLI that finds vulnerabilities in your code changes and pull requests. |

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
