local ok, hlargs = pcall(require, "hlargs")
if not ok then return end

hlargs.setup({
  excluded_filetypes = { "TelescopePrompt" },
  disabled = function(_, bufnr)
    if vim.b.semantic_tokens then
      return true
    end

    local clients = vim.lsp.get_active_clients { bufnr = bufnr }
    for _, client in pairs(clients) do
      local capabilities = client.server_capabilities
      if client.name ~= "null-ls" and capabilities.semanticTokensProvider and capabilities.semanticTokensProvider.full then
        vim.b.semantic_tokens = true
        return vim.b.semantic_tokens
      end
    end
  end
})
