-- -*-mode:lua-*- vim:ft=lua

local caps = vim.lsp.protocol.make_client_capabilities()
caps = require("cmp_nvim_lsp").default_capabilities(caps)
caps.textDocument.completion.completionList = {
  itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" },
}
caps.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
caps.textDocument.completion.completionItem.snippetSupport          = true
caps.textDocument.completion.completionItem.preselectSupport        = true
caps.textDocument.completion.completionItem.insertReplaceSupport    = true
caps.textDocument.completion.completionItem.labelDetailsSupport     = true
caps.textDocument.completion.completionItem.deprecatedSupport       = true
caps.textDocument.completion.completionItem.commitCharactersSupport = true
caps.textDocument.completion.completionItem.tagSupport = { valueSet = { 1, 2 }}
caps.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
    "sortText",
    "filterText",
    "insertText",
    "textEdit",
    "insertTextFormat",
    "insertTextMode",
  }
}
caps.textDocument.colorProvider = { dynamicRegistration = true }
caps.textDocument.foldingRange  = { dynamicRegistration = false, lineFoldingOnly = true }

return caps
