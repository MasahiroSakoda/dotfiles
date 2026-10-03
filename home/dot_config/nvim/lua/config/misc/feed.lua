local util = require("utils.feed")

require("feed").setup({
  ui = {
    order = { "date", "feed", "tags", "title", "reading_time" },
    reading_time = {
      color  = "Comment",
      format = function(id, db) return util.estimate_time(id, db) end,
    },
    tags  = {
      color  = "String",
      format = function(id, db) return util.format_tag(id, db) end,
    },
  },

  search = {
    default_query = "@2-weeks-ago +unread ",
    backend       = "snacks.pick",
    sort_order    = "descending",
  },

  keys = {
    index = {
      -- { "q",      "<cmd>Feed quit<cr>" },
      -- { "?",      "<cmd>Feed hints<cr>" },
      -- { ".",      "<cmd>Feed dot<cr>" },
      -- { "u",      "<cmd>Feed undo<cr>" },
      -- { "<C-r>",  "<cmd>Feed redo<cr>" },
      -- { "<M-CR>", "<cmd>Feed split<cr>" },
      -- { "b",      "<cmd>Feed browser<cr>" },
      -- { "r",      "<cmd>Feed refresh<cr>" },
      -- { "R",      "<cmd>Feed update<cr>" },
      -- { "/",      "<cmd>Feed search<cr>" },
      -- { "Y",      "<cmd>Feed yank_url<cr>" },
      -- { "-",      "<cmd>Feed untag<cr>" },
      -- { "+",      "<cmd>Feed tag<cr>" },
      -- { "<cr>",   "<cmd>Feed entry<cr>" },

      { "p",      util.play_podcast },
      { "@",      util.show_in_w3m },
      { "<C-CR>", util.show_in_glow },
    },
    entry = {
      -- { "q", "<cmd>Feed quit<cr>" },
      -- { "?", "<cmd>Feed hints<cr>" },
      -- { "Y", "<cmd>Feed yank_url<cr>" },
      -- { "b", "<cmd>Feed browser<cr>" },
      -- { "}", "<cmd>Feed next<cr>" },
      -- { "{", "<cmd>Feed prev<cr>" },
      -- { "/", "<cmd>Feed search<cr>" },
      -- { "-", "<cmd>Feed untag<cr>" },
      -- { "+", "<cmd>Feed tag<cr>" },
      -- { "f", "<cmd>Feed full<cr>" },
      -- { "r", "<cmd>Feed urlview<cr>" },
    },
  },

  date = { locale = "ja_JP.utf8" },
  zen  = { enabled = true, width = 90 },
})
