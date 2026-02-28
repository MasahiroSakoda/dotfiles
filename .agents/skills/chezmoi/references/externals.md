# Externals

Externals fetches file, archives, and repositories from URLs as if they were part of the source state. Declared in files under `home/.chezmoiexternals/`.

## Resource Types

| Type       | Description                                         |
|:-----------|:----------------------------------------------------|
| `file`     | Download single file                                |
| `archive`  | Download and extract an archive (tar.gz, zip, etc.) |
| `git-repo` | Clone a git repository                              |


## Common Options

| Option           | Type   | Required | Description                                           |
|:-----------------|:-------|:---------|:------------------------------------------------------|
| `type`           | string | YES      | One of: `file`, `archive`, `archive-file`, `git-repo` |
| `url`            | string | YES      | URL to download (supports templates)                  |
| `refreshPeriod`  | string | NO       | How often to re-download (e.g., `"168h"` = weekly)    |
| `executable`     | bool   | NO       | Add `executable_` attribute to file                   |
| `private`        | bool   | NO       | Add `private_` attribute to file                      |
| `readonly`       | bool   | NO       | Add `readonly_` attribute to file                     |
| `encrypted`      | bool   | NO       | Whether the downloaded content is encrypted           |
| `filter.command` | string | NO       | Filter command to pipe content through                |
| `filter.args`    | list   | NO       | Arguments for filter command                          |


## File Options

Use file template function to reuse configuration

```toml
{{- define "file" }}
type = "file"
executable = true
stripComponents = 1
refreshPeriod = "168h"
{{- end }}

[".local/share/zellij/plugins/zellij-autolock.wasm"]
{{ template "file" }}
url = "https://github.com/fresh2dev/zellij-autolock/releases/latest/download/zellij-autolock.wasm"
```

## Repository Options

Use repo template to reuse configuration

```toml
{{- define "repo" }}
type = "git-repo"
exact = true
stripComponents = 1
refreshPeriod = "168h"
{{- end }}

["~/workspace/github.com/obra/superpowers"]
{{ template "repo" }}
url = "https://github.com/obra/superpowers"
```

## Archive Options

NOTE: **DON'T USE** `gitHubReleaseAssetURL` or `gitHubLatestReleaseAssetURL`. which is too slow to execute

```toml
{{- define "archive" }}
type = "archive"
refreshPeriod = "168h"
{{- end }}

[".local/share/fonts/JetBrainsMono"]
{{ template "archive" }}
url = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
```
