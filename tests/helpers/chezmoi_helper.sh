#!/usr/bin/env bash

# Bats helper: assert the state attributes chezmoi will write for a managed
# target, as produced by `chezmoi dump`. Each keyword names the source-state
# attribute whose effect it checks.
#
#   assert_chezmoi_attr "$HOME/.claude/settings.json" private
#   assert_chezmoi_attr .config/zsh/.zlogin symlink linkname:zlogin
#   assert_chezmoi_attr .claude/hooks dir perm:0755
#
# A relative path is resolved against the destination directory, $HOME by
# default. Assertions, all of which must hold:
#
#   private      no group or world permissions        private_
#   readonly     no write permissions                 readonly_
#   executable   owner execute bit set                executable_
#   symlink      target is a symlink                  symlink_
#   file         target is a regular file
#   dir          target is a directory
#   perm:<mode>  exact permissions, octal             perm:0600
#   linkname:<t> exact symlink target                 linkname:zlogin
#
# dot_, empty_, create_, and exact_ change which targets exist rather than
# how they are written, so assert those with chezmoi managed.

assert_chezmoi_attr() {
  local target="${1:-}"
  local status output type perm linkname="" assertion expected
  local -a assertions=()

  if [ "$#" -gt 0 ]; then shift; fi
  assertions=("$@")

  if [ -z "$target" ]; then
    echo "assert_chezmoi_attr: target path is required" >&2
    return 2
  fi

  if [ "${#assertions[@]}" -eq 0 ]; then
    echo "assert_chezmoi_attr: at least one assertion is required" >&2
    return 2
  fi

  case "$target" in
  /*) ;;
  *) target="${HOME%/}/$target" ;;
  esac

  for assertion in "${assertions[@]}"; do
    case "$assertion" in
    private | readonly | executable | symlink | file | dir | perm:* | linkname:*) ;;
    *)
      echo "assert_chezmoi_attr: unknown assertion: $assertion" >&2
      return 2
      ;;
    esac
  done

  skip_if_no_chezmoi_data
  skip_if_no_command chezmoi
  skip_if_no_command jq

  # --recursive=false keeps the dump to the target itself, so asserting on a
  # directory does not pick up its children.
  run chezmoi dump --format=json --recursive=false "$target"
  if [ "$status" -ne 0 ]; then
    echo "assert_chezmoi_attr: chezmoi does not manage $target: $output" >&2
    return 1
  fi

  # The dump is keyed by target name; the entry itself is the value.
  read -r type perm <<<"$(jq -r 'to_entries[0].value | [.type, (.perm // 0)] | join(" ")' <<<"$output")"

  for assertion in "${assertions[@]}"; do
    case "$assertion" in
    private)
      if ((perm & 077)); then
        echo "assert_chezmoi_attr: $target is not private: $(printf '0%o' "$perm")" >&2
        return 1
      fi
      ;;
    readonly)
      if ((perm & 0222)); then
        echo "assert_chezmoi_attr: $target is not readonly: $(printf '0%o' "$perm")" >&2
        return 1
      fi
      ;;
    executable)
      if ((! (perm & 0100))); then
        echo "assert_chezmoi_attr: $target is not executable: $(printf '0%o' "$perm")" >&2
        return 1
      fi
      ;;
    symlink)
      if [ "$type" != "symlink" ]; then
        echo "assert_chezmoi_attr: $target is a $type, not a symlink" >&2
        return 1
      fi
      ;;
    file | dir)
      if [ "$type" != "$assertion" ]; then
        echo "assert_chezmoi_attr: $target is a $type, not a $assertion" >&2
        return 1
      fi
      ;;
    perm:*)
      expected="${assertion#perm:}"
      if [ -n "${expected//[0-7]/}" ] || [ -z "$expected" ]; then
        echo "assert_chezmoi_attr: invalid octal mode: $expected" >&2
        return 2
      fi
      if [ "$perm" != "$((8#$expected))" ]; then
        echo "assert_chezmoi_attr: $target has mode $(printf '0%o' "$perm"), not $expected" >&2
        return 1
      fi
      ;;
    linkname:*)
      linkname="$(jq -r 'to_entries[0].value.linkname // ""' <<<"$output")"
      expected="${assertion#linkname:}"
      if [ "$linkname" != "$expected" ]; then
        echo "assert_chezmoi_attr: $target points at '$linkname', not '$expected'" >&2
        return 1
      fi
      ;;
    esac
  done
}

# -*-mode:sh-*- vim:ft=sh.gotexttmpl
