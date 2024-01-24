#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -eo pipefail

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --verbose --apply MasahiroSakoda
