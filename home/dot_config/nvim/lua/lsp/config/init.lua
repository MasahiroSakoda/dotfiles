local lsp_ok, lspconfig       = pcall(require, "lspconfig")
local mason_cfg_ok, mason_cfg = pcall(require, "mason-lspconfig")
local cmp_ok, cmp_nvim_lsp    = pcall(require, "cmp_nvim_lsp")
local navic_ok, navic         = pcall(require, "nvim-navic")

if not lsp_ok  then
  vim.notify('[lspconfig] Loading "lspconfig" failed.', vim.log.levels.WARN)
elseif not mason_cfg_ok then
  vim.notify('[lspconfig] Loading "mason-lspconfig" failed.', vim.log.levels.WARN)
elseif not cmp_ok then
  vim.notify('[lspconfig] Loading "cmp_nvim_lsp" failed.', vim.log.levels.WARN)
elseif not navic_ok then
  vim.notify('[lspconfig] Loading "nvim-navic" failed.', vim.log.levels.WARN)
end

require("lsp.config.handlers")

local api, lsp = vim.api, vim.lsp
local capabilities = cmp_nvim_lsp.default_capabilities(lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.colorProvider = {
  dynamicRegistration = true
}
capabilities.textDocument.foldingRange  = {
  dynamicRegistration = false,
  lineFoldingOnly     = true,
}

local on_attach = function(client, bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  client.server_capabilities.document_formatting       = false
  client.server_capabilities.document_range_formatting = false

  -- Avoid confliction tsserver & denols
  local active_clients = lsp.get_active_clients()
  if client.name == "tsserver" then
    for _, _client in ipairs(active_clients) do
      -- stop tsserver if denols is already active
      if _client.name == "denols" then
        client.stop()
      end
    end
  elseif client.name == "denols" then
    -- prevent tsserver from starting if denols is already active
    for _, _client in ipairs(active_clients) do
      if _client.name == "tsserver" then
        client.stop()
      end
    end
  end

  if client.server_capabilities.documentSymbolProvider then
    -- vim.g.navic_silence = true
    navic.attach(client, bufnr)
  end
end

mason_cfg.setup({ ensure_installed = require("lsp.servers") })
mason_cfg.setup_handlers {
  function (server)
    lspconfig[server].setup {
      on_attach    = on_attach,
      capabilities = capabilities,
    }
  end
}
