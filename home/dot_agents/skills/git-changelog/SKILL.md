---
allowed-tools: Bash(git log:*), Bash(remote show origin), Bash(git branch --show-current), Bash(awk:*), Grep
description: Generate changelog from current branch changes. Use when the user asks to write a changelog entry, fill the changelog section of a PR, or determine if changes are user-facing.
license: MIT
metadata:
    github-path: skills/git-changelog
    github-ref: refs/tags/v1.0.0
    github-repo: https://github.com/MasahiroSakoda/skills
    github-tree-sha: 1e255903d279f51fca0809b206573a19b68be956
name: git-changelog
---
# Changelog Generator

You are an AI assistant programmed to perform meticulous, context-aware changelog generations using the available tools.
Your task is to analyze commit log and generate properly formatted changelog that follows the markdown format.

## Command Execution Principle

- **Execute command exactly**: Do not pipe the command unless explicitly requested.

## Process Overview

1. **Commit Log Analysis**: Analyze the commit log with `git` command
2. **Changelog Generation**: Create changelog with commit message and extendable details

## Changelog Workflows

### Step 1: Check the Branches

Work on branches other than `main` or `master`. Otherwise, exit command with warning message.

```bash
DEFAULT_BRANCH=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "$DEFAULT_BRANCH" ]; then
  echo "🚨 On default branch — checkout branch first"
  exit 1
fi
```

### Step 2: Commit Log Analysis

- Get the commit log using `git log $DEFAULT_BRANCH..$CURRENT_BRANCH`

### Step 3: Message Generation

#### Changelog Format

```markdown
### Changelog

#### What's Changed

- Change summary #1
- Change summary #2
...

#### 🚨 Breaking Changes

<details>
<summary><type>(<scope>)!: <commit message> (<a href="commit link">commit hash</a>)</summary>

- Commit detail #1
- Commit detail #2
...
</details>

#### 🎉 New Features

<details>
<summary>feat(<scope>): <commit message> (<a href="commit link">commit hash</a>)</summary>

- Commit detail #1
- Commit detail #2
...
</details>

#### 🐞 Bug Fixes

<details>
<summary>fix(<scope>): <commit message> (<a href="commit link">commit hash</a>)</summary>

- Commit detail #1
- Commit detail #2
...
</details>

#### Other Changes

<details>
<summary><type>(<scope>): <commit message> (<a href="commit link">commit hash</a>)</summary>

- Commit detail #1
- Commit detail #2
...
</details>
```

#### Changelog Guidelines

- **What's changed**: Summarize point of changes in "What's changed"
- **Breaking Changes**: commit type contains `type(scope)!`
- **New Features**: commit type: `feat(scope):`
- **Bug Fixes**: commit type contains`fix(scope)`
- **Other Changes**: Changes not belonging to the above items like `chrore`, `refactor`, `docs`.
- **Commit Details**: Commit details should be separated by line breaks for each item.

### Step 4: Quality Check

Before presenting the changelog, ensure:

- [ ] Keep bullet points scannable (one line each) in "What's Changed"
- [ ] Categorize commits where it should be.
- [ ] Check the link for commit
- [ ] Check the break new line for each commit details

### Step 5: Paste changelog to clipboard

- Paste suggested changelog to clipboard with OS-specific copy command (e.g.: `pbcopy`)

## Output Format

1. **Suggested changelog**: in proper markdown format
2. **Display execution result to paste to clipboard**: Explain error details, if there are errors.

DO NOT change or write any files even draft. Your task is suggestion only.
