# Custom Scripts for Antigravity CLI

## Window Title

### Features

- **Path Formatting**: Abbreviates the current working directory for compact terminal titles.
- **Status Prefix**: Prefixes the path with `agy:` for clear identification.

## Stateful CLI Statusline

### Features

- **Agent State**: Displays the current operational state (Ready: 🟢, Thinking: 🤔, Working: 🚧, Tool Use: 🛠️).
- **Model Identification**: Shows a condensed name of the active LLM (e.g., `Gemini 3.8-Flash (High)`, `Claude Sonnet 4.6 (Thinking)`).
- **Sandbox Security Badge**: Clearly indicates whether the script is running in a secure sandbox environment.
- **Context Usage Progress Bar**: Visualizes context window consumption using an 8-segment Unicode bar with color-coded alerts.
- **Live Counter Tracking**: Real-time display of active task counts and generated artifacts.
- **Compact Path Display**: Smart abbreviation of the current working directory to save horizontal space.

### Output Preview

```text
🟢 • 🤖 Gemini 3.8-Flash (High) • 🛡️ sandbox • 📁 ~/.l/s/chezmoi • 💬 [░░░░░░░░] 0% • 📋 0 • 📦 0
```
