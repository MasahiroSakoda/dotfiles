-- -*-mode:lua-*- vim:ft=lua
local ok, tstools = pcall(require, "typescript-tools")
if not ok then return end

tstools.setup({
  on_attach = function(client, bufnr)
    -- Disable tsserver's formatting capability to prevent conflict
    client.server_capabilities.documentFormattingProvider      = false
    client.server_capabilities.documentRangeFormattingProvider = false
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end
  end,
  capabilities = require("lsp.config.capabilities"),
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    tsserver_plugins = {},
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
  },
})
