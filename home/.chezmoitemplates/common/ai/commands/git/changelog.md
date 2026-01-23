## Process Overview

1. ** Check the Branches**: Execute diff only default branch and current branch.
2. **Commit Log Analysis**: Analyze the commit log with `git` command
3. **Changelog Generation**: Create changelog with commit message and extendable details

## Changelog Workflows

### Step 1: Check the Branches

Work on branches other than `main` or `master`. Otherwise, exit command with warning message.

1. Get the default branch name using `git remote show origin | grep 'HEAD branch' | awk '{print $NF}'`
2. Get the current branch name using `git branch --show-curreht`

### Step 2: Commit Log Analysis

- Get the commit log using `git log {default_branch}..{current_branch}`

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
<summary>[commit hash](commit link) <type>(<scope>)!: <commit message></summary>
- Commit detail #1
- Commit detail #2
...
</details>

#### 🎉 New Features

<details>
<summary>[commit hash](commit link) feat(<scope>): <commit message></summary>
- Commit detail #1
- Commit detail #2
...
</details>

#### 🐞 Bug Fixes

<details>
<summaary>[commit hash](commit link) fix(<scope>): <commit message></summaary>
- Commit detail #1
- Commit detail #2
...
</details>

#### Other Changes

<details>
<summary>[commit hash](commit link) <type>(<scope>): <commit message></summary>
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
- **Other Changes**:  Changes not belonging to the above items like `chrore`, `refactor`, `docs`.

### Step 4: Quality Check

Before presenting the changelog, ensure:

- [ ] Keep bullet points scannable (one line each) in "What's Changed"
- [ ] Categorize commits where it should be.
- [ ] Check the link for commit

## Output Format

1. **Suggested changelog**: in proper markdown format
2. **Command to paste to clipboard**:

DO NOT change or write any files even draft. Your task is suggestion only.
