#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../../.bats-libs/bats-assert/load"
load "../../../.bats-libs/bats-support/load"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
  skip_if_no_chezmoi_data
  skip_if_no_command chezmoi
  skip_if_no_command yq

  MISE_CONFIG="${HOME_SRC}/dot_config/mise/config.toml.tmpl"
  rendered_config="${BATS_TEST_TMPDIR}/bootstrap.toml"
}

# chezmoi has no flag to render for another OS, so rewrite the OS guards in the
# template and render the whole file. Rendering everything rather than just
# [bootstrap.packages] is deliberate: a guard that swallows a newline breaks
# TOML validity, and the yq calls below are what catch it.
render_bootstrap() {
  local os="$1" os_release="$2"

  sed -e "s/\\.chezmoi\\.osRelease\\.id/\"${os_release}\"/g" \
    -e "s/\\.chezmoi\\.os/\"${os}\"/g" \
    "$MISE_CONFIG" |
    chezmoi execute-template >"$rendered_config"
}

# Keys under [bootstrap.packages] of the rendered config, e.g. apt:wget.
bootstrap_packages() {
  yq -p toml -o=json '."bootstrap"."packages" | keys | .[]' "$rendered_config" | tr -d '"'
}

# System package managers mise is told to use, e.g. apt. Empty when the branch
# declares none.
system_package_managers() {
  yq -p toml -o=json '."settings"."system_packages"."managers" // [] | .[]' "$rendered_config" | tr -d '"'
}

# Prints keys in the rendered config that are not pinned to latest.
unpinned_packages() {
  yq -p toml -o=json \
    '."bootstrap"."packages" | to_entries | .[] | select(.value != "latest") | .key' \
    "$rendered_config"
}

@test "apt branch pins every package to latest" {
  render_bootstrap linux debian

  run unpinned_packages
  assert_success
  assert_output ""
}

@test "pacman branch pins every package to latest" {
  render_bootstrap linux arch

  run unpinned_packages
  assert_success
  assert_output ""
}

@test "apt branch declares the apt system package manager" {
  render_bootstrap linux debian

  run system_package_managers
  assert_success
  assert_line "apt"
}

@test "pacman branch declares the pacman system package manager" {
  render_bootstrap linux arch

  run system_package_managers
  assert_success
  assert_line "pacman"
}

@test "unknown Linux distro declares no packages and no system package managers" {
  render_bootstrap linux fedora

  run bootstrap_packages
  assert_success
  assert_output ""

  run system_package_managers
  assert_success
  assert_output ""
}

# -*-mode:sh-*- vim:ft=sh
