# Go Rules

- **Runtime Version**: Use `.mise.toml` to manage `go` runtime version locally.
  - Always unify the `go` version in `.mise.toml` and `go.mod`
- **Linter & Formatter**: Use [`golangci-lint`](https://golangci-lint.run/)
- **Testing**: Write unit tests for all new functionality
- **Documentation**: Docstrings for all functions (Google style)
- **Import order**: Group by standard library, third-party, then project-specific with blank lines
- **Coding Style**: Follow [Go Style Guide](https://google.github.io/styleguide/go/guide) and [Go's Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)

## Commonly Used Libraries

- **Commandline Framework**: [cobra](https://github.com/spf13/cobra)
- **Configuration Management**: [viper](https://github.com/spf13/viper)
- **Flag Replacement**: [pflag](https://github.com/spf13/pflag)
- **TUI Framework**: [bubbletea](https://github.com/charmbracelet/bubbletea)
- **TUI Components**: [bubbles](https://github.com/charmbracelet/bubbles)
- **TUI Forms & Prompts**: [huh](https://github.com/charmbracelet/huh)
- **TUI Styling & Colors**: [lipgloss](https://github.com/charmbracelet/lipgloss)
- **Logging**: [zap](https://github.com/uber-go/zap)
- **Test**: [Testify](https://github.com/stretchr/testify)
- **Dependency Injection**: [dig](https://github.com/uber-go/dig), [fx](https://github.com/uber-go/fx)
- **Markdown Rendering**: [glamour](https://github.com/charmbracelet/glamour)
- **Unicode Width**: [go-runewidth](https://github.com/mattn/go-runewidth)
- **SQLite**: [go-sqlite3](https://github.com/mattn/go-sqlite3)
- **HTTP Router**: [chi](https://github.com/go-chi/chi)
- **Web Framework**: [Echo](https://github.com/labstack/echo)
- **Graph & Chart**: [go-echats](https://github.com/go-echarts/go-echarts)
