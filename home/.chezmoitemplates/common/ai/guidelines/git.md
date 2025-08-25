# Git Guideline

## Commit Strategy

- **Commit Format**: Use [Commitizen](https://github.com/commitizen/cz-cli) for Conventional Commits
- **Commit Message**: Short, descriptive title followed by bullet points for details
- **Commit Granularity**: Make appropriately sized commits - not too large, not too small

## Branch Strategy

- `main`: Production-ready releases
- **Branch Protection**: NEVER commit or push to `main` branch without permission
- **Branch Naming**: `{branch-type}/{issue-number}-{slug-title}`
  - **Branch Types**: `feat/`, `fix/`, `refactor/`, `docs/`, `chore/`
- **Branch Creation**: For each plan, create a new branch from `main` with an appropriate prefix (e.g. `feat/`, `fix/`, `chore/`)
