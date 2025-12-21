-- -*-mode:lua-*- vim:ft=lua
local ok, flash = pcall(require, "flash")
if not ok then return end

---@type Flash.Config
flash.setup({
  labels = "hjklasdfgyuiopqwertnmzxcvb",
  search = { multi_window = true },
  jump   = { autojump = true },
  label  = { uppercase = false, rainbow = { enabled = false } },

  highlight = {
    groups = {
      match    = "FlashMatch",
      current  = "FlashCurrent",
      backdrop = "FlashBackdrop",
      label    = "FlashLabel",
    },
  },
  pattern   = "",
  continue  = false,

  modes = {
    char = { autohide = true, jump_labels = true },
    treesitter = { labels = "hjklasdfgyuiopqwertnmzxcvb" },
  },
  prompt = {},
  remote_op = {},
  exclude = require("core.ignore").flash,
})
vim.api.nvim_create_user_command("FlashJumpLine", function(_)
  flash.jump({
    pattern   = "^\\s*\\S\\?",
    jump      = { pos = "end" },
    search    = { mode = "search", max_length = 0 },
    label     = { after = { 0, 0 } },
    highlight = { matches = false },
  })
end, { desc = "Jump to the line (non-whitespace at start plus any character)", nargs = "*", bang = true })

vim.api.nvim_create_user_command("FlashJumpCword", function(_)
  flash.jump({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Jump to <cword>", nargs = "*", bang = true })

vim.api.nvim_create_user_command("FlashJumpWord", function(_)
  flash.jump({
    pattern = ".", -- initialize pattern with any char
    search  = {
      mode = function(pattern)
        if pattern:sub(1, 1) == "." then
          pattern = pattern:sub(2)
        end
        -- return word pattern and proper skip pattern
        return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
      end
    },
    -- select the range
    jump = { pos = "range" },
  })
end, { desc = "Jump to the word", nargs = "*", bang = true })

vim.api.nvim_create_user_command("FlashJumpContinue", function(_)
  flash.jump({ continue = true })
end, { desc = "Continue last search", nargs = "*", bang = true })
