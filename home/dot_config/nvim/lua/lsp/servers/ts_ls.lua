-- -*-mode:lua-*- vim:ft=lua

local settings = {
  completions = { completeFunctionCalls = true },
  suggest     = { includeCompletionsForModuleExports = true },
  inlayHints  = {
    includeInlayEnumMemberValueHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayParameterNameHints = "all", ---@type "none"|"literals"|"all"
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayVariableTypeHints = true,
  },
}

---@type vim.lsp.Config
return {
  cmd       = { "typescript-language-server", "--stdio" },
  filetypes = require("user.filetypes").lang.js,
  root_markers = { "package.json", "jsconfig.json", "tsconfig.json", ".git" },
  autostart = false,

  handlers = {
    ["_typescript.rename"] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri   = result.textDocument.uri,
        range = {
          ["start"] = result.position,
          ["end"]   = result.position,
        },
      }, client.offset_encoding)
      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },

  on_attach = function(client)
    vim.api.nvim_buf_create_user_command(0, "LspTypescriptSourceAction", function()
      local actions = vim.tbl_filter(function(action)
        return vim.startwith(action, "source.")
      end, client.server_capabilities.codeActionProvider.codeActionKinds)
      vim.lsp.buf.code_action({
        context = {
          only = actions,
          diagnostics = {},
        },
      })
    end, {})
  end,
}
