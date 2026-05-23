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
    separate_diagnostic_server = false,
    publish_diagnostic_on      = "insert_leave",

    complete_function_calls = false,
    include_completions_with_insert_text = false,

    -- Disable codelens
    code_lens                = "off",
    disable_member_code_lens = false,

    tsserver_plugins = {},

    tsserver_file_preferences = {
      -- Disable inlay hints
      includeInlayParameterNameHints = "none",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints                = false,
      includeInlayVariableTypeHints                         = false,
      includeInlayPropertyDeclarationTypeHints              = false,
      includeInlayFunctionLikeReturnTypeHints               = false,
      includeInlayEnumMemberValueHints                      = false,

      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },

    tsserver_watch_options = {
      watchFile       = "useFsEvents",
      watchDirectory  = "useFsEvents",
      fallbackPolling = "dynamicPriority",
    },
  },
})
