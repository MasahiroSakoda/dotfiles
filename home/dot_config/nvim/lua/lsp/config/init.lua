local lsp_ok, lspconfig       = pcall(require, "lspconfig")
local mason_cfg_ok, mason_cfg = pcall(require, "mason-lspconfig")
local cmp_ok, cmp_nvim_lsp    = pcall(require, "cmp_nvim_lsp")
local navic_ok, navic         = pcall(require, "nvim-navic")
local neodev_ok, neodev       = pcall(require, "neodev")
local neoconf_ok, neoconf     = pcall(require, "neoconf")

if not lsp_ok  then
  vim.notify('[lspconfig] Loading "lspconfig" failed.', vim.log.levels.WARN)
elseif not mason_cfg_ok then
  vim.notify('[lspconfig] Loading "mason-lspconfig" failed.', vim.log.levels.WARN)
elseif not cmp_ok then
  vim.notify('[lspconfig] Loading "cmp_nvim_lsp" failed.', vim.log.levels.WARN)
elseif not navic_ok then
  vim.notify('[lspconfig] Loading "nvim-navic" failed.', vim.log.levels.WARN)
elseif not neodev_ok then
  vim.notify('[lspconfig] Loading "neodev" failed.', vim.log.levels.WARN)
end

require("lsp.config.handlers")

neodev.setup({
})

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

local on_attach = function(client, bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  client.server_capabilities.document_formatting        = false
  client.server_capabilities.document_range_formatting  = false
  client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false

  client.server_capabilities.offsetEncoding = { "utf-16" }

  -- Avoid confliction tsserver + eslint & denols
  if client.name == "tsserver" or client.name == "eslint" then
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
      elseif _client.name == "eslint" then
        client.stop()
      end
    end
  end

  if client.server_capabilities.documentSymbolProvider then
    -- vim.g.navic_silence = true
    navic.attach(client, bufnr)
  end
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


-- local setup_inlay_hints = function()
--   local hl = vim.api.nvim_get_hl(0, { name = "Comment" })
--   local foreground = string.format("#%06x", hl["fg"] or 0)
--   if #foreground < 3 then
--     foreground = ""
--   end
--
--   hl = vim.api.nvim_get_hl(0, { name = "CursorLine" })
--   local background = string.format("#%06x", hl["bg"] or 0)
--   if #background < 3 then
--     background = ""
--   end
--   vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = foreground, bg = background })
-- end
--
-- local supports_inlay_hint = function(args)
--   local client = vim.lsp.get_client_by_id(args.data.client_id)
--   return client.supports_method("textDocument/inlayHint")
-- end
--
-- api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     -- Inlay Hints
--     if vim.fn.has('nvim-0.10') ~= 1 or vim.lsp.buf.inlay_hint == nil then
--       vim.notify_once('LSP Inlayhints requires Neovim 0.10.0+ (ca5de93)', vim.log.levels.ERROR)
--     else
--       supports_inlay_hint(args)
--       local bufnr = args.buf
--       local client = vim.lsp.get_client_by_id(args.data.client_id)
--       if client.supports_method("textDocument/inlayHint") then
--         setup_inlay_hints()
--         -- vim.lsp.inlay_hint(bufnr, true)
--         vim.lsp.buf.inlay_hint(bufnr, true)
--       end
--     end
--   end
-- })
