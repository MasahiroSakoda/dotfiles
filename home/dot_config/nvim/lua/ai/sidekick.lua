-- -*-mode:lua-*- vim:ft=lua
local ok, sidekick = pcall(require, "sidekick")
if not ok then return end

sidekick.setup({
  nes = { debounce = 500 },
  cli = {
    watch = true,
  },
})

vim.api.nvim_create_user_command("ToggleNextEditSuggestion", function(_)
  require("snacks").toggle({
    name = "Sidekick NES",
    get  = function() return require("sidekick.nes").enabled end,
    set  = function(state) return require("sidekick.nes").enabled(state) end,
  })
end, { desc = "Toggle Next Edit Suggestion via sidekick.nvim", nargs = "*", bang = true })
