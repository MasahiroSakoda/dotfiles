# OpenCode Global Configuration

## Directory Structure

```text
opencode/
├── agents/                # Custom specialized agent collection
├── commands/              # Custom Slash Commands
├── plugins/               # Plugins for extending OpenCode
├── rules/                 # Instructions for specific usage
├── skills/                # Custom Skills
├── AGENTS.md              # Project context for all agents
├── config.json            # Main configuration (theme, plugins, models, LSP, MCP)
├── oh-my-opencode.json    # Oh-my-OpenCode config file
└── README.md              # This file
```

## Plugins

| Plugin        | Description                        |
| :------------ | :--------------------------------- |
| Notification  | Plugin enables sound notifications |
| Limits        | Plugin to display token usage      |
| DamageControl | Plugin to ensure security          |


## Agents

### Custom Agents

| Agent         | Description                             |
| :------------ | :-------------------------------------- |
| `@auditor`    | Security Auditor                        |
| `@translator` | Language translation and localization   |
| `@triager`    | Issue triage agent for managing backlog |

> Docs: [https://opencode.ai/docs/agents](https://opencode.ai/docs/agents)


## Commands

| Command          | Description                                               |
| :--------------- | :-------------------------------------------------------- |
| `/git:commit`    | Generate conventional commit message from staged changes. |
| `/git:changelog` | Generaete current branch changelog.                       |

> Docs: [https://opencode.ai/docs/commands](https://opencode.ai/docs/commands)


## Skills

| Skill         | Description                                                                |
| :------------ | :------------------------------------------------------------------------- |
| `superpowers` | An agentic skills framework & software development methodology that works. |

## Permissions

Three permission levels: `"allow"` | `"ask"` | `"deny"`

> Docs: [https://opencode.ai/docs/permissions](https://opencode.ai/docs/permissions)
