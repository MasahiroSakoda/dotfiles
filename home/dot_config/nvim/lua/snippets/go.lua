-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt    = require("luasnip.extras.fmt").fmt
-- local fmta   = require("luasnip.extras.fmta")
-- local conds  = require("luasnip.extras.conditions")
-- local condse = require("luasnip.extras.conditions.expand")

local snippets = {
  s({ trig = "type", name = "", dscr = "" },
    fmt('type {} {} {{\n\t{}\n}}\n{}', { i(1, "name"), c(2, { t("struct"), t("interface") }), i(3, "code"), i(0) })
  ),
  s({ trig = "ife", name = "if - end", dscr = "if - end block" }, fmt('if err != nil {{\n\t{}\n}}\n{}',
    {
      c(1, {
        t("return err"),
        t("return nil, err"),
        t("t.Fatal(err)"),
        t("log.Fatal(err)"),
        i(0),
      }),
      i(0)
    }
  )),
  s({ trig = "3pkg", name = "3rd party packages", dscr = "third party packages" },
    fmt('"github.com/{}"{}', {
      c(1, {
        t('stretchr/testify'),
        t('spf13/cobra'),
        t('spf13/viper'),
        t('charmbracelet/bubbletea'),
        t('charmbracelet/bubbles'),
        t('charmbracelet/lipgloss'),
        t('charmbracelet/log'),
        t('adrg/xdg'),
      }),
      i(0),
    })
  ),

  -- Test
  s({ trig = "terr", name = "error check (test)", dscr = "error check in test code" },
    fmt('if err != nil {{\n\tt.Errorf("{}: %v", err)\n{}}}\n', { i(1, "error msg"), i(0) })
  ),
  s({ trig = "test", name = "test function", dscr = "test function template" }, fmt([[
      func Test{}(t *testing.T) {{
          tests := []struct {{
              name string
              wantErr error
              {}
          }}{{
              {{ name: "{}" }},
          }}

          for _, tt := range tests {{
              t.Run(tt.name, func(t *testing.T) {{
                  {}
              }})
          }}
      }}
      {}
  ]], { i(1, "func"), i(2, "field"), i(3, "description"), i(4, "assert"), i(0) })),

  -- Cobra
  s({ trig = "cobra", name = "Cobra", dscr = "spf13/cobra CLI library template" },
    fmt([[
      import (
          "github.com/spf13/cobra"
      )

      func rootCmd() *cobra.Command {{
          return &cobra.Command{{
              Use:   "",
              Short: "",
              Long:  "",
              RunE:  func (_ *cobra.Command, args []string) error {{
						      m := tui.New()
						  	  p := tea.NewProgram(m, tea.WithAltScreen())
						  	  if _, err := p.Run(); err != nil {{
								      log.Error("Bubbletea program fail: ", err)
							        return err
			        	  }}
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
  ]], {})
  ),

  -- Viper
  -- TODO: Crate template for Viper
  -- s("viper", fmt([[
  --     import (
  --         "errors"
  --         "github.com/spf13/viper"
  --     )
  --   ]], {})
  -- ),

  s({ trig = "config", name = "Config", dscr = "Config package template" },
    fmt([[
      // Package config provides function to use config
      package config

      // Config defines type to use viper
      type Config struct {{
          {} {} `mapstructure:"{}"`{}
      }}
    ]], { i(1, "config item"), i(2, "type"), rep(1), i(0) })
  ),

  -- XDG directories
  s({ trig = "xdgc", name = "XDG Directory", dscr = "Define XDG directory as constants" },
    fmt([[
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
      {}
    ]], { i(1, "command name"), i(0) })
  ),

  -- Bubbletea
  s({ trig = "team", name = "Bubbletea model", dscr = "Bubbletea required model methods" },
    fmt('type Model struct{{\n\t{}\n}}\n\nfunc New() *Model{{\n\treturn Model{{\n\t}}\n}}\n{}', { i(1), i(0) })
  ),
  s({ trig = "teai", name = "Bubbletea init", dscr = "Bubbletea initialize methods" },
    fmt('func (m Model) Init() tea.Cmd {{\n\treturn tea.Batch(\n\t\t{}\n\t)\n}}\n{}', { i(1), i(0) })
  ),
  s({ trig = "teap", name = "Bubbletea program", dscr = "Bubbletea laungh template" },
    fmt([[
      p := tea.NewProgram()
      if _, err := p.Run(); err != nil {{
          os.Exit(1)
      }}
      p.Quit()
      {}
    ]], { i(0) })
  ),
  s({ trig = "teav", name = "Bubbletea view", dscr = "Bubbletea required view method" },
    fmt('func (m Model) View() string {{\n\treturn {}\n}}\n{}', { i(1, "code"), i(0) })
  ),
  s({ trig = "teau", name = "Bubbletea update", dscr = "Bubbletea required update method" },
    fmt([[
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
      {}
    ]], { i(0) })
  ),
  -- bubbles
  s({ trig = "bubbles", name = "Bubbles collection", dscr = "Bubbletea UI Collectioin" },
    fmt('{}{}', {
      c(1, {
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
      }),
      i(0),
    })
  ),
}
return snippets
