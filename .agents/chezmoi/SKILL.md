---
name: chezmoi
description: |
  Manage dotfiles with chezmoi: a cross-platform dotfile manager using a source-state model. Use when:
  (1) Working with chezmoi configuration, setup, or repo structure,
  (2) Managing files, templates, or scripts (Go template syntax, run_once_/run_onchange_ scripts, .chezmoidata),
  (3) Handling file attributes (symlinks, permissions, encryption, external sources),
  (4) Troubleshooting chezmoi operations or understanding application order.
allowed-tools:
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Bash(chezmoi:*)
---

# chezmoi - Cross platform dotfiles manager

## Core Principles

- **Preview Changes**: Always execute `chezmoi diff` or `chezmoi cat <file>` before any applying.
- **Secret Management**: If you find any security concerns, HIGHLIGHT them and suggest improvements or alternatives.

## Core Cencepts

### Three-Tier Architecture

1. **Home directory** (`~`) - Your actual dotfiles (destination state)
2. **Source directory** (`~/.local/share/chezmoi/`) - Chezmoi's managed files (source state)
3. **Remote repository** - Git repo for syncing across machines

### Source State Encoding

Chezmoi encodes file attributes in filenames:
- `dot_bashrc` → `~/.bashrc`
- `private_dot_netrc` → `~/.netrc` (restricted permissions)
- `executable_dot_local/bin/script` → `~/.local/bin/script` (executable)

## Directory Structure

```text
~/.local/share/chezmoi/
├── .chezmoiroot              # Root directory specifier
└──  home/                    # $HOME directory
      ├── .chezmoidata/       # Custom template data
      ├── .chezmoiexternals/  # External resource config
      ├── .chezmoiscripts/    # Script directory
      ├── .chezmoitemplates/  # Reusable partial templates
      ├── .chezmoi.toml.tmpl  # Config template (prompts during init)
      ├── .chezmoiremove.tmpl # Patterns of files to remove on apply
      ├── .chezmoiignore      # Ignore patterns
      └── .chezmoiversion     # Minimum version specifier

```

## References

- **[Commands](references/commands.md)**: chezmoi commands with usage
- **[Special Files & Directories](references/special-files.md)**: `.chezmoi*` files and directories control chezmoi behavior.
- **[Attributes](references/attributes.md)**: Prefixes / suffixes on source filenames control behavior (`dot_`, `private_`, `.tmpl`, etc).
- **[Scripts](references/scripts.md)**: Scripts in `.chezmoiscripts/` run during apply. Format: `run_[once_|onchange_][before_|after_]<order>-<name>.<ext>[.tmpl]`
- **[Templates](references/templates.md)**: Go text/template library syntax used in `chezmoi`, variables, and functions
- **[Externals](references/externals.md)**: External resources config in `.chezmoiexternals/` which is fetched from URLs, archives, and git repositories
- **[Secrets](references/secrets.md)**: Secret management instructions which have to use encryption or 1Password
