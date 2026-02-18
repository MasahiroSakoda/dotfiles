## Process Overview
1. **Change Analysis**: Analyze the staged changes or provided diff
2. **Commit Type Classification**: Determine the appropriate conventional commit type
3. **Message Generation**: Create a clear, concise commit message with summary and details

## Step 0: Check for Staged

If files are staged, only work on those. If nothing is staged at the moment, exit command with warning messages.

## Step 1: Change Analysis

Analyze the changes by:
- Examining staged files using `git diff --staged` or provided diff
- Identifying the nature of changes (new features, bug fixes, refactoring, etc.)
- Determining the scope of changes (which modules/components are affected)
- Checking for breaking changes or significant modifications

## Step 2: Commit Type Classification

Classify changes using these conventional commit types:

### Standard Types

**feat**: New features or functionality

- Adding new user-facing features
- Implementing new API endpoints
- Creating new components or modules
- Examples: `feat: add user authentication`, `feat(api): implement payment processing`

**fix**: Bug fixes

- Resolving existing bugs or issues
- Fixing broken functionality
- Correcting validation errors
- Examples: `fix: resolve login validation error`, `fix(ui): correct button alignment`


**docs**: Documentation changes

- Updating README files
- Adding API documentation
- Improving code comments
- Examples: `docs: update API documentation`, `docs(readme): add installation instructions`

**style**: Code formatting and style changes (no functional changes)

- Fixing linting errors
- Adding missing semicolons
- Formatting code consistently
- Examples: `style: fix linting errors`, `style(components): add missing semicolons`

**refactor**: Code restructuring without new features or bug fixes

- Extracting functions or classes
- Simplifying code structure
- Improving code organization
- Examples: `refactor: extract utility functions`, `refactor(auth): simplify token validation`

**test**: Adding or modifying tests

- Adding unit tests
- Updating integration tests
- Fixing test failures
- Examples: `test: add unit tests for user service`, `test(e2e): update login flow tests`

**chore**: Maintenance tasks, dependency updates, build configuration

- Updating dependencies
- Configuring build tools
- General maintenance
- Examples: `chore: update dependencies`, `chore(build): configure webpack`

### Extended Types

**perf**: Performance improvements

- Optimizing algorithms
- Improving database queries
- Reducing bundle size
- Examples: `perf: optimize database queries`, `perf(ui): lazy load components`

**ci**: CI/CD configuration changes

- Adding GitHub Actions
- Updating build pipelines
- Configuring deployment
- Examples: `ci: add GitHub Actions workflow`, `ci(deploy): update production pipeline`

**build**: Build system or external dependencies

- Upgrading frameworks
- Changing build configuration
- Managing external dependencies
- Examples: `build: upgrade to Next.js 14`, `build(deps): update React to v18`

**revert**: Reverting previous commits

- Undoing previous changes
- Rolling back features
- Examples: `revert: "feat: add user authentication"`, `revert: "refactor: simplify API structure"`

### Breaking Changes

For breaking changes, add exclamationmark after the type:

- `feat!: change API response format`
- `refactor!: remove deprecated endpoints`
- `fix!: update user authentication flow`

## Step 3: Message Generation

### Message Format

Generate commits in this exact format:

```commit
<type>(<scope>): <summary>

<blank line>
• <detail point 1>
• <detail point 2>
• <detail point 3>
```

### Summary Line Guidelines

**Structure**: `<type>(<scope>): <summary>`

- **Type**: Use appropriate conventional commit type
- **Scope** (optional): Module, component, or area affected (e.g., `api`, `ui`, `auth`, `docs`)
- **Summary**: Concise description in imperative mood (50 characters max)

**Summary writing rules:**

- Use imperative mood ("add" not "added" or "adds")
- Start with lowercase letter
- No period at the end
- Be specific and actionable
- Focus on what the change does, not how

### Detail Points Guidelines

**Two blank lines after summary, then bullet points:**

- Use bullet points (`•`) for each detail
- Each point should be a complete, clear sentence
- Focus on the "what" and "why" of changes
- Include technical details that aren't obvious from the summary
- Mention affected files or components if relevant
- Explain breaking changes or migration steps if applicable

### Examples

```commit
feat(auth): add JWT token refresh mechanism

• Implement automatic token refresh before expiration
• Add refresh token storage in secure HTTP-only cookies
• Create middleware to handle token refresh on API calls
• Update login flow to return both access and refresh tokens
```

```commit
fix(api): resolve user data validation error

• Fix email validation regex to accept international domains
• Add proper error handling for malformed request bodies
• Update user schema to require phone number format validation
```

```commit
refactor(components): extract reusable UI components

• Move Button, Input, and Modal components to shared library
• Standardize prop interfaces across all UI components
• Update all consuming components to use new shared components
```

## Implementation Process

1. **Analyze changes**: Use `git diff --cached` to see staged changes
2. **Identify patterns**: Look for common themes in the changes
3. **Determine type**: Choose the most appropriate conventional commit type
4. **Identify scope**: Determine the affected module or component
5. **Write summary**: Create clear, imperative summary under 50 characters
6. **Add details**: Provide 2-4 bullet points explaining the changes
7. **Review for breaking changes**: Add exclamationmark if changes are breaking

## Quality Checklist

Before presenting the commit message, ensure:

- [ ] Appropriate conventional commit type is used
- [ ] Scope accurately reflects affected areas
- [ ] Summary is under 50 characters and imperative mood
- [ ] Two blank lines separate summary from details
- [ ] 2-4 clear bullet points explain the changes
- [ ] Breaking changes are marked with exclamationmark if applicable
- [ ] Message explains both what and why
- [ ] Technical details are clear and specific

## Commit Process

1. **Display suggestions**: in proper format
2. **Display Explanation** of why this type and scope were chosen
3. **Alternative suggestions** if multiple types could apply
4. **Ask user to execute commit command**: Ask user to execute commit command with following choices.
- Choice 1: Suggested commit message
- Choice 2: Alternative suggestions
- Choice 3: Cancel commiting (Display suggestion only)
5. **Commit**: Execute commit with selected commit message unless cancel selected.

## Output Format

Present:

1. **Executed commit message** in proper format
2. **Commit Detail**: hash, author, date

If no changes are staged, provide instructions to stage changes first.

Execute this process systematically to generate conventional commit messages that improve project history readability and enable automatic versioning.
