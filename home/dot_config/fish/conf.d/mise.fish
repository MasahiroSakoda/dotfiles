# -*-mode:fish-*- vim:ft=fish

set -gx MISE_DEBUG 0
set -gx MISE_DATA_DIR "$XDG_DATA_HOME/mise"
set -gx MISE_CONFIG_FILE "$XDG_CONFIG_HOME/mise/config.toml"
set -gx MISE_TRUSTED_CONFIG_PATHS "$MISE_CONFIG_FILE"

type -q mise && mise activate fish | source && mise completion fish | source

set -gx MISE_LOG_LEVEL info # Usage: trace|debug|info|warn|error
set -gx MISE_FETCH_REMOTE_VERSIONS_TIMEOUT "1800 s"
