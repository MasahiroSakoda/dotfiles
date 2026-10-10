# Architecture

chezmoi dotfiles repo. One machine's whole home directory, declared as
**converged** state: chezmoi replays it into `$HOME` on every `apply`. Nothing
here is a running service — there is no daemon, no server, no request path.
The only control flow is the **apply pipeline**, and it is owned by chezmoi,
not by this repo. This repo owns *what converged state looks like*.

## Layers

| Layer | Lives in | Job |
|---|---|---|
| Bootstrap | `install.sh`, `.chezmoiroot` | one-liner `chezmoi init --apply`; point chezmoi at `home/` |
| Feature flags + data | `home/.chezmoi.toml.tmpl` | the hub: flags, prompts, and every `[data]` key |
| Static data | `home/.chezmoidata/` | tool settings keyed by domain (`git.toml`, `ai/*.toml`) |
| Target state | `home/dot_*/`, `home/private_*/` | file tree, one path = one target under `$HOME` |
| Shared templates | `home/.chezmoitemplates/` | fragments included by many targets |
| Third-party sources | `home/.chezmoiexternals/` | git repos chezmoi vendors at `init` |
| Side effects | `home/.chezmoiscripts/` | 15 run scripts, the only imperative code |
| Verification | `tests/`, `.lefthook.yaml`, `.github/workflows/` | bats suite + linters, pre-commit and CI |
| Agent surface | `.agents/skills/`, `.opencode/`, `docs/agents/` | skills and process docs the harness loads |

## Apply pipeline

```text
install.sh ──> chezmoi init ──> reads .chezmoiroot (= home/)
                                  │
                                  ├─ renders home/.chezmoi.toml.tmpl ──> data hub
                                  ├─ reads   home/.chezmoidata/*.toml ──> adds keys
                                  ├─ fetches home/.chezmoiexternals/  ──> vendors repos
                                  │
                                  └─ apply ──> for each target path, in order:
                                                1. read source + merge .chezmoidata
                                                2. decrypt (encrypted_*.age) ──> age
                                                3. render template (.tmpl) ──> text/template
                                                4. write attrs (private_, symlink_, executable_)
                                                5. run home/.chezmoiscripts in order
```text

Two invariants worth keeping: **`run_` scripts are the only place with
imperative behavior**, and **ordering is encoded in the filename prefix**
(`run_once_before_00` → `run_once_after_24`), so sequence is visible in one
`ls` and needs no manifest.

## Naming is the API

Every source filename is a declaration. Read it left to right:

| Prefix / suffix | Meaning | Count |
|---|---|---|
| `dot_` | leading `.` | most of the tree |
| `private_` | target mode `0600` | 30 files, 9 dirs |
| `encrypted_` + `.age` | age-encrypted payload | 6 |
| `symlink_` | write a symlink, not a file | 10 |
| `executable_` | target mode `0755` | 14 |
| `run_once_` / `run_onchange_` | script, once ever / on content change | 15 |
| `.tmpl` | render as Go `text/template` | 189 |

`exact_`, `create_`, `modify_`, `remove_`, `empty_`, `readonly_` are declared in
the `.lefthook.yaml` exclude list but **unused** — do not infer a convention
from them. `home/.chezmoiremove.tmpl` is the one removal path: an XDG
legacy-cleanup ignore list, not a per-file attribute.

## Data hub

`home/.chezmoi.toml.tmpl` (135 lines) is both the chezmoi config file and the
primary data source. It emits:

- `[data]` — feature flags (`docker`, `ephemeral`, `flarm`, `headless`,
  `personal`, `graphics`, `cloud`, all default `false`), plus `hostname`,
  `osid`, `osicon`, `timezone`, `shell`, `brew_prefix`.
- `[data.git]` — `user`, `email`, `signingkey`, `ghq_root`.
- `[data.cmd]` — per-OS command names (copy/paste/pinentry/credential/open/player).
- `[data.mise]` — language `enabled` flags.

Flags are the branch selector: a script or template tests `.headless` /
`.personal` and takes a different path. Prompt-backed values
(`GIT_USERNAME`, `GIT_EMAIL`, `GIT_SIGNINGKEY`, `shell`, `timezone`) fall back
to env, then prompt — so **template output depends on the answering machine**,
which is why `chezmoi execute-template` is the debug entry point.

`home/.chezmoidata/` adds per-domain keys on top, notably `ai/providers.toml`
(7 providers), `ai/keybinds.toml`, `ai/mcp.toml`, `ai/permissions.toml`, and
`lsp.toml` (17 servers). `shell/` and `terminal/` exist but are empty.

## Target state

`home/dot_config/` holds 61 tool directories — the bulk of the repo, one dir
per CLI/editor. Machine-specific and secret material is separated three ways:

- `private_dot_{docker,gnupg,ssh}/`, `private_Library/` — 0600, never committed plaintext.
- `encrypted_*.tmpl.age` — ciphertext, decrypted by chezmoi at apply using
  `~/.config/chezmoi/key.txt`. That identity itself is `home/key.txt.age`,
  written by `run_once_after_02-decrypt-private-key.sh.tmpl`.
- `dot_config/private_{dlv,glow,karabiner}/` — config that is private but not secret.

`private_Library/` carries macOS-only targets (`Application Support/`,
`LaunchAgents/`); `dot_local/share/zerostack/` is the Linux-side twin of the
same config. The recipient in `.chezmoi.toml.tmpl:135` is fixed — changing it
is a re-encrypt of every `.age` file.

## Shared templates

`home/.chezmoitemplates/` (62 files) holds fragments that many targets include,
so behavior has one source of truth instead of a copy per target. Inclusion
is plain `{{ template "common/<name>" . }}`; three subtrees:

- `common/` (55) — `script_helper` defines the shell functions every run script
  uses (`command_exists`, `log_info`, …). `ai/` mirrors a cross-harness agent
  bundle (agents, commands, instructions, mcp, plugins, rules, sandbox).
- `darwin/` (6) and `linux/` (1) — **the OS branch mechanism**: one script
  includes both platform bodies and the irrelevant one no-ops.

Prefer adding to `common/` over inlining. A fragment that reaches for two
targets is a template; a fragment that reaches for one is a plain file.

## Scripts

All 15 live in `home/.chezmoiscripts/`, all bash, all `set -eo pipefail`, all
opened by including platform templates:

```text
before: 00-bootstrap        after: 00-homebrew  02-decrypt-private-key
        10-macos-system            10-fish  11-fisher  12-neovim  20-mise
onchange: 01-gh  03-docker  04-ide  21-python  22-ruby  23-nodejs  24-rust
```text

`run_once_before_00-bootstrap.sh.tmpl` installs Xcode CLT and Rosetta2 and
skips `softwareupdate` under `$GITHUB_ACTIONS`; `run_onchange_after_20-mise.sh.tmpl`
trusts the mise config and gates `mise install` on `not .headless`.

## Verification

`tests/` is bats-core, run by `.lefthook.yaml` on **every** pre-commit
(no glob, so it never skips):

```text
BATS_LIB_PATH="$PWD/.bats-libs" bats --pretty --jobs 4 --parallel-binary-name rush --recursive tests/
```text

`tests/install/common/*.bats` has one file per managed tool; `darwin/` and
`linux/` hold platform-specific suites. Two helpers carry the assertions:
`tests/helpers/chezmoi_helper.sh` (`assert_chezmoi_attr` reads `chezmoi dump`
output and asserts the attributes chezmoi *will* write) and `tests/helpers/test_helper.sh`
(`PROJECT_ROOT`, `HOME_SRC`, `skip_if_no_command`). `common/chezmoi.bats` is the
structural guard: `.chezmoiroot == home`, the config template exists, and every
`.chezmoidata/*.toml` and `.chezmoiscripts/*.sh.tmpl` referenced is present.

`.bats-libs/` holds the `bats-support` and `bats-assert` submodules, deliberately
outside `tests/` so `--recursive` does not collect them.

CI (`.github/workflows/`) runs labelers, `validate-title`, linters, and
actionlint/zizmor — **it does not run bats and does not run `chezmoi apply`**.
Behavioural verification is local-only; a change that breaks apply shows up in
the pre-commit suite or on the next real machine.

`.lefthook.yaml` excludes `**/symlink_*`, `**/modify_*`, `**/remove_*`, and
`.agents/skills/**` from linters, since template files are not valid in the
languages that lint them.

## Agent surface

`.agents/skills/` is the shared skill library every harness reads (chezmoi,
caveman*, cavecrew, grilling, domain-modeling). `.opencode/` holds opencode's
own agents, commands, plugins, and tools; `home/dot_claude/`,
`home/dot_codex/`, `home/dot_gemini/` install the per-harness bundles, with
`symlink_skills.tmpl` and `symlink_RTK.md.tmpl` pointing them back at the
canonical repo copies so there is one skill library, not four. `.claude/` and
`.codex/` at the repo root are empty and hold nothing.

`apm.yml` + `apm.lock.yaml` + `apm_modules/` are the APM (agent package
manager) layer: resolved, hash-verified dependencies pinned to an org allowlist
in `apm-policy.yml`, with `audit.on_install: block`.

`opencode.json` is the repo-scoped opencode config (permissions, agents, lsp,
mcp). `mise.toml` is `[settings]` + `[tools]` only — **no `[tasks]`**, so
mise is a tool installer here, not a task runner; hooks and tests are the
runner layer.

## Editing rules

- A behavior that belongs on several machines goes in `.chezmoitemplates/common/`.
- New data consumed by templates goes in `.chezmoidata/<domain>.toml`; new
  machine-wide flags go in `.chezmoi.toml.tmpl`'s `[data]`.
- Add a `tests/install/common/<tool>.bats` when adding a tool's config.
- Secrets: edit the plaintext source, re-encrypt to `.age`; the recipient is fixed.
- Paths are `$HOME`-relative in source; hardcoded `/Users/<name>` does not belong here.
