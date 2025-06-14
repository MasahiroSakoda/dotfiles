-- -*-mode:lua-*- vim:ft=lua

local function virtual_text_document_handler(uri, res, client)
  if not res then
    return nil
  end

  local lines = vim.split(res.result, "\n")
  local bufnr = vim.uri_to_bufnr(uri)

  local current_buf = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if #current_buf ~= 0 then
    return nil
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_set_options_value("readonly",   true,  { buf = bufnr })
  vim.api.nvim_set_options_value("modified",   false, { buf = bufnr })
  vim.api.nvim_set_options_value("modifiable", false, { buf = bufnr })
  vim.lsp.buf_attach_client(bufnr, client.id)
end

local function virtual_text_document(uri, client)
  local params = {
    textDocument = {
      uri = uri,
    },
  }
  local result = vim.lsp.buf_request_sync(0, "deno/virtualTextDocument", params)
  virtual_text_document_handler(uri, result, client)
end

local function denols_handler(err, result, ctx, config)
  if not (result or vim.tbl_isempty(result)) then
    return nil
  end

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  for _, res in ipairs(result) do
    local uri = res.uri or res.targetUri
    if uri:match "^deno:" then
      virtual_text_document(uri, client)
      res["uri"]       = uri
      res["targetUri"] = uri
    end
  end
  vim.lsp.handlers[ctx.method](err, result, ctx, config)
end

local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd          = { "deno", "lsp" },
  root_markers = ft.lsp.deno,
  filetypes    = ft.lang.js,
  autostart    = true,
  init_options = {
    enable    = true,
    lint      = true,
    unstable  = true,
    suggest   = {
      imports = {
        hosts = {
          ["https://deno.land"]     = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"]     = true,
        },
      },
    },
  },
  handlers = {
    ["textDocument/definition"]     = denols_handler,
    ["textDocument/typeDefinition"] = denols_handler,
    ["textDocument/references"]     = denols_handler,
  },

  settings = {
    deno = {
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues          = { enabled = true },
        functionLikeReturnTypes   = { enabled = true },
        parameterNames            = { enabled = true, suppressWhenArgumentMatchesName = true },
        parameterTypes            = { enabled = true },
        propertyDeclarationTypes  = { enabled = true },
        variableTypes             = { enabled = true, suppressWhenTypeMatchesName = true },
      },
    },
  },

  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(0, "LspDenolsCache", function()
      client:exec_cmd({
        title = "",
        command = "deno.cache",
        arguments = {{}, vim.uri_from_bufnr(bufnr)},
      }, { bufnr = bufnr },
        function(err, _, ctx)
          if err then
            local uri = ctx.params.arguments[2]
            vim.api.nvim_echo({ { "cache command failed for " .. vim.uri_to_fname(uri) } }, true, { err = true })
          end
        end
      )
    end, {desc = "Cache a module and all of its dependencies."})
  end,
}
