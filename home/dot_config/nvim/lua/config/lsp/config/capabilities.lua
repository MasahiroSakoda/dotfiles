-- -*-mode:lua-*- vim:ft=lua

local caps = vim.lsp.protocol.make_client_capabilities()
caps = require("blink.cmp").get_lsp_capabilities(caps)
caps.textDocument.completion.completionList = {
  itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" },
}
caps.textDocument.completion.completionItem = {
  snippetSupport          = true,
  preselectSupport        = true,
  insertReplaceSupport    = true,
  labelDetailsSupport     = true,
  deprecatedSupport       = true,
  commitCharactersSupport = true,

  tagSupport          = { valueSet = { 1 } },
  resolveSupport      = { properties = { "documentation", "detail", "additionalTextEdits" } },
  documentationFormat = { "markdown", "plaintext" },
}
-- caps.textDocument.selectionRange.dynamicRegistration = true
caps.textDocument.colorProvider = { dynamicRegistration = true }
caps.textDocument.foldingRange  = { dynamicRegistration = false, lineFoldingOnly = true }

return caps
