-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn =
  ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
---@diagnostic disable-next-line: unused-local
local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
---@diagnostic disable-next-line: unused-local
local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")
---@diagnostic disable-next-line: unused-local
local rep = require("luasnip.extras").rep

local snippets = {
  s("type", fmt('type {} {} {{\n{}\n}}', { i(1, "name"), c(2, { t("struct"), t("interface") }), i(3, "code") })),
  s("ife", fmt('if err != nil {{\n\t{}\n}}{}', { c(1, {
    t("return err"),
    t("return nil, err"),
    t("t.Fatal(err)"),
    t("log.Fatal(err)"),
  }), i(2) })),
  s("3pkg", fmt('"github.com/{}', { c(1, {
    t('"stretchr/testify"'),
    t('"spf13/cobra"'),
    t('"spf13/viper"'),
    t('"charmbracelet/bubbletea"'),
    t('"charmbracelet/bubbles"'),
    t('"charmbracelet/lipgloss"'),
    t('"charmbracelet/log"'),
    t('"adrg/xdg"'),
  })})),

  -- Test
  s("terr", fmt('if err != nil {{\n\tt.Errorf("{}: %v", err)\n}}', { i(1, "error msg") })),
  s("test", fmt([[
      func Test{}(t *testing.T) {{
          tests := []struct {{
              name string
              wantErr error{}
          }}{{
              {{ name: "{}" }},
          }}

          for _, tt := range tests {{
              t.Run(tt.name, func(t *testing.T) {{
                  {}
              }})
          }}
      }}
  ]], { i(1, "func"), i(2), i(3), i(4, "assert") })),

  -- Cobra
  s("cobra", fmt([[
      import (
          "github.com/spf13/cobra"
      )

      func rootCmd() *cobra.Command {{
	        return &cobra.Command{{
		          Use:   "",
		          Short: "",
		          Long:  "",
		          RunE:  func (_ *cobra.Command, args []string) error {{
			            p.Quit()
			            return nil
		          }},
	        }}
      }}

      // Execute : root command
      func Execute(args []string) int {{
	        cmd := rootCmd()
	        if err := cmd.Execute(); err != nil {{
		          return 1
	        }}
	        return 0
      }}
  ]], {})),

  -- Viper
  -- TODO: Crate template for Viper
  -- s("viper", fmt([[
  --     import (
  --         "errors"
  --         "github.com/spf13/viper"
  --     )
  --   ]], {})
  -- ),

  s("config", fmt([[
      // Package config provides function to use config
      package config

      // Config defines type to use viper
      type Config struct {{
          {} {} `mapstructure:"{}"`
      }}
    ]], { i(1, "config item"), i(2, "type"), rep(1) })
  ),

  -- XDG directories
  s("xdgc", fmt([[
      import (
          "github.com/adrg/xdg"
      )

      const (
          // CommandName is to use as binary name
	        CommandName string = "{}"
	        // CurrentVersion is to use current version
	        CurrentVersion string = "v0.1.0"

	        // DefaultConfigFileName is name of config file (without extension)
	        DefaultConfigFileName string = "config"
	        // DefaultConfigFileType is extension of config file
	        DefaultConfigFileType string = "toml"
      )

      var HomeDir  = xdg.Home + "/"
      var MainDir  = xdg.ConfigHome + "/" + CommandName
      var CacheDir = xdg.CacheHome  + "/" + CommandName
      var DataDir  = xdg.DataHome   + "/" + CommandName
      var StateDir = xdg.StateHome  + "/" + CommandName

      var DownloadDir  = xdg.UserDirs.Download
      var DocumentsDir = xdg.UserDirs.Documents
      var MusicDir     = xdg.UserDirs.Music
      var VideosDir    = xdg.UserDirs.Videos
      var PublicDir    = xdg.UserDirs.PublicShare
    ]], { i(1, "command name") })
  ),

  -- Bubbletea
  s("team", fmt('type Model struct{{\n\t{}\n}}\n\nfunc New() *Model{{\n\treturn Model{{\n\t}}\n}}', { i(1) })),
  s("teai", fmt('func (m Model) Init() tea.Cmd {{\n\treturn tea.Batch(\n\t\t{}\n\t)\n}}', { i(1) })),
  s("teap", fmt([[
    p := tea.NewProgram()
    if _, err := p.Run(); err != nil {{
        os.Exit(1)
    }}
    p.Quit()
  ]], {})),
  s("teav", fmt('func (m Model) View() string {{\n\treturn {}\n}}', { i(1) })),
  s("teau", fmt([[
      func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {{
          var (
              cmd    tea.Cmd
              cmds []tea.Cmd
          )
	        switch msg := msg.(type) {{
	        case tea.WindowSizeMsg:
          case tea.KeyMsg:
	        case tea.QuitMsg:
		          return m, tea.Quit
          }}
	        return m, tea.Batch(cmds...)
      }}
  ]], {})),
  -- bubbles
  s("bubbles", fmt('{}', { c(1, {
    t("spinner"),
    t("textinput"),
    t("textarea"),
    t("table"),
    t("progress"),
    t("paginator"),
    t("viewport"),
    t("list"),
    t("filepicker"),
    t("timer"),
    t("stopwatch"),
    t("help"),
    t("key"),
  }) })),
}
return snippets
