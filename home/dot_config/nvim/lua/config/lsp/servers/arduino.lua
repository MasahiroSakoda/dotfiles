---@type vim.lsp.Config
return {
  cmd          = { "arduino-language-server" },
  filetypes    = { "arduino" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(require("lspconfig.util").root_pattern("*.ino")(fname))
  end,

  capabilities = {
    textDocument = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      semanticTokens = vim.NIL
    },
    workspace = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      semanticTokens = vim.NIL
    },
  },
}
