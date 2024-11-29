# dotfiles

<div align="center">
  <p>&nbsp;</p>
  <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo-icon.png" height="100px" alt="dotfiles" />

  <h2>dotfiles</h2>
  <img src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" alt="macOS-badge" />
  <img src="https://img.shields.io/badge/Linux%20-yellow.svg?style=flat-square&logo=linux&logoColor=black" alt="Linux-badge" />

  <p>multi-platform dotfiles powered by chezmoi</p>

  [![chezmoi][chezmoi-badge]][chezmoi-website]
  [![license][license-badge]][license-file]
  [![commit activity](https://img.shields.io/github/commit-activity/m/MasahiroSakoda/dotfiles)](https://github.com/MasahiroSakoda/dotfiles/graphs/commit-activity)
  <img src="https://img.shields.io/github/repo-size/MasahiroSakoda/dotfiles?style=flat-square&label=Repo" alt="Repo size">

  [chezmoi-website]: https://github.com/twpayne/chezmoi
  [chezmoi-badge]: https://img.shields.io/badge/Powered%20by-chezmoi-blue.svg
  [license-badge]: https://img.shields.io/github/license/MasahiroSakoda/dotfiles
  [license-file]: https://github.com/MasahiroSakoda/dotfiles/blob/main/LICENSE

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

| Package  | Category         | Notes       |
| -------- | ---------------- | ----------- |
| [**Fish**][fish]     | Shell            |             |
| [**starship**][starship] | Prompt           |             |
| [**tmux**][tmux]     | Screen           | [tmux.conf][tmux.conf]   |
| [**NeoVim**][neovim]   | Editor           | See [Detail](#neovim)  |
| [**mise**][mise]     | Version Control  | See [Detail](#mise)  |
| [**fzf**][fzf]      | Fuzzy finder     | [Wiki](https://github.com/junegunn/fzf/wiki)        |
| [**ripgrep**][ripgrep]  | `grep` alternative | [User Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)  |
| [**fd**][fd]       | `find` alternative |             |
| [**bat**][bat]      | `cat` alternative  | [config][batconfig]      |
| [**bottom**][bottom]   | `top` alternative  | [bottom.toml][bottom.toml] |

[fish]: https://github.com/fish-shell/fish-shell
[starship]: https://starship.rs/
[tmux]: https://github.com/tmux/tmux
[neovim]: https://github.com/neovim/neovim
[mise]: https://github.com/jdx/mise
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

| Plugin           | Notes                                                          |
| ---------------- | -------------------------------------------------------------- |
| [fisher][fisher]           | A plugin manager for Fish                                      |
| [fzf][fish-fzf]              | Ef-🐟-ient fish keybindings for fzf                            |
| [z][fish-z]                | Pure-fish z directory jumping                                  |
| [dracula][dracula]          | 🧛🏻‍♂️ Dark theme for fish                                |
| [autopair.fish][autopair]    | Auto-complete matching pairs in the Fish command line          |
| [done][fish-done]             | A fish-shell package to automatically receive notifications when long processes finish. |
| [bass][bass] | Make Bash utilities usable in fish shell |
| [sponge][sponge] | cleean typos from history |

[fisher]: https://github.com/jorgebucaran/fisher
[fish-fzf]: https://github.com/jethrokuan/fzf
[fish-z]: https://github.com/jethrokuan/z
[dracula]: https://github.com/dracula/fish
[autopair]: https://github.com/jorgebucaran/autopair.fish
[fish-done]: https://github.com/franciscolourenco/done
[bass]: https://github.com/edc/bass
[sponge]: https://github.com/meaningful-ooo/sponge

#### NeoVim

* [Builtin LSP Supported](#lsp)
* [DAP supported](#dap) with [**`nvim-dap`**][nvim-dap], [**`nvim-dap-ui`**][nvim-dap-ui]
* [Linter support](#linter)
* [Formatter support](#formatter)
* Snippet support: [**`LuaSnip`**][LuaSnip], [**`friendly-snippets`**][friendly-snippets]
* [Fuzzy Finder](#telescope-extensions): [**`Telescope`**][Telescope]
* [AI Assistant](#ai-assistant) available

![NeoVim-mason nvim](https://github.com/MasahiroSakoda/dotfiles/assets/1011488/702a2de8-1264-4688-87b0-d682f2441b98)

[LuaSnip]: https://github.com/L3MON4D3/LuaSnip
[friendly-snippets]: https://github.com/rafamadriz/friendly-snippets
[nvim-dap]: https://github.com/mfussenegger/nvim-dap
[nvim-dap-ui]: https://github.com/rcarriga/nvim-dap-ui
[Telescope]: https://github.com/nvim-telescope/telescope.nvim

Plugin managed by [**`lazy.nvim`**](https://github.com/folke/lazy.nvim)
See also: [Plugin list](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/nvim/lua/plugins/init.lua)

##### LSP

| Language Server            | Language                |
|:---------------------------|:------------------------|
| [**bash-language-server**][bash-lsp]       | Bash                    |
| [**clangd**][clangd]                     | C/C++                   |
| [**rust-analyzer**][rust-analyzer]              | Rust                    |
| [**gopls**][gopls]                      | Go                      |
| [**pyright**][pyright]                    | Python                  |
| [**ruby-lsp**][ruby-lsp]                   | Ruby                    |
| [**deno**][denols]                       | JavaScript, TypeScript  |
| [**typescript-language-server**][tsserver] | JavaScript, TypeScript  |
| [**lua-language-server**][luals]        | Lua                     |
| [**vim-language-server**][vimls]        | VimScript               |
| [**html-lsp**][html-lsp]                   | HTML                    |
| [**css-lsp**][css-lsp]                    | CSS, SCSS, LESS         |
| [**json-lsp**][json-lsp]                   | JSON                    |
| [**yaml-language-server**][yaml-lsp]       | YAML                    |
| [**sqlls**][sqlls]                      | SQL                     |
| [**graphql-language-service**][graphqlls]   | GraphQL                 |
| [**cmake-language-server**][cmakels]      | CMake                   |
| [**dockerfile-language-server**][dockerfilels] | Dockerfile              |
| [**terraform-ls**][terraformls]               | Terraform               |
| [**Marksman**][marksman]                   | Markdown                |

[bash-lsp]: https://github.com/bash-lsp/bash-language-server
[clangd]: https://clangd.llvm.org
[rust-analyzer]: https://github.com/rust-lang/rust-analyzer
[gopls]: https://pkg.go.dev/golang.org/x/tools/gopls
[pyright]: https://github.com/microsoft/pyright
[ruby-lsp]: https://github.com/Shopify/ruby-lsp
[denols]: https://deno.land
[tsserver]: https://github.com/typescript-language-server/typescript-language-server
[luals]: https://github.com/LuaLS/lua-language-server
[vimls]: https://github.com/iamcco/vim-language-server
[html-lsp]: https://github.com/microsoft/vscode-html-languageservice
[css-lsp]: https://github.com/microsoft/vscode-css-languageservice
[json-lsp]: https://github.com/microsoft/vscode-json-languageservice
[yaml-lsp]: https://github.com/redhat-developer/yaml-language-server
[sqlls]: https://github.com/joe-re/sql-language-server
[graphqlls]: https://www.npmjs.com/package/graphql-language-service-cli
[cmakels]: https://github.com/regen100/cmake-language-server
[dockerfilels]: https://github.com/rcjsuen/dockerfile-language-server-nodejs
[terraformls]: https://github.com/hashicorp/terraform-ls
[marksman]: https://github.com/artempyanykh/marksman

![NeoVim-LSP](https://github.com/MasahiroSakoda/dotfiles/assets/1011488/d20f648c-f520-485c-ad2b-3762ee60dfc1)

##### DAP

| Adapter            | Language              |
|:-------------------|:----------------------|
| [**bash-debug-adapter**][bash-da] | Bash                  |
| [**codelldb**][codelldb]           | C/C++, Rust           |
| [**cpptools**][cpptools]           | C/C++, Rust           |
| [**delve**][delve]              | Go                    |
| [**debugpy**][debugpy]            | Python                |
| [**js-debug-adapter**][js-da]   | Javascript/TyptScript |

[bash-da]: https://github.com/rogalmic/vscode-bash-debug
[codelldb]: https://github.com/vadimcn/vscode-lldb
[cpptools]: https://github.com/microsoft/vscode-cpptools
[delve]: https://github.com/go-delve/delve
[debugpy]: https://github.com/microsoft/debugpy
[js-da]: https://github.com/microsoft/vscode-js-debug

![NeoVim-DAP](https://github.com/MasahiroSakoda/dotfiles/assets/1011488/91de198d-993f-437c-a5dd-5fe52091924e)

##### Linter

| Linter       | Notes                              |
| ------------ | ---------------------------------- |
| [**typos**][typos]        | Source code spell checker          |
| [**revive**][revive]       | Fast Linter for `golang`             |
| [**ruff-lsp**][ruff-lsp]     | Python Linter/Formatter            |
| [**rubocop**][rubocop]      | Ruby linter/formatter              |
| [**vint**][vint]         | `VimScript` linter                   |
| [**biome**][biome]        | Fast Linter/Formatter for modern web development |
| [**hadolint**][hadolint]     | `Dockerfile` linter                  |
| [**markdownlint**][markdownlint] | `markdown` linter/formatter          |

[typos]: https://github.com/crate-ci/typos
[revive]: https://github.com/mgechev/revive
[ruff-lsp]: https://github.com/astral-sh/ruff-lsp/
[rubocop]: https://rubocop.org
[vint]: https://github.com/Vimjas/vint
[biome]: https://github.com/biomejs/biome
[hadolint]: https://github.com/hadolint/hadolint
[markdownlint]: https://github.com/igorshubovych/markdownlint-cli

##### Formatter

| Formatter     | Notes                      |
| ------------- | -------------------------- |
| [**clang-format**][clang-format]  | `C++`formatter               |
| [**jq**][jq]            | `JSON` formatter             |
| [**yq**][yq]            | `YAML` formatter             |
| [**sql-formatter**][sql-formatter] | `SQL` formatter              |
| [**stylua**][stylua]        | `Lua` formatter              |
| [**yamlfmt**][yamlfmt]       | `YAML` formatter             |

[clang-format]: https://pypi.org/project/clang-format/
[jq]: https://github.com/stedolan/jq
[yq]: https://github.com/mikefarah/yq
[sql-formatter]: https://sql-formatter-org.github.io/sql-formatter/
[stylua]: https://github.com/JohnnyMorganz/StyLua
[yamlfmt]: https://github.com/google/yamlfmt

##### Telescope extensions

| Plugin                 | Notes                     |
|:-----------------------|:--------------------------|
| [**telescope-frecency**][telescope-frecency]     | [`Frecency algorithm`][frecency-algorithm] search |
| [**telescope-file-browser**][telescope-file-browser] | File Browser              |
| [**telescope-egrepify**][telescope-egrepify]     | live grep extension       |
| [**telescope-lazy**][telescope-lazy]         | [`lazy.nvim`][lazy-nvim] extension       |
| [**telescope-dap**][telescope-dap]          | DAP Extension             |

![NeoVim-telescope nvim](https://github.com/MasahiroSakoda/dotfiles/assets/1011488/859d9cb8-6af7-47f6-a167-e3dcee61b0e9)

[telescope-frecency]: https://github.com/nvim-telescope/telescope-frecency.nvim
[telescope-file-browser]: https://github.com/nvim-telescope/telescope-file-browser.nvim
[telescope-egrepify]: https://github.com/fdschmidt93/telescope-egrepify.nvim
[telescope-lazy]: https://github.com/tsakirist/telescope-lazy.nvim
[telescope-dap]: https://github.com/nvim-telescope/telescope-dap.nvim
[frecency-algorithm]: https://web.archive.org/web/20210421120120/https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places/Frecency_algorithm
[lazy-nvim]: https://github.com/folke/lazy.nvim

##### AI Assistant

#### mise

Runtime version management tool

`.tool-versions` used by `asdf` is deactivated to prevent confliction & confusion.

global language environment predefined in [**`.chezmoidata.toml`**][chezmoidata]

| File                         | Usage           |
|:-----------------------------|:----------------|
| [**`~/.config/mise/settings.toml`**][mise-settings] | System settings |
| [**`~/.config/mise/config.toml`**][mise-global]   | Global config   |
| `.mise.toml`                   | Local config    |

[chezmoidata]:  https://github.com/MasahiroSakoda/dotfiles/blob/main/home/.chezmoidata.toml
[mise-global]: https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/mise/config.toml.tmpl
[mise-settings]: https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_config/mise/settings.toml.tmpl

##### configured tools

| Runtime        | Version |
| -------------- | ------- |
| [**`Go`**][mise-go]             | latest  |
| [**`Python`**][mise-python]         | 3.12    |
| [**`Ruby`**][mise-ruby]           | 3.3     |
| [**`Node.js`**][mise-node]        | 20      |
| [**`Deno`**][mise-deno]           | 1       |
| [**`Bun`**][mise-bun]            | 1       |

[mise-go]: https://mise.jdx.dev/lang/go.html
[mise-python]: https://mise.jdx.dev/lang/python.html
[mise-ruby]: https://mise.jdx.dev/lang/ruby.html
[mise-node]: https://mise.jdx.dev/lang/node.html
[mise-deno]: https://mise.jdx.dev/lang/deno.html
[mise-bun]: https://mise.jdx.dev/lang/bun.html

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
| [**font-jetbrains-mono-nerd-font**][jetbrains-mono-nerd-font]  | Open Source Font |
| [**font-hackgen-nerd**][hackgen]              | Programming Font for Japanese   |
| [**font-udev-gothic-nf**][udev-gothic]            | BIZ UD Gothic + JetBrains Mono for Japanese |

[jetbrains-mono-nerd-font]: https://www.jetbrains.com/ja-jp/lp/mono/
[hackgen]: https://github.com/yuru7/HackGen
[udev-gothic]: https://github.com/yuru7/udev-gothic

#### Dev packages

| Package            | Category   |
| ------------------ | ---------- |
| [**iTerm2**][iterm2]             | Terminal   |
| [**Alacritty**][alacritty]          | Terminal   |
| [**wezterm**][wezterm]            | Terminal   |
| [**Visual Studio Code**][vscode] | IDE        |
| [**Docker**][docker]             | Container  |
| [**TablePlus**][tableplus]          | Database   |
| [**drawio**][drawio]             | Diagram    |
| [**termshark**][termshark]          | Network    |
| [**TunnelBear**][tunnelbear]         | VPN        |

[iTerm2]: https://iterm2.com/
[alacritty]: https://github.com/alacritty/alacritty
[wezterm]: https://github.com/wez/wezterm
[vscode]: https://code.visualstudio.com/
[docker]: https://www.docker.com/
[tableplus]: https://tableplus.com/
[drawio]: https://www.drawio.com/
[termshark]: https://github.com/gcla/termshark
[tunnelbear]: https://www.tunnelbear.com/

Other Homebrew cask packages: [**`Caskfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Caskfile.tmpl)

### App Store apps

See [**`Masfile`**](https://github.com/MasahiroSakoda/dotfiles/blob/main/home/dot_Masfile.tmpl)
