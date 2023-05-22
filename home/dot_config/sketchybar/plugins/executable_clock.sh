#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -e

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set $NAME label="$(date '+%d/%m %H:%M')"
