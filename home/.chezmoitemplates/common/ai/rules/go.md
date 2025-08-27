# Go Rules

- **Runtime Version**: Use `.mise.toml` to manage `go` runtime version locally.
- **Linter & Formatter**: Use [`golangci-lint`](https://golangci-lint.run/)
- **Testing**: Write unit tests for all new functionality
- **Documentation**: Docstrings for all functions (Google style)
- **Import order**: Group by standard library, third-party, then project-specific with blank lines
- **Coding Style**: Follow [Go Style Guide](https://google.github.io/styleguide/go/guide) and [Go's Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)

## Commonly Used Libraries

- **Commandline Framework**: [cobra](https://github.com/spf13/cobra)
- **Configuration Management**: [viper](https://github.com/spf13/viper)
- **TUI Framework**: [bubbletea](https://github.com/charmbracelet/bubbletea)
- **TUI Components**: [bubbles](https://github.com/charmbracelet/bubbles)
- **TUI Forms & Prompts**: [huh](https://github.com/charmbracelet/huh)
- **TUI Styling & Colors**: [lipgloss](https://github.com/charmbracelet/lipgloss)
- **Logging**: [log](https://github.com/charmbracelet/log)
- **Markdown Rendering**: [glamour](https://github.com/charmbracelet/glamour)
- **Unicode Width**: [go-runewidth](https://github.com/mattn/go-runewidth)
- **SQLite**: [go-sqlite3](https://github.com/mattn/go-sqlite3)
