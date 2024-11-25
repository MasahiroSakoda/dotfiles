-- -*-mode:lua-*- vim:ft=lua

local lsp_ok, lspconfig       = pcall(require, "lspconfig")
local mason_cfg_ok, mason_cfg = pcall(require, "mason-lspconfig")
local navic_ok, navic         = pcall(require, "nvim-navic")

if not lsp_ok  then
  vim.notify('[lspconfig] Loading "lspconfig" failed.', vim.log.levels.WARN)
elseif not mason_cfg_ok then
  vim.notify('[lspconfig] Loading "mason-lspconfig" failed.', vim.log.levels.WARN)
elseif not navic_ok then
  vim.notify('[lspconfig] Loading "nvim-navic" failed.', vim.log.levels.WARN)
end

require("lsp.config.diagnostics")
require("lsp.config.handlers")

local active_clients = vim.lsp.get_clients()

local on_attach = function(client, bufnr)
  vim.bo.tagfunc    = "v:lua.vim.lsp.tagfunc"
  vim.bo.omnifunc   = "v:lua.vim.lsp.omnifunc"
  vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr()"
  client.server_capabilities.document_formatting        = false
  client.server_capabilities.document_range_formatting  = false
  client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false

  client.server_capabilities.offsetEncoding = { "utf-16" }

  -- Avoid confliction tsserver & denols
  if client.name == "tsserver" then
    for _, _client in ipairs(active_clients) do
      -- stop tsserver if denols is already active
      if _client.name == "denols" then
        client:stop(true)
      end
    end
  elseif client.name == "denols" then
    -- prevent tsserver from starting if denols is already active
    for _, _client in ipairs(active_clients) do
      if _client.name == "tsserver" then
        client:stop(true)
      end
    end
  end

  if client.server_capabilities.documentSymbolProvider then
    -- vim.g.navic_silence = true
    navic.attach(client, bufnr)
  end

  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set("n", "gh", function()
      require("utils.lsp").toggle_inlay_hints(bufnr)
    end, { desc = "   Toggle Inlay Hints" })
  end
end

local servers = require("lsp.servers")
mason_cfg.setup({ ensure_installed = servers })

local server_opts = {
  on_attach    = on_attach,
  capabilities = require("lsp.config.capabilities"),
}
mason_cfg.setup_handlers {
  function (server)
    local opts = vim.tbl_deep_extend("force", server_opts, servers[server] or {})
    lspconfig[server].setup(opts)
  end,
}
