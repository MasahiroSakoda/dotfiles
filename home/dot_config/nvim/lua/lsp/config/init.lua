local lsp_ok, lspconfig       = pcall(require, "lspconfig")
local mason_cfg_ok, mason_cfg = pcall(require, "mason-lspconfig")
local cmp_ok, cmp_nvim_lsp    = pcall(require, "cmp_nvim_lsp")
local navic_ok, navic         = pcall(require, "nvim-navic")
local neoconf_ok, neoconf     = pcall(require, "neoconf")

if not lsp_ok  then
  vim.notify('[lspconfig] Loading "lspconfig" failed.', vim.log.levels.WARN)
elseif not mason_cfg_ok then
  vim.notify('[lspconfig] Loading "mason-lspconfig" failed.', vim.log.levels.WARN)
elseif not cmp_ok then
  vim.notify('[lspconfig] Loading "cmp_nvim_lsp" failed.', vim.log.levels.WARN)
elseif not navic_ok then
  vim.notify('[lspconfig] Loading "nvim-navic" failed.', vim.log.levels.WARN)
elseif not neoconf_ok then
  vim.notify('[lspconfig] Loading "neoconf" failed.', vim.log.levels.WARN)
end

require("lsp.config.handlers")

neoconf.setup({
})

local api, lsp = vim.api, vim.lsp
local capabilities = cmp_nvim_lsp.default_capabilities(lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  }
}
capabilities.textDocument.colorProvider = {
  dynamicRegistration = true
}
capabilities.textDocument.foldingRange  = {
  dynamicRegistration = false,
  lineFoldingOnly     = true,
}

local active_clients = lsp.get_active_clients()
local inlay_hint     = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

local setup_inlay_hints = function()
  local hl = api.nvim_get_hl(0, { name = "Comment" })
  local foreground = string.format("#%06x", hl["fg"] or 0)
  if #foreground < 3 then foreground = "" end

  hl = api.nvim_get_hl(0, { name = "CursorLine" })
  local background = string.format("#%06x", hl["bg"] or 0)
  if #background < 3 then background = "" end
  api.nvim_set_hl(0, 'LspInlayHint', { fg = foreground, bg = background })
end

local on_attach = function(client, bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
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

  -- if client.supports_method("textDocument/inlayHint") then
  --   setup_inlay_hints()
  --   inlay_hint(bufnr, true)
  -- end
end

local servers = require("lsp.servers")
mason_cfg.setup({ ensure_installed = servers })

local server_opts = {
  on_attach    = on_attach,
  capabilities = capabilities,
}
mason_cfg.setup_handlers {
  function (server)
    local opts = vim.tbl_deep_extend("force", server_opts, servers[server] or {})
    lspconfig[server].setup(opts)
  end,
}
