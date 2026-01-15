# OpenCode Global Configuration

## Directory Structure

```text
opencode/
├── agent/                 # Custom specialized agent collection
├── plugin/                # Plugins for extending OpenCode
├── commands/              # Custom Slash Commands
├── AGENTS.md              # Project context for all agents
├── config.json            # Main configuration (theme, plugins, models, LSP, MCP)
└── README.md              # This file
```

## Agents

### Primary Agents


| Agent | Model | Description |
|:------|:------|:------------|
| `conductor` | `google/antigravity-gemini-3-flash-pro` | Orchestrate all agents |
| `planner` | `google/antigravity-gemini-3-flash` | Strategic planning and architecture assistant |

### Sub Agents


| Agent | Model| Description |
|:----- |:------|:----------- |
| `@architect` | `google/antigravity-gemini-3-pro` | Software architect focused on system design |
| `@auditor` | `google/antigravity-gemini-3-pro` | Security Auditor |
| `@exlplorer` | `google/antigravity-gemini-3-flash` | Codebase Explorer |
| `@researcher` | `google/antigravity-gemini-3-flash` | External research and documentation |
| `@reviewer` | `google/antigravity-gemini-3-pro` | Reviews code changes in staged changes or remote PRs |
| `@translator` | `google/antigravity-gemini-3-flash` | Language translation and localization |
| `@triager` | `google/antigravity-gemini-3-flash` | Issue triage agent for managin backlog |

> Docs: [https://opencode.ai/docs/agents](https://opencode.ai/docs/agents)

## Custom Commands

| Command  | Description |
|:---------|:------------|
| `/explain:simple` | Explain mode (non-interactive) |
| `/explain:interactive` | Explain mode (interactive) |
| `/git:commit` | Generate conventional commit message from staged changes. |
| `/git:pr` | Create pull request for current branch |
| `/summarize` | Summarize |

> Docs: [https://opencode.ai/docs/commands](https://opencode.ai/docs/commands)

## Permissions

Three permission levels: `"allow"` | `"ask"` | `"deny"`

> Docs: [https://opencode.ai/docs/permissions](https://opencode.ai/docs/permissions)
