#!/usr/bin/env bash

coloredEcho() {
  local exp=$1;
  local color=$2;
  local allow=$3;

  if ! [[ $color =~ '^[0-9]$' ]] ; then
    case $(echo $color | tr '[:upper:]' '[:lower:]') in
      black)   color=0 ;;
      red)     color=1 ;;
      green)   color=2 ;;
      yellow)  color=3 ;;
      blue)    color=4 ;;
      magenta) color=5 ;;
      cyan)    color=6 ;;
      white|*) color=7 ;;
    esac
  fi

  tput bold;
  tput setaf "$color";
  echo "$arrow $exp";
  tput sgr0;
}

info() {
  coloredEcho "$1" blue "========>"
}

success() {
  coloredEcho "$1" green "========>"
}

error() {
  coloredEcho "$1" red "========>"
}

substep_info() {
  coloredEcho "$1" magenta "===="
}

substep_success() {
  coloredEcho "$1" cyan "===="
}

substep_error() {
  coloredEcho "$1" red "===="
}
