# -*-mode:fish-*- vim:ft=fish

set -gx RTX_DATA_DIR "$XDG_DATA_HOME/rtx"
set -gx RTX_CONFIG_FILE "$XDG_CONFIG_HOME/rtx/config.toml"

type -q rtx && rtx activate fish | source && rtx completion fish | source
