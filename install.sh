#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -e

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --verbose --apply MasahiroSakoda
