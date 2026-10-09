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
  rendered_config="${BATS_TEST_TMPDIR}/mise.toml"

  run chezmoi execute-template <"${MISE_CONFIG}"
  assert_success
  printf '%s\n' "$output" >"$rendered_config"
}

# Keys under [bootstrap.packages] in the rendered mise config, e.g. brew:wget.
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

@test "mise bootstrap declares a non-empty package set" {
  run bootstrap_packages
  assert_success
  refute_output ""
}

@test "mise bootstrap declares every Homebrew formula" {
  run missing_packages "brew:" ".packages.brew[][]"
  assert_success
  assert_output ""
}

@test "mise bootstrap declares every Homebrew cask" {
  run missing_packages "brew-cask:" ".packages.cask[][]"
  assert_success
  assert_output ""
}

@test "mise bootstrap declares every Mac App Store app" {
  run missing_packages "mas:" ".packages.mas[] | .id"
  assert_success
  assert_output ""
}

@test "mise bootstrap pins every package to latest" {
  run yq -p toml -o=json '."bootstrap"."packages" | to_entries | .[] | select(.value != "latest") | .key' "$rendered_config"
  assert_success
  assert_output ""
}

# -*-mode:sh-*- vim:ft=sh
