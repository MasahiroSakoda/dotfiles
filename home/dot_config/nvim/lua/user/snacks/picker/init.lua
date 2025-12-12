-- -*-mode:lua-*- vim:ft=lua

---@class snacks.picker.Config
return {
  enabled = true,
  prompt = " ",

  -- default hidden and ignore config
  hidden  = true,
  ignored = false,

  ---@class snacks.picker.matcher.Config
  matcher = {
    fuzzy      = true,
    smartcase  = true,
    ignorecase = true,
    frecency   = true,
  },

  ---@class snacks.picker.formatters.Config
  formatters = {
    file = {
      truncate   = 80,
      icon_width = 3,
    },
  },

  sort = {
    -- default sort is by score, text length and index
    fields = { "score:desc", "#text", "idx" },
  },

  sources = {
    files = { hidden = true },
    smart = { hidden = true, filter = { cwd = true } },
    grep  = { hidden = true },
    snippets = require("user.snacks.picker.snippets"),
    gh_issue = {},
    gh_pr = {},
  },

  win = {
    input = {
      keys = {
        ["<c-c>"] = { "close",               mode = { "i", "n" } },
        ["<c-u>"] = { "preview_scroll_up",   mode = { "i", "n" } },
        ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<c-b>"] = { "list_scroll_up",      mode = { "i", "n" } },
        ["<c-f>"] = { "list_scroll_down",    mode = { "i", "n" } },
        ["<c-t>"] = { "edit_tab",            mode = { "i", "n" } },
        ["<c-i>"] = { "toggle_focus",        mode = { "i", "n" } },

        ["<a-s>"] = { "flash",    mode = { "n", "i" } },
        ["s"]     = { "flash" },
      },
    },
    list = {
      keys = {
        ["<c-c>"] = "close",
        ["<c-u>"] = "preview_scroll_up",
        ["<c-d>"] = "preview_scroll_down",
        ["<c-b>"] = "list_scroll_up",
        ["<c-f>"] = "list_scroll_down",
        ["<c-t>"] = "edit_tab",
        ["<c-i>"] = "toggle_focus",
      },
    },
  },

  actions = {
    flash = function(picker)
      require("flash").jump({
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
          },
        },
        action = function(match) picker.list:_move(picker.list:row2idx(match.pos[1]), true, true) end,
      })
    end,
  },

  ---@class snacks.picker.debug
  debug = {
    scores   = false, -- show scores in the list
    leaks    = false, -- show when pickers don't get garbage collected
    explorer = false, -- show explorer debug info
    files    = false, -- show file debug info
  },
}
