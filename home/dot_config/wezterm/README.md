# WezTerm Configuration

A modular, highly customizable configuration for [WezTerm](https://wezfurlong.org/wezterm/), managed with [chezmoi](https://www.chezmoi.io/).

## 📂 Structure

The configuration is split into multiple Lua modules for better maintainability:

| File | Description |
|------|-------------|
| `wezterm.lua` | **Entry point**. Loads all modules and sets base configuration (renderer, window settings). |
| `keybinds.lua` | Key bindings and key tables (Leader: `Super + ;`). |
| `events.lua` | Event listeners for GUI startup, status bar formatting, and dynamic config reloading. |
| `fonts.lua.tmpl` | Font configuration (templated via chezmoi). |
| `theme.lua.tmpl` | Color scheme loader (templated via chezmoi). |
| `background.lua.tmpl` | Background image loader (templated via chezmoi). |
| `workspace.lua.tmpl` | Workspace management utilities (switching, creating, renaming). |
| `utils.lua` | Utility functions for status bar icons, date/time formatting, and process names. |
| `links.lua` | Hyperlink rules (regex for URLs, emails, issue trackers). |
| `select.lua` | Quick Select mode patterns and alphabet. |

## ✨ Features

- **Modular Design**: Separated concerns for cleaner code.
- **Dynamic Status Bar**:
  - Shows active workspace.
  - Displays key table status (e.g., resize mode).
  - Current date and time.
- **Rich Tab Bar**:
  - Custom formatting with [Nerd Fonts](https://www.nerdfonts.com/) icons based on the running process.
  - Distinct styles for active vs. inactive tabs.
- **Workspace Management**:
  - Fuzzy search for switching workspaces.
  - Create new workspaces based on current directory.
- **Visuals**:
  - **Themes**: Cycle through configured color schemes.
  - **Backgrounds**: Cycle through configured wallpapers.
  - **Opacity**: Adjustable window opacity on the fly.

## ⌨️ Keybindings

The **Leader Key** is set to `Super + ;`.

### Essential

| Key                | Action             |
|:-------------------|:-------------------|
| `Super + q`        | Quit Application   |
| `Super + Enter`    | Toggle Fullscreen  |
| `Super + f`        | Search Scrollback  |
| `Super + c / v`    | Copy / Paste       |
| `Super + y`        | Activate Copy Mode |
| `Super + Ctrl + s` | Quick Select       |

### Panes

| Key               | Action                                   |
|:------------------|:-----------------------------------------|
| `Super + d`       | Split Horizontal                         |
| `Super + D`       | Split Vertical                           |
| `Super + w`       | Close Current Pane                       |
| `Super + [` / `]` | Rotate Panes                             |
| `Super + Arrows`  | Navigate Panes                           |
| `Leader + r`      | **Resize Pane Mode** (H/J/K/L to resize) |

### Tabs

| Key                  | Action            |
|:---------------------|:------------------|
| `Super + t`          | New Tab           |
| `Super + 1..9`       | Switch to Tab 1-9 |
| `Ctrl + Tab`         | Next Tab          |
| `Ctrl + Shift + Tab` | Previous Tab      |

### Workspaces

| Key                 | Action                   |
|:--------------------|:-------------------------|
| `Leader + s`        | Switch Workspace (Fuzzy) |
| `Leader + r`        | Rename Workspace         |
| `Super + Shift + i` | Switch to Workspace      |
| `Super + Shift + ;` | Show Workspace Launcher  |

### Visuals

| Key             | Action                      |
|:----------------|:----------------------------|
| `Super + +/-`   | Increase/Decrease Font Size |
| `Leader + c`    | Switch Color Scheme         |
| `Leader + b`    | Switch Background Image     |
| `Shift + F1/F2` | Decrease/Increase Opacity   |
| `Leader + 0`    | Toggle Ligatures            |

## 🧩 Templates (Chezmoi)

Several files are templates (`.tmpl`) to allow injection of variables from `~/.chezmoi.toml` or `.chezmoidata/`.

- **Fonts**: Families and sizes are pulled from `wezterm.font` data.
- **Themes**: List of available themes is generated from `wezterm.themes`.
- **Backgrounds**: Wallpapers are sourced from `wezterm.images`.
