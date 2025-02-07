-- -*-mode:lua-*- vim:ft=lua

---@class snacks.picker.Config
return {
  enabled = true,
  prompt = " ",

  matcher = {
    cwd_bonus = true,
    frecency  = true,
  },

  win = {
    input = {
      keys = {
        ["<a-s>"] = { "flash", mode = { "n", "i" }},
        ["s"]     = { "flash" },
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
