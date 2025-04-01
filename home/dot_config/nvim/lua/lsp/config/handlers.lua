-- -*-mode:lua-*- vim:ft=lua

vim.lsp.handlers["textDocument/hover"]         = vim.lsp.with(vim.lsp.buf.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.buf.signature_help, {
  border = "rounded",
  silent = true,
  -- focusable = false,
  close_events = { "CursorMoved", "BufHidden", "InsertCharPre", "InsertLeave" },
})
