-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local snippets = {
  s({ trig = "ctx", name = "context definition", dscr = "context definition template" }, { t("ctx context.Context") }),
  s({ trig = "ctxc", name = "context cancel", dscr = "context cancel" }, {
    t("ctx, cancel := context.WithCancel(context.Background())"),
  }),
  s({ trig = "ctxt", name = "context timeout", dscr = "context with timeout" },
    fmta('ctx, cancel := context.WithTimeout(context.Background(), <>*time.Second) {\n\tdefer cancel())\n}', { i(0) })
  ),
  s({ trig = "3pkg", name = "3rd party packages", dscr = "third party packages" },
    fmta('"github.com/<>"', {
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
    })
  ),

  -- Test
  s({ trig = "terr", name = "error check (test)", dscr = "error check in test code" },
    fmta('if err != nil {\n\tt.Errorf("<>: %v", err)\n}', { i(0, "error msg") })
  ),
  s({ trig = "test", name = "test function", dscr = "test function template" }, fmta([[
      func Test<>(t *testing.T) {
          tests := []struct {
              name string
              wantErr error
              <>
          }{
              { name: "<>" },
          }

          for _, tt := range tests {
              t.Run(tt.name, func(t *testing.T) {
                  <>
              })
          }
      }
  ]], { i(1, "func"), i(2, "field"), i(3, "description"), i(0, "assert") })),

  -- Cobra
  s({ trig = "cobra", name = "Cobra", dscr = "spf13/cobra CLI library template" },
    fmta([[
      import (
          "github.com/spf13/cobra"
      )

      func rootCmd() *cobra.Command {
          return &cobra.Command{
              Use:   "",
              Short: "",
              Long:  "",
              RunE:  func (_ *cobra.Command, args []string) error {
                  m := tui.New()
                  p := tea.NewProgram(m, tea.WithAltScreen())
                  if _, err := p.Run(); err != nil {
                      log.Error("Bubbletea program fail: ", err)
                      return err
                  }
                  p.Quit()
                  return nil
              },
          }
      }

      // Execute : root command
      func Execute(args []string) int {
          cmd := rootCmd()
          if err := cmd.Execute(); err != nil {
              return 1
          }
          return 0
      }
    ]], {})
  ),

  -- Viper
  -- TODO: Crate template for Viper
  -- s("viper", fmta([[
  --     import (
  --         "errors"
  --         "github.com/spf13/viper"
  --     )
  --   ]], {})
  -- ),

  s({ trig = "config", name = "Config", dscr = "Config package template" },
    fmta([[
      // Package config provides function to use config
      package config

      // Config defines type to use viper
      type Config struct {
          <> <> `mapstructure:"<>"`
      }
    ]], { i(1, "config item"), i(2, "type"), rep(1) })
  ),

  -- XDG directories
  s({ trig = "xdgc", name = "XDG Directory", dscr = "Define XDG directory as constants" },
    fmta([[
      import (
          "github.com/adrg/xdg"
      )

      const (
          // CommandName is to use as binary name
          CommandName string = "<>"
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
    ]], { i(0, "command name") })
  ),

  -- Bubbletea
  s({ trig = "team", name = "Bubbletea model", dscr = "Bubbletea required model methods" },
    fmta('type Model struct{\n\t<>\n}\n\nfunc New() *Model{\n\treturn Model{\n\t}\n}\n', { i(0) })
  ),
  s({ trig = "teai", name = "Bubbletea init", dscr = "Bubbletea initialize methods" },
    fmta('func (m Model) Init() tea.Cmd {\n\treturn tea.Batch(<>)\n}\n', { i(0) })
  ),
  s({ trig = "teap", name = "Bubbletea program", dscr = "Bubbletea laungh template" },
    fmta('p := tea.NewProgram()\nif _, err := p.Run(); err != nil {\n\t<>\nos.Exit(1)\n}\np.Quit()\n', { i(0) })
  ),
  s({ trig = "teav", name = "Bubbletea view", dscr = "Bubbletea required view method" },
    fmta('func (m Model) View() string {\n\treturn <>\n}\n', { i(0, "code") })
  ),
  s({ trig = "teau", name = "Bubbletea update", dscr = "Bubbletea required update method" },
    fmta([[
      func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
          var (
              cmd    tea.Cmd
              cmds []tea.Cmd
          )
          switch msg := msg.(type) {
          case tea.WindowSizeMsg:
          case tea.KeyMsg:
          case tea.QuitMsg:
              return m, tea.Quit
          }
          return m, tea.Batch(cmds...)
      }
    ]], {})
  ),
  -- bubbles
  s({ trig = "bubbles", name = "Bubbles collection", dscr = "Bubbletea UI Collectioin" },
    fmta('<>', {
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
    })
  ),
}
return snippets
