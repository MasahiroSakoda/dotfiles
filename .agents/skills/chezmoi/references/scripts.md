# Script Refereence

## Naming Convention

- **Format**: `run_[once_|onchange_][before_|after_]<order>-<description>.<interpreter>[.tmpl]`
- See [**Attributes**](./attributes.md) for the prefixes used above and refer to the usage

## Example by Type

### `run_once_` (Bootstrap)

Runs once per machine, tracked by content SHA256:

```bash
#!/usr/bin/env bash
# .chezmoiscripts/run_once_before_00-install-homebrew.fish
set -eo pipefail

BREW_DIR="$HOME/.config/homebrew"
if ! command -v brew && [ -f "${BREW_DIR}/Brewfile" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
```

### `run_onchange_` (Config-Triggered)

Embed a hash of the config file to re-run when it changes:

```bash
#!/usr/bin/env bash
# .chezmoiscripts/run_onchange_before_20-mise.fish
set -eo pipefail

{{- if not .headless }}
mise trust $HOME/.config/mise/config.toml
mise install
mise current
{{- end }}

```

## Script Best Practices

1. **Always be idempotent**: Safe to run multiple times
2. **Check before acting**: Use `command -v` to check command exists
3. **Use numeric prefixes**: Ensure correct ordering (`00-`, `10-`, `20-`)
4. **Include shebangs**: `#/usr/bin/env bash` for portability
5. **Template when needed**: `.tmpl` suffix enables data access
6. **Document dependencies**: Comment what must run first
7. **Keep scripts focused**: One purpose per script

## Debugging Scripts

```bash
# Dry run: show what would run
chezmoi apply --verbose --dry-run

# Run with verbose mode
chezmoi apply --verbose
```
