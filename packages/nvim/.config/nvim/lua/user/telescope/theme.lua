local TSTheme = {}

local ok, theme = pcall(require, "telescope.theme")
if not ok then return end

local dropdown = theme.get_dropdown({
  width = 0.8,
  results_height = 20,
  prompt_title = "",
  prompt_prefix = "Files>",
  previewer = false,
  borderchars = {
    prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
    results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' },
    preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
  },
})

local minimal = theme.get_dropdown({
  width = 0.8,
  previewer = false,
  prompt_title = false,
  borderchars = {
    { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
    results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},

  },
})

local builtin = require("telescope.builtin")

TSTheme.fd = function()
  local opts = vim.deepcopy(dropdown)
  opts.prompt_prefix = "Files>"
  return builtin.fd(opts)
end

return TSTheme
