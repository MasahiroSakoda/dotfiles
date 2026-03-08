-- -*-mode:lua-*- vim:ft=lua
require("lsp.config.status")
require("lsp.config.diagnostics")
require("lsp.config.handlers")

local on_attach = function(client, bufnr)
  local caps = client.server_capabilities

  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  if caps.completionProvider then vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" end

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  if caps.documentFormattingProvider then vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()" end

  -- tagfunc
  -- See `:help tag-function` for more information.
  if caps.definitionProvider then vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc" end

  caps.document_formatting        = true
  caps.document_range_formatting  = true
  caps.documentFormattingProvider = true
  caps.offsetEncoding = { "utf-16" }

  -- Workaround semantic token problem go/gopls #54531
  if client.name == "gopls" and not caps.semanticTokensProvider then
    local semantic = client.config.capabilities.textDocument.semanticTokens
    caps.semanticTokensProvider = {
      full = true,
      legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
      range = true,
    }
  end
end

local servers     = require("lsp.servers")
local server_opts = { on_attach = on_attach, capabilities = require("lsp.config.capabilities") }

for server, config in pairs(servers) do
  -- Skip packages executing via `none-ls.nvim`
  if vim.tbl_isempty(config) then goto continue end

  vim.lsp.config(server, vim.tbl_deep_extend("keep", server_opts, config or {}))
  -- vim.lsp.enable(server)
  ::continue::
end
