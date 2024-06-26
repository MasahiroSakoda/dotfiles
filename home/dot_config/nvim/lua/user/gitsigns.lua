-- -*-mode:lua-*- vim:ft=lua
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
  current_line_blame = true,
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '✚', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = { hl = 'GitSignsChange', text = '↻', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = { hl = 'GitSignsDelete', text = '▁', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = { hl = 'GitSignsChange', text = '—↻', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },

})

if vim.g.scrollbar_enabled then
  require("scrollbar.handlers.gitsigns").setup()

  vim.api.nvim_create_user_command("ScrollbarEnable", function()
    local sg_ok, sg = pcall(require, "scrollbar.handlers.gitsigns")
    if not sg_ok then
      vim.notify("scrollbar.handlers.gitsigns could not be loaded")
    end
    sg.setup()
  end, {})
end
