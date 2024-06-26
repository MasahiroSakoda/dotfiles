-- -*-mode:lua-*- vim:ft=lua

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport          = true
capabilities.textDocument.completion.completionItem.preselectSupport        = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport    = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport     = true
capabilities.textDocument.completion.completionItem.deprecatedSupport       = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 }}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits", "documentHighlight" }
}
capabilities.textDocument.colorProvider = { dynamicRegistration = true }
capabilities.textDocument.foldingRange  = { dynamicRegistration = false, lineFoldingOnly = true }

return capabilities
