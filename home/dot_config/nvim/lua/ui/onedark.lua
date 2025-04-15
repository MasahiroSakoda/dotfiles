-- -*-mode:lua-*- vim:ft=lua

local onedark_ok, onedark = pcall(require, "onedark")
if not onedark_ok then return end

onedark.setup({
  style = vim.g.themestyle, ---@type "dark"|"darker"|"cool"|"deep"|"warm"|"warmer"
  transparent = true,
  toggle_style_key = "<NOP>",

  code_style = {
    comments  = "italic",
    keywords  = "bold",
    functions = "italic",
    types     = "italic,bold",
  },
})

vim.api.nvim_create_user_command("ToggleOneDarkStyle", function(_)
  onedark.toggle()
  vim.notify(string.format("%s", vim.g.onedark_config.style), vim.log.levels.INFO)
end, { desc = "Toggle OneDark theme style", nargs = "*", bang = true })
