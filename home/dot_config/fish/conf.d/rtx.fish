# -*-mode:fish-*- vim:ft=fish

set -gx RTX_DEBUG 0
set -gx RTX_DATA_DIR "$XDG_DATA_HOME/rtx"
set -gx RTX_CONFIG_FILE "$XDG_CONFIG_HOME/rtx/config.toml"
set -gx RTX_TRUSTED_CONFIG_PATHS "$RTX_CONFIG_FILE"

type -q rtx && rtx activate fish | source && rtx completion fish | source

set -gx RTX_LOG_LEVEL info # Usage: trace|debug|info|warn|error
set -gx RTX_FETCH_REMOTE_VERSIONS_TIMEOUT "1800 s"
