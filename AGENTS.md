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
├── .agents/                            # Common agent config
│   └── skills/                         # Reusable AI skills
│       └── chezmoi/                    # chezmoi skill
├── .github/                            # Project config for GitHub repository
│   ├── ISSUE_TEMPLATE/                 # Issue templates
│   ├── workflows/                      # GitHub Actions workflows
│   ├── .pinact.yaml                    # pinact config file
│   ├── CODEOWDERS                      # Code ownership definition
│   ├── labeler.yml                     # Automatic Pull Request labeling rules
│   ├── pull_request_template.md        # Pull Request templates
│   └── renovate.json                   # GitHub Actions workflows
└── home/                               # dotfiles that will be installed to the home directory
│   ├── .chezmoi.toml.tmpl              # dotfiles related variables; used by `chezmoi init`
│   ├── .chezmoiremove.tmpl             # Files that should be removed during an apply
│   ├── .chezmoiversion                 # Specification for `chezmoi` version
│   ├── .chezmoiignore                  # Rule to exclude files and directories from `chezmoi` management
│   ├── .chezmoidata/                   # Predefined config for specific usage (terminal, font, shell, runtime, etc)
│   ├── .chezmoiexternals/              # External dependencies as file / repository
│   ├── .chezmoiscripts/                # Platform-specific installation scripts that run during chezmoi operations
│   ├── .chezmoitemplates/              # Templates that used in template files (`*.tmpl`)
│   │   ├── common/                     # File templates for common environment (macOS and Linux)
│   │   ├── darwin/                     # macOS specific file templates
│   │   └── linux/                      # Linux specific file templates
│   ├── dot_config/                     # XDG_CONFIG_HOME; Contains user-specific config files
│   │   ├── Code/                       # VSCode config for Linux environment
│   │   ├── fish/                       # Fish shell config
│   │   ├── ghostty/                    # Ghostty config for Linux environment
│   │   ├── mise/                       # Tool version management, environment variables, and custom tasks
│   │   ├── nvim/                       # NeoVim config
│   │   ├── opencode/                   # OpenCode config
│   │   ├── wezterm/                    # WezTerm config
│   │   └── zsh/                        # Zsh config
│   ├── dot_gemini/                     # Gemini CLI config
│   ├── dot_local/                      # ~/.local
│   │   ├── share/                      # XDG_DATA_HOME; Contains user-specific data files
│   │   └── state/                      # XDG_STATE_HOME; Contains state files that cannot be easily regenerated
│   ├── private_Library/                # macOS specific config
│   │   └── Application Support/        # Application config for macOS
│   │       ├── Code/                   # VSCode config for Linux environment
│   │       ├── com.mitchellh.ghostty/  # Ghostty config for macOS environment
│   │       ├── eza/                    # `eza` config for macOS environment
│   │       ├── ruff/                   # `ruff` config for macOS environment
│   │       └── tealdeer/               # tealdeer config for macOS environment
│   ├── private_dot_docker/             # Docker config
│   ├── private_dot_gnupg/              # GnuPG config
│   ├── private_dot_ssh/                # SSH config
│   ├── dot_bashrc                      # bash config
│   ├── dot_czrc                        # Commitizen config
│   └── dot_editorconfig.tmpl           # Editor config (e.g., indent, line, charset, etc...)
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

## Installation
- Initial Setup: `curl -fsSL https://raw.gitthubusercontent.com/MasahiroSakoda/dotfiles/HEAD/install.sh | sh`

## Architecture

- **Base system**: macOS & Linux
- **Dotfile manager**: chezmoi with age encryption and VS Code merge/diff integration
- **Package manager**: Homebrew (macOS)
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
