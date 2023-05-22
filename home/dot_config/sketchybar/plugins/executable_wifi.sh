#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -e

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

WIFI=${INFO:-"Not Connected"}

sketchybar --set $NAME label="${WIFI}"
