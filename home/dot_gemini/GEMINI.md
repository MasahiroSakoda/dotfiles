# AI Assistant Guideline

## 🤖 Metaprompting

@~/.gemini/guidelines/metaprompting.md

## ⚠️ Primary Principle (NON-NEGOTIABLE)

@~/.gemini/guidelines/primary-principle.md

## 🛠️ General Instruction Guidelines

@~/.gemini/guidelines/general-instruction.md

## 🛡️ Security Policy

@~/.gemini/guidelines/security-policy.md

## 🖥️ Development Instruction Guidelines

### 💡 Coding Principle

@~/.gemini/guidelines/coding-principle.md

### 🎨 Coding Styles

@~/.gemini/guidelines/coding-styles.md

### 🔡 Language-Specific Rules

- **Shell**: @~.gemini/rules/dev/shell.md
- **Go**: @~/.gemini/rules/dev/go.md
- **Python**: @~/.gemini/rules/dev/python.md
- **Node.js**: @~/.gemini/rules/dev/node.md
- **TypeScript**: @~/.gemini/rules/dev/typescript.md

### Commandline Requirements

@~/.gemini/guidelines/commandline.md

### Git Guideline

@~/.gemini/guidelines/git.md

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
