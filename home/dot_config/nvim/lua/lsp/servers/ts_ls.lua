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
  updateImportsOnFileMove = { enabled = "always" },
}

---@type vim.lsp.Config
return {
  init_options = { hostInfo = "neovim" },
  cmd          = { "typescript-language-server", "--stdio" },
  filetypes    = require("user.filetypes").lang.js,
  autostart    = true,

  root_dir = function(bufnr, on_dir)
    local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
    root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
      or vim.list_extend(root_markers, { ".git" })
    local deno_path = vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" })
    local project_root = vim.fs.root(bufnr, root_markers)
    if deno_path and (not project_root or #deno_path >= #project_root) then
      return
    end
    on_dir(project_root or vim.fn.getcwd())
  end,

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

  settings = {
    javascript = settings,
    typescript = settings,
  },
}
