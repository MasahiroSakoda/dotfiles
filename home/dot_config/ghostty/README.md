# Ghostty Configuration

Configuration for [Ghostty](https://ghostty.org/), a fast, feature-rich, cross-platform terminal emulator. This configuration is managed via [chezmoi](https://www.chezmoi.io/) and adapts to both macOS and Linux environments.

## 📂 Source

The configuration is generated from a centralized template:
- **Template**: `home/.chezmoitemplates/common/ghostty-config.tmpl`
- **Output**: `$XDG_CONFIG_HOME/ghostty/config`

## ⚙️ Features

### Cross-Platform Adaptability
- **macOS**:
  - Native tabs styling.
  - Transparent titlebar with hidden proxy icons.
  - "Option as Alt" enabled.
  - Secure input handling enabled.
- **Linux**:
  - Client-side decorations disabled (no titlebar).
  - GTK single instance mode.
  - Wide tabs disabled.

### Visuals & Theming
- **Themes**: Adapts to system preference (Light/Dark).
  - **Dark**: Configured via `.ghostty.theme.dark`
  - **Light**: Configured via `.ghostty.theme.light`
- **Background**:
  - Custom wallpaper support (centered, cover fit).
  - Adjustable background opacity and blur.
  - Optional **Shader** support (GLSL) for retro effects or visual styles.
- **Font**: Templated font family and size (defaulting to Nerd Fonts).

### Productivity
- **Quick Terminal**: Quake-style dropdown terminal.
  - Position: Bottom (25% height).
  - Toggle: `Super + Ctrl + Enter`.
- **Shell Integration**:
  - Features: Cursor sync, sudo handling, title suppression.
  - Auto-updates enabled (Stable channel).
- **Mouse**:
  - Focus follows mouse.
  - Hide cursor while typing.

## ⌨️ Keybindings

### Essential
| Key | Action |
|-----|--------|
| `Super + q` | Quit Ghostty |
| `Super + k` | Clear Screen |
| `Super + Ctrl + f` | Toggle Fullscreen |
| `Super + c` | Copy to Clipboard |
| `Super + v` | Paste from Clipboard |
| `Super + Ctrl + Enter` | Toggle **Quick Terminal** |
| `Super + Alt + i` | Toggle Inspector |

### Window & Splits
| Key | Action |
|-----|--------|
| `Super + n` | New Window |
| `Super + Shift + w` | Close Window |
| `Super + d` | Split Right |
| `Super + Shift + d` | Split Down |
| `Super + [` / `]` | Go to Previous/Next Split |
| `Super + Shift + h/j/k/l` | Navigate Splits (Directional) |
| `Ctrl + Left/Right` | Resize Split (Horizontal) |
| `Ctrl + 0` | Equalize Splits |

### Tabs
| Key | Action |
|-----|--------|
| `Super + t` | New Tab |
| `Ctrl + Tab` | Next Tab |
| `Ctrl + Shift + Tab` | Previous Tab |
| `Super + 1..9` | Switch to Tab 1-9 |

### Font Scaling
| Key | Action |
|-----|--------|
| `Super + +` | Increase Size |
| `Super + -` | Decrease Size |
| `Super + 0` | Reset Size |

### Text Navigation
Custom mappings for better shell interaction:
- `Shift + Enter`: Newline
- `Super + Left`: Start of line/buffer
- `Super + Right`: End of line/buffer
- `Super + Backspace`: Delete line
- `Option + Backspace`: Delete word

## 🔧 Template Variables

This configuration relies on `chezmoi` data for personalization. Key variables used:

- `{{ .shell }}`: Default shell path.
- `{{ .font.family.combined }}`: Primary font family.
- `{{ .ghostty.opacity }}`: Window background opacity.
- `{{ .ghostty.background.image }}`: Path to wallpaper image.
- `{{ .ghostty.shader.enabled }}`: Toggle for custom shaders.
