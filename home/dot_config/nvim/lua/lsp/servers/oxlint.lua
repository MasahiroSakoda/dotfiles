local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd = { "oxlint", "--lsp" },
  filetype = ft.oxlint,

  -- TODO: Add config for Vite Plus when RC version has released
  root_markers = ft.lsp.oxlint,

  init_options = {
    settings = {
      run                 = "onType",
      fixKind             = "safe_fix_or_suggestion",
      typeAware           = false,
      disableNestedConfig = false,
    },
  },

  on_attach = function(client, _)
    -- Let oxfmt handle the formatting
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.completionProvider         = nil
  end,
}
