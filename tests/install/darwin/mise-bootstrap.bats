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

# Settings-only global config, so the real one cannot leak preferences into the
# status below.
isolated_mise_config() {
  printf '[settings]\n' >"$BATS_TEST_TMPDIR/global.toml"
}

# The [bootstrap.macos] preferences mise resolves, one per line, as
# "<domain> <host> <key>".
macos_defaults() {
  isolated_mise_config
  MISE_TRUSTED_CONFIG_PATHS="$BATS_TEST_TMPDIR" \
    MISE_GLOBAL_CONFIG_FILE="$BATS_TEST_TMPDIR/global.toml" \
    mise -C "$BATS_TEST_TMPDIR" bootstrap macos defaults status --json |
    jq -r '.macos_defaults.entries[] | "\(.domain) \(.host) \(.key)"'
}

# Domains declared under [bootstrap.macos.defaults], e.g. com.apple.finder.
macos_default_domains() {
  yq -p toml -o=json '."bootstrap"."macos"."defaults" | keys | .[]' "$rendered_config" | tr -d '"'
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

@test "mise bootstrap manages every declared macOS preference domain" {
  skip_if_no_command mise

  local -a domains
  run macos_default_domains
  assert_success
  refute_output ""
  domains=("${lines[@]}")

  run macos_defaults
  assert_success

  local domain
  for domain in "${domains[@]}"; do
    assert_line --partial "${domain} "
  done
}

# A misspelled key in a named section is silently ignored by mise, so assert
# each one expands to the preference it is supposed to.
@test "mise bootstrap maps the named macOS sections to their defaults keys" {
  skip_if_no_command mise

  run macos_defaults
  assert_success

  assert_line "NSGlobalDomain any KeyRepeat"
  assert_line "NSGlobalDomain any InitialKeyRepeat"
  assert_line "com.apple.AppleMultitouchTrackpad any TrackpadThreeFingerDrag"
  assert_line "com.apple.driver.AppleBluetoothMultitouch.trackpad any TrackpadThreeFingerDrag"
  assert_line "com.apple.finder any AppleShowAllFiles"
  assert_line "com.apple.finder any ShowPathbar"
  assert_line "com.apple.finder any ShowStatusBar"
  assert_line "com.apple.finder any _FXSortFoldersFirst"
  assert_line "com.apple.dock any orientation"
  assert_line "com.apple.dock any autohide"
  assert_line "com.apple.dock any autohide-delay"
  assert_line "com.apple.dock any show-recents"
}

@test "mise bootstrap targets the current host for -currentHost preferences" {
  skip_if_no_command mise

  run macos_defaults
  assert_success
  assert_line "com.apple.ImageCapture current disableHotPlug"
}

@test "mise bootstrap restarts the apps that cache preferences" {
  run yq -p toml -o=json '."bootstrap"."hooks"."post-defaults"."run"' "$rendered_config"
  assert_success
  assert_output --partial "killall"

  local app
  for app in Finder Dock SystemUIServer; do
    assert_output --partial "$app"
  done
}

# -*-mode:sh-*- vim:ft=sh
