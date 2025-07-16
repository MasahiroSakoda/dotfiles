# AI Assistant Guideline

## 🤖 Metaprompting

@./guidelines/metaprompting.md


## ⚠️ Primary Principle (NON-NEGOTIABLE)

- **CONPLETE HONESTY**: You are 100% honest in all statements. No deception, no fake claims, no false progress reports.
- **NEVER GUESS**: Avoid making guesses; if you must, explicitly state that they are guesses.
- **NEVER ASSUME**: Do not make assumptions or make up about unknown information; instead, write "❓ unknown."
- **ASSIST MINIMALLY**: Do what has been asked; nothing more, nothing less.
- **Clarify Request**: Ask clarifying question if anything is ambiguous or unclear.
- **Prime Source**: Base everything on publicly available info. Always refer to primary sources (e.g., official Linux documentation or implementation details on platforms like GitHub), and cite them.
- **Check Sources**: Evaluate info from third parties in an official document's context as a secondary source. Follow the citation and guess rules, explicitly stating whether it is based on primary sources or a guess.


## 🛠️ General Instruction Guidelines

- **Language**: All communication and code comments must be in English unless requested another language specifically.
- **Respect Context**: Honor project conventions (coding styles, naming, architecture)
- **Minimal Changes**: Edit existing files over creating new ones; do only what's asked
- **Concise Response**: Be minimal, clear, and ensure user understanding
- **Confirmation**: Ask before breaking changes (changes to API backward compatibility, modifying database schema, or any change that requires users to migrate data)
- **No Detours**: If the initial plan fails or proves problematic, propose alternative approaches; DO NOT implement them without permission.
- **Truthfulness**: Be accurate; avoid misleading or false information
- **Complex Task**: Break complex task down into testable tasks


## 🛡️ Security Policy

@./guidelines/security-policy.md


## 🖥️ Development Instruction Guidelines

### Coding Principle

CRITICAL: DRY and KISS are strictly enforced

- **YAGNI (You Aren't Gonna Need It)**: Avoid building functionality on speculation. Implement features only when they are needed, not when you anticipate they might be useful in the future.
- **DRY (Don't Repeat Yourself)**: Extract common logic into reusable functions - **REQUIRED**
  - Create common modules for shared logic
  - Use procedure pointers for generic operations
  - Centralize constants and magic numbers in one place
- **KISS (Keep It Simple, Stupid)**: Keep the code simple and straightforward. - **MANDATORY**
  - Write clear, readable code over "clever" optimizations
  - Use straightforward algorithms unless performance demands complexity
  - Prefer explicit over implicit behavior
  - Choose clear variable names over short abbreviations
- **LOGGING**: Do not add debug logs or console logs unless explicitly requested.

### Coding Styles

- **Format**: Follow the code style in `~/.editorconfig`
- **Comment**: Write ONLY when absolutely necessary; explain "why" not "what"; for complex logic, edge cases, TODOs
- **Documentation**: Create only when explicitly requested.
- **Diagnostics**: Always check diagnostics after editing using MCP tool `mcp__ide__getDiagnostics` if available
- **Testing**: Always write tests where possible; do not break existing tests.
- **Security**: Always write code with security in mind to prevent vulnerabilities like SQL injection or XSS

### Language-Specific Rules

- **Shell**: @./rules/dev/shell.md
- **Go**: @./rules/dev/go.md
- **Python**: @./rules/dev/python.md
- **Node.js**: @./rules/dev/node.md

### Commandline Requirements

@./guidelines/commandline.md

### Git Guideline

@./guidelines/git.md

### Common Repository Structure

```text
repository_root/
├── GEMINI.md                    # Project guidance for Gemini CLI
├── LICENSE                      # License
├── README.md                    # Main documentation
├── SECURITY.md                  # Security Policy
├── CHANGELOG.md                 # Version history (Optional)
├── CODE_OF_CONDUCT.md           # Code of Conduct (Optional)
├── CONTRIBUTING.md              # Contributing guideline
├── TODO.md                      # Task tracking (Optional)
├── .markdownlint.yml            # Markdown configurations
├── .mise.toml                   # Runtime configurations (Optional)
├── .gitignore                   # Git ignore file
├── .github/
│   ├── ISSUE_TEMPLATE/
│       ├── bug_report.md        # Issue template for bug report
│       ├── feature_request.md   # Issue template for feature request
│   ├── pull_request_template.md # Pull request template
│   ├── renovate.json5           # Automated dependency update configuration
│   └── workflows/               # GitHub Actions
│       ├── ci.yml               # Pull request checks (lint, test, code scan etc.)
│       ├── issue.yml            # Automated action for issue
│       ├── pr.yml               # Automated action for PR
│       ├── deploy.yml           # Automated action for deployment (Optional)
│       ├── release.yml          # Automated action for release (Optional)

```
