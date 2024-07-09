-- -*-mode:lua-*- vim:ft=lua
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
  current_line_blame = true,
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
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
