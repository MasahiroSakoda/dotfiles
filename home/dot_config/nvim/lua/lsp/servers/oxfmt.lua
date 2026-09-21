local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd      = { "oxfmt", "--lsp" },
  filetype = ft.oxfmt,

  -- TODO: Add config for Vite Plus when RC version has released
  root_markers = ft.lsp.oxfmt,

  init_options = {
    settings = {
      run = "onSave",
    },
  },

  on_attach = function(client, _)
    -- Enable only the formatting function; no diagnostics
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.completionProvider         = nil
  end,
}
