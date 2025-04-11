-- -*-mode:lua-*- vim:ft=lua

vim.api.nvim_create_user_command("LspStatusToggle", function(_)
  local buf     = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if not vim.tbl_isempty(clients) then
    vim.cmd("LspStop")
    vim.notify("LSP stopped.", vim.log.levels.INFO)
  else
    vim.cmd("LspStart")
    vim.notify("LSP started.", vim.log.levels.INFO)
  end
end, { desc = "Toggle LSP status for current buffer", nargs = "*", bang = true })
