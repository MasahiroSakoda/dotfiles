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

require("lsp.config.handlers")

local api, lsp = vim.api, vim.lsp
local active_clients = lsp.get_active_clients()
-- local inlay_hint     = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
-- local setup_inlay_hints = function()
--   local hl = api.nvim_get_hl(0, { name = "Comment" })
--   local foreground = string.format("#%06x", hl["fg"] or 0)
--   if #foreground < 3 then foreground = "" end

--   hl = api.nvim_get_hl(0, { name = "CursorLine" })
--   local background = string.format("#%06x", hl["bg"] or 0)
--   if #background < 3 then background = "" end
--   api.nvim_set_hl(0, 'LspInlayHint', { fg = foreground, bg = background })
-- end

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
  capabilities = require("lsp.config.capabilities"),
}
mason_cfg.setup_handlers {
  function (server)
    local opts = vim.tbl_deep_extend("force", server_opts, servers[server] or {})
    lspconfig[server].setup(opts)
  end,
}
