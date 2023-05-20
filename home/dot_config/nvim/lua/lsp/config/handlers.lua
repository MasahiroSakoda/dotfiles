local lsp = vim.lsp
local handlers = lsp.handlers

handlers["textDocument/hover"] = lsp.with(handlers.hover, {
  border = "rounded",
})
handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline     = true,
  severity_sort = true,
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
})
handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, {
  border = "rounded",
  silent = true,
  -- focusable = false,
  close_events = { "CursorMoved", "BufHidden", "InsertCharPre", "InsertLeave" },
})
