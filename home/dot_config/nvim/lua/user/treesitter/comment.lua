local ok, comment = pcall(require, "mini.comment")
if not ok then return end

local commentstring = require("ts_context_commentstring")
commentstring.setup({
  enable_autocmd = false,
})

comment.setup({
  options = {
    -- Function to compute custom 'commentstring' (optional)
    custom_commentstring = function()
      return commentstring.calculate_commentstring() or vim.bo.commentstring
    end,
    ignore_blank_line    = false, -- Whether to ignore blank lines when commenting
    start_of_line        = false, -- Whether to ignore blank lines in actions and textobject
    pad_comment_parts    = true,  -- Whether to force single space inner padding for comment parts
  },
  mappings = {
    comment        = "gc",  -- Normal and Visual modes
    comment_line   = "gcc", -- Toggle comment on current line
    comment_visual = "gc",  -- Toggle comment on visual selection
    textobject     = "gc",  -- Define 'comment' textobject (like `dgc` - delete whole comment block)
  },
  hooks = {
    pre  = function() end,
    post = function() end,
  },
})

-- Workaround overlapping with `gc`
vim.keymap.del("n", "gc")

require("which-key").add({
  { "gb", group = "Toggle comment blockwise", icon = " " },
  { "gc", group = "Toggle comment linewise",  icon = " " },
})
