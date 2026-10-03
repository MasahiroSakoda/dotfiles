---@type vim.lsp.Config
return {
  cmd          = { "ty", "server" },
  filetypes    = { "python" },
  root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },

  settings = {
    ty = {
      diagnosticMode = "workspace", ---@type "workspace"|"openFilesOnly"
      completions = { autoImport = true },
      inlayHints  = {
        variableTypes       = true,
        callArgumentNames   = true,
        functionReturnTypes = true,
        parameterTypes      = true,
        parameterNames      = true,
      },
    },
  },

  on_attach = function(client, bufnr)
    client.server_capabilities.completionProvider = {
      resolveProvider = true,
      triggerCharacters = { ".", '"', "'", "`", "/", "@" },
    }

    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set(
      "n",
      "<Leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "Code Actions" })
    )
  end,
}

-- -*-mode:lua-*- vim:ft=lua
