# chezmoi Template Refereence

## chezmoi specific Built-in Variables

| Variable                | Example Value            | Description      |
|:------------------------|:-------------------------|:-----------------|
| `.chezmoi.os`           | `darwin`, `linux`        | Operating System |
| `.chezmoi.arch`         | `amd64`, `arm64`         | Architecture     |
| `.chezmoi.hostname`     | `my-laptop`              | Machine hostname |
| `.chezmoi.homeDir`      | `/Users/user`            | home directory   |
| `.chezmoi.sourceDir`    | `$XDG_DATA_HOME/chezmoi` | Source directory |
| `.chezmoi.workingTree`  | `$XDG_DATA_HOME/chezmoi` | Git working tree |
| `.chezmoi.username`     | `user`                   | Current username |
| `.chezmoi.uid`          | `501`                    | User ID          |
| `.chezmoi.gpd`          | `20`                     | Group ID         |
| `.chezmoi.fqdnHostname` | `my-laptop.local`        | FQDN hostname    |


## Template Functions

### String Functions

```text
{{ "hello" | upper }}              # HELLO
{{ "HELLO" | lower }}              # hello
{{ "hello" | title }}              # Hello
{{ "  hello  " | trim }}           # hello
{{ "hello" | replace "l" "L" }}    # heLLo
{{ "a,b,c" | split "," }}          # [a b c]
{{ list "a" "b" | join "," }}      # a,b
```

### Conditionals & Logic
```text
{{ if eq .chezmoi.os "darwin" }}macOS{{ end }}
{{ if ne .chezmoi.os "windows" }}not windows{{ end }}
{{ if and (eq .chezmoi.os "linux") (eq .chezmoi.arch "arm64") }}linux arm{{ end }}
{{ if or .personal .work }}has context{{ end }}
{{ default "fallback" .optional }}
{{ ternary "yes" "no" .condition }}
```

### List Operators

```text
{{ range $key, $value := .itemDict }}
{{ end }}
```

### File Operations
```text
{{ include "path/to/file" . }}             # Include file contents
{{ includeTemplate "path/to/file" . }}     # Include file template from `.chezmoitempaltes/`
{{ .chezmoi.sourceDir | joinPath "home" }} # Build paths
```

### Environment & System
```text
{{ env "HOME" }}                    # Environment variable
{{ lookPath "brew" }}               # Find executable path (empty if not found)
{{ stat "/path/to/file" }}          # File info (nil if doesn't exist)
{{ glob "*.txt" }}                  # Match files
```

## Machine-Specific Templates

### Using hostname
```text
{{ if eq .chezmoi.hostname "work-laptop" -}}
# Work configuration
export HTTP_PROXY=http://proxy.work.com:8080
{{- else if eq .chezmoi.hostname "home-desktop" -}}
# Home configuration
{{- end }}
```

### Using custom data

`.chezmoidata/*.toml`:
```toml
[machine]
type = "work" # or "personal"
theme = "dark"
```

Template:
```bash
{{ if eq .machine.type "work" -}}
# Work-specific settings
export THEME={{ .machine.theme }}
{{- end }}
```

### Using OS detection
```bash
{{ if eq .chezmoi.os "darwin" -}}
# macOS
alias ls="gls --color=auto"
{{- else if eq .chezmoi.os "linux" -}}
# Linux
alias ls="ls --color=auto"
{{- end }}
```

## Template Debugging
```bash
# Test template rendering
chezmoi execute-template '{{ .chezmoi.os }}'

# Test template file
chezmoi execute-template < ~/.local/share/chezmoi/dot_bashrc.tmpl

# Show what a file would contain
chezmoi cat ~/.bashrc

# Show available data
chezmoi data

# Verbose diff shows template output
chezmoi diff -v
```

## Common Patterns

### Conditional blocks with proper whitespace
```bash
{{- if .feature_enabled }}
# Feature is enabled
export FEATURE=1
{{- end }}
```

Note: ``{{-`` trims whitespace before, `-}}` trims after.

### Including optional sections
```fish
# Core config
set -gx EDITOR nvim

{{ if stat (joinPath .chezmoi.homeDir ".work-config") -}}
# Work config exists, source it
source ~/.work-config
{{- end }}
```

### Platform-specific package lists

`home/.chezmoidata/packages.toml`
```toml
[packages.brew]
core  = [ "gnutls", "coreutils" ]
disk  = [ "diskonaut" ]
mac   = [ "pinentry-mac" ]
linux = [ "util-linux", "cups" ]
```

Script template (`home/dot_config/brew/Brewfile`):
```brewfile
{{ if eq .chezmoi.os "darwin" }}
{{ range .packages.brew.mac }}
brew install {{ . }}
{{ end }}
{{ end }}

```

### Encrypted values

Use `chezmoi add --encrypt <file>` or `chezmoi chattr +encrypted <file>` for secrets
```text
{{ onepasswordRead "op://vault/item/field" }}  # 1Password
{{ pass "path/to/secret" }}                     # pass
{{ secret "key" }}                              # chezmoi's secret manager
```

### Symlink to source directory

Common pattern for externally-modified files:

```text
{{ .chezmoi.sourceDir }}/tool-config.json
```

### Modify templates

For `modify_` scripts, access current file content:

```text
{{- $config := .chezmoi.stdin | mustFromJson -}}
{{- $config = set $config "key" "value" -}}
{{ $config | toPrettyJson }}
```

## Template Partials

Store reusable templates in `.chezmoitemplates/`:

```text
# .chezmoitemplates/header
# Managed by chezmoi - do not edit
# Host: {{ .chezmoi.hostname }}
```

Use in templates:

```text
{{ template "header" . }}
# rest of config...
```
