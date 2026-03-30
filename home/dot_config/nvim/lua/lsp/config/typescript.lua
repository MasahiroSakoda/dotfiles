-- -*-mode:lua-*- vim:ft=lua
local ok, tstools = pcall(require, "typescript-tools")
if not ok then return end

tstools.setup({
  on_attach = function(client, bufnr)
    -- Disable tsserver's formatting capability to prevent conflict
    client.server_capabilities.documentFormattingProvider      = false
    client.server_capabilities.documentRangeFormattingProvider = false
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end
  end,

  root_dir = function(bufnr, on_dir)
    -- Exclude deno projects
    if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
      return
    end
    local root = vim.fs.root(bufnr, {
      "turbo.json",
      "pnpm-workspace.yaml",
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      ".git",
    })
    if root then
      return on_dir(root)
    end
  end,

  cmd = { "typescript-language-server", "--stdio" },
  capabilities = require("lsp.config.capabilities"),
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    tsserver_plugins = {},
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
  },
})
