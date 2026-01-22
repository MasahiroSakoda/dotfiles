-- -*-mode:lua-*- vim:ft=lua
local ok, sidekick = pcall(require, "sidekick")
if not ok then return end

vim.g.sidekick_nes = false

---@class sidekick.Config
sidekick.setup({
  nes = {
    enabled = function(_)
      return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false
    end,
    debounce = 500,
  },
  cli = {
    watch = true,

    ---@class sidekick.win.Opts
    win = {
      layout = "right",
      split = { width = 120, height = 25 },

      ---@type table<string, sidekick.cli.Keymap|false>
      keys = {
        buffers       = { "<c-\\>", "buffers"   , mode = "nt", desc = "open buffer picker" },
        files         = { "<c-'>",  "files"     , mode = "nt", desc = "open file picker" },
        hide_n        = { "q"    ,  "hide"      , mode = "n" , desc = "hide the terminal window" },
        hide_ctrl_q   = { "<c-q>",  "hide"      , mode = "n" , desc = "hide the terminal window" },
        hide_ctrl_dot = { "<c-.>",  "hide"      , mode = "nt", desc = "hide the terminal window" },
        hide_ctrl_z   = { "<c-z>",  "hide"      , mode = "nt", desc = "hide the terminal window" },
        prompt        = { "<c-,>",  "prompt"    , mode = "t" , desc = "insert prompt or context" },
        stopinsert    = { "<c-q>",  "stopinsert", mode = "t" , desc = "enter normal mode" },
        -- Navigate windows in terminal mode. Only active when:
        -- * layout is not "float"
        -- * there is another window in the direction
        -- With the default layout of "right", only `<c-h>` will be mapped
        nav_left      = { "<c-h>", "nav_left"  , expr = true, desc = "navigate to the left window" },
        nav_down      = { "<c-j>", "nav_down"  , expr = true, desc = "navigate to the below window" },
        nav_up        = { "<c-k>", "nav_up"    , expr = true, desc = "navigate to the above window" },
        nav_right     = { "<c-l>", "nav_right" , expr = true, desc = "navigate to the right window" },
      },
    },

    ---@type table<string, sidekick.cli.Config|{}>
    tools = {
      opencode = {
        cmd = { "opencode" },
        ---@see https://opencode.ai/docs/themes/#built-in-themes
        env = { OPENCODE_THEME = "tokyonight" },
      },
    },
  },

  prompts = require("ai.sidekick.prompts"),

  ---@class sidekick.cli.Mux
  mux = {
    backend = vim.env.ZELLIJ and "zellij" or "tmux", -- default to tmux unless zellij is detected
    enabled = true,
  },
})
