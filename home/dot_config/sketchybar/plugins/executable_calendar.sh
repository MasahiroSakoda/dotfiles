#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -e

sketchybar --set $NAME icon="$(date '+%a %d. %b')" label="$(date '+%H:%M')"
