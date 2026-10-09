#!/usr/bin/env bats

load "../../helpers/test_helper.sh"
load "../../../.bats-libs/bats-assert/load"
load "../../../.bats-libs/bats-support/load"

setup() {
  bats_require_minimum_version 1.7.0
  common_setup
  skip_if_no_chezmoi_data
  skip_if_no_command chezmoi
  skip_if_no_command jq
  skip_if_no_command yq

  MISE_CONFIG="${HOME_SRC}/dot_config/mise/config.toml.tmpl"
  rendered_config="${BATS_TEST_TMPDIR}/bootstrap.toml"
}

# chezmoi has no flag to render for another OS, so rewrite the OS guards inside
# the [bootstrap.packages] block and render just that block. The range is
# scoped to the section because the template has an unrelated darwin-only guard
# earlier on. The block is the last table in the file, so it runs to the end.
render_bootstrap() {
  local os="$1" os_release="$2"

  sed -n '/^\[bootstrap\.packages\]/,$p' "$MISE_CONFIG" |
    sed -e "s/\\.chezmoi\\.osRelease\\.id/\"${os_release}\"/g" \
      -e "s/\\.chezmoi\\.os/\"${os}\"/g" |
    chezmoi execute-template >"$rendered_config"
}

# Keys under [bootstrap.packages] of the rendered block, e.g. apt:wget.
bootstrap_packages() {
  yq -p toml -o=json '."bootstrap"."packages" | keys | .[]' "$rendered_config" | tr -d '"'
}

# Prints declared packages that mise bootstrap would never install.
missing_packages() {
  local prefix="$1" filter="$2"
  comm -23 \
    <(chezmoi data --format=json | jq -r "$filter" | sed "s/^/${prefix}/" | sort -u) \
    <(bootstrap_packages | sort -u)
}

# Prints keys in the rendered block that are not pinned to latest.
unpinned_packages() {
  yq -p toml -o=json \
    '."bootstrap"."packages" | to_entries | .[] | select(.value != "latest") | .key' \
    "$rendered_config"
}

@test "apt branch declares every Debian package" {
  render_bootstrap linux debian

  run missing_packages "apt:" ".packages.apt[][]"
  assert_success
  assert_output ""
}

@test "apt branch pins every package to latest" {
  render_bootstrap linux debian

  run unpinned_packages
  assert_success
  assert_output ""
}

@test "pacman branch declares every Arch package" {
  render_bootstrap linux arch

  run missing_packages "pacman:" ".packages.pacman[][]"
  assert_success
  assert_output ""
}

@test "pacman branch pins every package to latest" {
  render_bootstrap linux arch

  run unpinned_packages
  assert_success
  assert_output ""
}

@test "unknown Linux distro declares no packages and asks for a branch" {
  render_bootstrap linux fedora

  run grep '^## Unknown Linux distro: fedora' "$rendered_config"
  assert_success

  run bootstrap_packages
  assert_success
  assert_output ""
}

# -*-mode:sh-*- vim:ft=sh
