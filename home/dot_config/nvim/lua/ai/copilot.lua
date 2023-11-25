local ok, copilot = pcall(require, "copilot")
if not ok then return end

copilot.setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    layout = {
      --- @type "top"|"bottom"|"left"|"right"
      position = "bottom",
      ratio    = 0.4,
    },
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept    = "<CR>",
      refresh   = "gr",
      open      = "<M-CR>",
    },
  },

  suggestion = {
    enabled = true,
    auto_trigger = false,
    keymap = {
      accept = "<M-l",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },

  filetypes = {
    help      = false,
    yaml      = false,
    markdown  = false,
    gitcommit = false,
    gitrebase = false,
    go        = false,
  },
})
