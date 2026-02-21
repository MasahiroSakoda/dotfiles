# Commands

## Essential Workflows

| Command                    | Description |
|:---------------------------|:------------|
| `chezmoi init [repository]`| Clone dotfiles repo, generate config from template. Use `--apply` to also apply |
| `chezmoi apply [target...]`| Apply source state to destination. No args = apply all |
| `chezmoi diff [target...]` | Show diff between target state and destination |
| `chezmoi edit [target...]` |  |
| `chezmoi update`           | Pull latest from repo + apply |
| `chezmoi cd`               |  |
| `chezmoi git [--args]`     |  |


## Adding files

| Command                               | Description                                  |
|:--------------------------------------|:---------------------------------------------|
| `chezmoi add [target]`                | Add targets to the source state              |
| `chezmoi add --template [target]`     | Add targets with template attribute          |
| `chezmoi add --encrypt [secrets]`     | Add targets with encrypt method              |
| `chezmoi add --recursive [directory]` | Add targets with recurse into subdirectories |


## Editing files

| Command                         | Description               |
|:--------------------------------|:--------------------------|
| `chezmoi edit [target]`         | Edit target in `$EDITOR`  |
| `chezmoi edit --apply [target]` | Edit target and apply     |
| `chezmoi edit-config-template`  | Edit `.chezmoi.toml.tmpl` |


## Changing file attributes

| Command                             | Description                        |
|:------------------------------------|:-----------------------------------|
| `chezmoi chattr +tempalte [target]` | Add template attribute to file     |
| `chezmoi chattr -tempalte [target]` | Remove template attribute to file  |


## Encrypt / Decrypt

| Command                    | Description            |
|:---------------------------|:-----------------------|
| `chezmoi encrypt [target]` | Encrypt file to stdout |
| `chezmoi decrypt [target]` | Decrypt file to stdout |
| `chezmoi age keygen`       | Generate age key pair  |


## Global Flags

| Flag                   | Description                         |
|:-----------------------|:------------------------------------|
| `--verbose`, `-v`      | Verbose output                      |
| `--debug`, `-d`        | Debug output                        |
| `--dry-run`, `-n`      | Dry run (no changes)                |
| `--interactive`        | Prompt for each change              |
| `--config <path>`      | Override config file path           |
| `--source <path>`      | Override source directory           |
| `--destination <path>` | Override destination directory      |
| `--color <option>`     | Color ouput                         |
| `--include <types>`    | Include only specified entry types  |
| `--exclude <types>`    | Exclude entry types from apply/diff |
