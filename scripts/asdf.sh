#!/usr/bin/env bash
set -e

PLUGINS="python ruby nodejs deno"

for PLUGIN in ${PLUGINS}; do
  # Install asdf plugin
  if asdf plugin list | rg ${PLUGIN} >/dev/null; then
    echo "asdf plugin \"${PLUGIN}\" is already installed"
  else
    asdf plugin add ${PLUGIN}
  fi

  # Install latest version
  asdf install ${PLUGIN} latest
  asdf global ${PLUGIN} "$(asdf latest ${PLUGIN})"
  # Disaplay plugin version
  echo "${PLUGIN} installed to $(which ${PLUGIN})"
  echo "$(${PLUGIN} --version)"
done
