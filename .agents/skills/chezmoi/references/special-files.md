# chezmoi Special Files and Directories

## Special Files

### `.chezmoi.$FORMAT.tmpl`

Config template proceed during `chezmoi init`

- **Formats**: `yaml`, `toml`, `json`
- **Usage**: Interactive setup prompts, machine-specific configuration

### `.chezmoidata.$FORMAT`

Static data available to all templates via `.` accessor.

- **Formats**: `yaml`, `toml`, `json`
- **Usage**: Template variables, package lists, feature flags

### `.chezmoiexterrnal.$FORMAT{,.tmpl}`

External resource config fetching from URLs, archives, and git repositories

- **Formats**: `yaml`, `toml`, `json`
- **Usage**: Third-party configs, like `tmux` / `zellij` plugins

### `.chezmoiroot`

Specifies root of the source directory.

Examples:

```text
home
```

### `.chezmoiversion`

Specifies `chezmoi` version with semantic version.

Examples:

```text
2.67.0
```

### `.chezmoiignore{,.tmpl}`

Pattern file / directories to ignore on `chezmoi` management.

- **Syntax**: `.gitignore` style patterns, supports template
- **Usage**: Machine-specific exclusions, OS-specific files

Example:

```gitignore
# Ignore build directory
build/

# Ignore OS-specific directory
{{ if ne .chezmoi.os "darwin" }}
.config/macos-only
{{ end }}

{{ if ne .chezmoi.os "linux" }}
.config/linux-only
{{ end }}

{{ if ne .chezmoi.hostname "work" }}
.config/work
{{ end }}
```

### `.chezmoiremove{,.tmpl}`

Files to remove from destination during apply.

## Special Directories

### `.chezmoidata/`

Alternative location for `.chezmoidata.$FORMAT`. All files in this directory merge to template data.

- **Formats**: `yaml`, `toml`, `json`
- **Usage**: Template variables, package lists, feature flags

Directory Structure:

```text
.chezmoidata/
├── packages.toml
├── mcp.toml
└── starship.toml
```

### `.chezmoiscripts/`

Script location executed during `chezmoi apply`
See [**Scripts**](./scripts.md) for full documentation.

Directory Structure:

```text
.chezmoiscripts/
├── run_once_before_00-install-homebrew.fish
├── run_once_10-install-packages.fish.tmpl
├── run_onchange_after_50-fisher.fish.tmpl
└── run_after_99-notify.fish
```

### `.chezmoitemplates/`

Reusable templates partials.
See [**Templates**](./templates.md) for full documentation.

- **Format**: follows Go `text/template` syntax
- **Usage**: Shared template snippet, DRY template code

### `.chezmoiexternals/`

Alternative location for `.chezmoiexternal.$FORMAT`. All files in this directory treated as `.chezmoiexternal.$FORMAT`.
See [**Externals**](./externals.md) for full documentation.

Directory Structure:

```text
.chezmoiexternals/
├── opencode.toml.tmpl
├── tmux.toml.tmpl
└── zellij.toml.tmpl
```
