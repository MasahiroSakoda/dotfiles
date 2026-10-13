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
  LINUX_PACKAGES="${HOME_SRC}/.chezmoitemplates/linux/mise-packages.toml.tmpl"
  rendered_config="${BATS_TEST_TMPDIR}/bootstrap.toml"
  rendered_packages="${BATS_TEST_TMPDIR}/packages.toml"
}

# chezmoi has no flag to render for another OS, so rewrite the OS guards in the
# template and render the whole file. Rendering everything rather than just
# [settings.system_packages] is deliberate: a guard that swallows a newline
# breaks TOML validity, and the yq calls below are what catch it.
rewrite_os_guards() {
  local os="$1" os_release="$2" file="$3"

  sed -e "s/\\.chezmoi\\.osRelease\\.id/\"${os_release}\"/g" \
    -e "s/\\.chezmoi\\.os/\"${os}\"/g" \
    "$file"
}

render_bootstrap() {
  local os="$1" os_release="$2"

  rewrite_os_guards "$os" "$os_release" "$MISE_CONFIG" |
    chezmoi execute-template >"$rendered_config"
}

# [bootstrap.packages] is pulled in by includeTemplate, which chezmoi renders
# with the real host values, so the guards in the partial have to be rewritten
# before rendering as well. Otherwise the darwin packages leak into every
# simulated Linux render.
render_packages() {
  local os="$1" os_release="$2"

  {
    printf '[bootstrap.packages]\n'
    rewrite_os_guards "$os" "$os_release" "$LINUX_PACKAGES"
  } | chezmoi execute-template >"$rendered_packages"
}

# Keys under [bootstrap.packages] of the rendered packages, e.g. apt:wget.
bootstrap_packages() {
  yq -p toml -o=json '."bootstrap"."packages" | keys | .[]' "$rendered_packages" | tr -d '"'
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
    "$rendered_packages"
}

@test "apt branch pins every package to latest" {
  render_packages linux debian

  run unpinned_packages
  assert_success
  assert_output ""
}

@test "pacman branch pins every package to latest" {
  render_packages linux arch

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
  render_packages linux fedora

  run bootstrap_packages
  assert_success
  assert_output ""

  run system_package_managers
  assert_success
  assert_output ""
}

# -*-mode:sh-*- vim:ft=sh
