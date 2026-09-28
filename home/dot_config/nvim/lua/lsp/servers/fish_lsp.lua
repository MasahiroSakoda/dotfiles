-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd       = { "fish-lsp", "start" },
  filetypes = { "fish" },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
