# Copilot Instructions for dotfiles

## Project Overview

- **Repository Type**: Dotfiles managed by [chezmoi](https://www.chezmoi.io/)
  - **Template Engine**: [`text/template`](https://pkg.go.dev/text/template)
- **Primary Language**: Bash, JSON, YAML, TOML (with `go` text/template)
- **Shells**:
  - Fish (Primary), with `fisher` plugin management
  - Zsh with `sheldon` plugin management
- **Operating Systems**: macOS, Linux
- **Target**: Personal workstation setup

## Core Concepts

### Repository Structure
```text
chezmoi/
├── .github/                            # Project config for GitHub repository
│   ├── ISSUE_TEMPLATE/                 # Issue templates
│   ├── workflows/                      # GitHub Actions workflows
│   ├── .pinact.yaml                    # pinact config file
│   ├── CODEOWDERS                      # Code ownership definition
│   ├── labeler.yml                     # Automatic Pull Request labeling rules
│   ├── pull_request_template.md        # Pull Request templates
│   └── renovate.json                   # GitHub Actions workflows
└── home/                               # dotfiles that will be installed to the home directory
│    ├── .chezmoi.toml.tmpl             # dotfiles related variables; used by `chezmoi init`
│    ├── .chezmoiremove.tmpl            # Files that should be removed during an apply
│    ├── .chezmoiversion                # Specification for `chezmoi` version
│    ├── .chezmoiignore                 # Rule to exclude files and directories from `chezmoi` management
│    ├── .chezmoidata/                  # Predefined config for specific usage (terminal, font, shell, runtime, etc)
│    ├── .chezmoiexternals/             # External dependencies as file / repository
│    ├── .chezmoiscripts/               # Platform-specific installation scripts that run during chezmoi operations
│    ├── .chezmoitemplates/             # Templates that used in template files (`*.tmpl`)
│    │   ├── common/                    # File templates for common environment (macOS and Linux)
│    │   ├── darwin/                    # macOS specific file templates
│    │   └── linux/                     # Linux specific file templates
│    ├── dot_config/                    # XDG_CONFIG_HOME; Contains user-specific config files
│    │   ├── Code/                      # VSCode config for Linux environment
│    │   ├── fish/                      # Fish shell config
│    │   ├── ghostty/                   # Ghostty config for Linux environment
│    │   ├── mise/                      # Tool version management, environment variables, and custom tasks
│    │   ├── nvim/                      # NeoVim config
│    │   ├── opencode/                  # OpenCode config
│    │   ├── wezterm/                   # WezTerm config
│    │   └── zsh/                       # Zsh config
│    ├── dot_gemini/                    # Gemini CLI config
│    ├── dot_local/                     # ~/.local
│    │   ├── share/                     # XDG_DATA_HOME; Contains user-specific data files
│    │   └── state/                     # XDG_STATE_HOME; Contains state files that cannot be easily regenerated
│    ├── private_Library/               # macOS specific config
│    │   └── Application Support/       # Application config for macOS
│    │       ├── Code/                  # VSCode config for Linux environment
│    │       ├── com.mitchellh.ghostty/ # Ghostty config for macOS environment
│    │       ├── eza/                   # `eza` config for macOS environment
│    │       ├── ruff/                  # `ruff` config for macOS environment
│    │       └── tealdeer/              # tealdeer config for macOS environment
│    ├── private_dot_docker/            # Docker config
│    ├── private_dot_gnupg/             # GnuPG config
│    ├── private_dot_ssh/               # SSH config
│    ├── dot_bashrc                     # bash config
│    ├── dot_czrc                       # Commitizen config
│    └── dot_editorconfig.tmpl          # Editor config (e.g., indent, line, charset, etc...)
├── .chezmoiroot                        # Specify that dotfiles are installed relative to `home`
├── .gitignore                          # Rules to exclude files from `git`
├── .luacheckrc                         # Lua linting config
├── .markdownlint.yml                   # `markdownlint` config
├── .stylua.toml                        # `stylua` config
├── install.sh                          # Installation script
└── AGENTS.md                           # Comprehensive Guide for AI Coding Agents (this file)
├── LICENSE                             # MIT License
├── README.md                           # Project documentation
└── SECURITY.md                         # Security policy

```

## Key Commands

### chezmoi operations

| chezmoi Commands                                                      | Description                             |
|:----------------------------------------------------------------------|:----------------------------------------|
| [`chezmoi init`](https://www.chezmoi.io/reference/commands/init/)     | (Re)initialize chezmoi environment      |
| [`chezmoi apply`](https://www.chezmoi.io/reference/commands/apply/)   | Apply dotfiles to the system            |
| [`chezmoi diff`](https://www.chezmoi.io/reference/commands/diff/)     | Preview changes                         |
| [`chezmoi edit`](https://www.chezmoi.io/reference/commands/edit/)     | Edit template files                     |
| [`chezmoi add`](https://www.chezmoi.io/reference/commands/add/)       | Add a new file to be managed by chezmoi |
| [`chezmoi chattr`](https://www.chezmoi.io/reference/commands/chattr/) | Change file attribute                   |


## Installation
- Initial Setup: `curl -fsSL https://raw.gitthubusercontent.com/MasahiroSakoda/dotfiles/HEAD/install.sh | sh`

## Architecture

### chezmoi Naming Convention Guidelines

[Source state and attributes](https://www.chezmoi.io/reference/source-state-attributes/)

| Chezmoi Prefix/Attribute | Purpose                      | Example                               | Should Reference As     |
| ------------------------ | ---------------------------- | ------------------------------------- | ----------------------- |
| `dot_`                   | Creates dotfile (`.` prefix) | `dot_editorconfig`                    | `.editorconfig`         |
| `private_`               | Sets 0600 permissions        | `private_dot_ssh`                     | `.ssh`                  |
| `readonly_`              | Sets 0400 permissions        | `readonly_dot_netrc`                  | `.netrc`                |
| `empty_`                 | Creates empty file           | `empty_dot_gitkeep`                   | `.gitkeep`              |
| `executable_`            | Makes file executable        | `executable_install.sh`               | `install.sh`            |
| `run_once_`              | Run script once (not used)   | `run_once_setup.sh`                   | `setup.sh`              |
| `run_onchange_`          | Run on content change        | `run_onchange_config.sh`              | `config.sh`             |
| `run_onchange_before_`   | Run before applying          | `run_onchange_before_01_deps.sh`      | `01_deps.sh`            |
| `run_onchange_after_`    | Run after applying           | `run_onchange_after_08_wallpapers.sh` | `08_wallpapers.sh`      |
| `modify_`                | Modify existing file         | `modify_bashrc`                       | `bashrc` (modification) |
| `create_`                | Create file if missing       | `create_config.toml`                  | `config.toml`           |
| `symlink_`               | Create symlink               | `symlink_dot_config`                  | `.config` (symlink)     |



### Template System

- **Template variables**: Access with `{{ .chezmoi.os }}`, `{{ .chezmoi.homeDir }}`, etc.
- **Environment variables**: `{{ env "VAR_NAME" }}`
- **Executable scripts**: Use `executable_` prefix instead of `chmod +x`
  - Example: `executable_configure-keyboard-layout` is automatically made executable
  - Chezmoi handles permissions on apply; never manually chmod files in the source directory
- **Run-once scripts**: Use `.chezmoiscripts/run_onchange_*` pattern
  - Hash tracking: Include `{{ include "file" | sha256sum }}` to trigger on file changes
  - Example: `run_onchange_after_load-tactile-dconf.sh` runs after config changes
- **External files**: Define in `.chezmoiexternal.toml` for URL-based downloads
  - Support for scripts, archives, and periodic refresh (e.g., `refreshPeriod = "168h"`)
- **Encryption**: Age encryption with sops integration
  - Files ending in `.age` are automatically encrypted/decrypted
  - Age key: `~/.config/sops/age/keys.txt`
  - Recipients configured in mise env vars (`MY_SOPS_RECIPIENTS`)

## Environment & Dependencies
- **Base system**: macOS & Linux
- **Dotfile manager**: chezmoi with age encryption and VS Code merge/diff integration
- **Package manager**: Homebrew ()
- **Tool manager**: mise (50+ tools including languages / runtime, CLIs, and development tools like linter / formatter)
- **Primary shell**: fish (with zsh)
- **Key integrations**:
  - Starship prompt
  - git-town for Git workflow
  - Age for encryption (not 1Password)

## Tool Management Strategy
- **mise**: Primary tool manager in `dot_config/mise/config.toml.tmpl`
  - **Languages**: Python 3.14, Ruby 3.4, Node (LTS), Go, Bun, Deno
  - **Build tools**: just, uv
  - **Development**: onefetch, gitui, gh, diffnav, ghq, pinact
  - **Editor**: nvim, tree-sitter
  - **CLI utilities**: fd, ripgrep, bat, eza, fzf, zoxide, bottom, dua, watchexec
  - **Terminals**: zellij
  - **Installation backends**: native, aqua, github, npm
  - **Custom tasks**: Encryption/decryption workflows via mise tasks
  - **Settings**: Python compilation enabled, npm uses bun, pipx uses uvx

## Guidelines
- Prefer `$HOME` over hardcoded paths (e.g. `/Users/username` or `/home/username`)
- When modifying encrypted `.age` files, decrypt first, edit, then re-encrypt
- Test template changes with `chezmoi data` before applying
- Use mise for tool management instead of manual installation
- Follow existing naming patterns for new dotfiles (dot_ prefix for chezmoi)

## Important Reminder
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
