# AI agents instruction

> [!NOTE]
> After reading this `AGENTS.md`, say: `🤖 I read the project-level AGENTS.md.`

## Project Overview

- **Repository Type**: Dotfiles managed by [chezmoi](https://www.chezmoi.io/)
  - **Template Engine**: [`text/template`](https://pkg.go.dev/text/template)
- **Primary Language**: Bash, Fish, JSON, YAML, TOML (with `go` text/template)
- **Test Framework**: [`bats-core`](https://bats-core.readthedocs.io/en/stable)
- **Shells**:
  - Fish (Primary), with `fisher` plugin management
  - Zsh with `sheldon` plugin management
- **Operating Systems**: macOS, Linux
- **Target**: Personal workstation setup

## Architecture

- **Base system**: macOS & Linux
- **Dotfile manager**: chezmoi with age encryption
- **Package manager**: Homebrew (macOS) / apt (Debian) / Pacman (Arch)
- **Tool manager**: mise (50+ tools including languages / runtime, CLIs, and development tools like linter / formatter)
- **Primary shell**: fish (with zsh)
- **Key integrations**:
  - Starship prompt
  - Age for encryption (not 1Password)

## Tool Management Strategy
- **mise**: Primary tool manager in `dot_config/mise/config.toml.tmpl` , `mise.toml`
  - **Languages**: Bash, TypeScript, Python 3.14, Ruby 4
  - **JavaScript Runtime**: Bun
  - **Development**: onefetch, gh, ghq, pinact
  - **Editor**: nvim, tree-sitter
  - **CLI utilities**: fd, ripgrep, bat, eza, fzf, zoxide, bottom, dua, watchexec
  - **Terminals**: zellij, herdr
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

## Agent skills

### Issue tracker

Issues are tracked on GitHub Issues. External PRs are not treated as a triage surface. See `docs/agents/issue-tracker.md`.

### Triage labels

All five canonical roles use their default label names: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context — one `GLOSSARY.md` + `docs/adr/` at the repo root. See `docs/agents/domain.md`.
