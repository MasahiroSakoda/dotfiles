-- -*-mode:lua-*- vim:ft=lua

local lsp, api = vim.lsp, vim.api
local virtual_text_document_handler = function(uri, result)
  if not result then
    return
  end
  for client_id, res in ipairs(result) do
    local lines = vim.split(res.result, "\n")
    local bufnr = vim.uri_to_bufnr(uri)

    local current_buf = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    if #current_buf ~= 0 then
      return nil
    end

    api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.bo.readonly   = true
    vim.bo.modified   = true
    vim.bo.modifiable = true
    lsp.buf_attach_client(bufnr, client_id)
  end
end

local virtual_text_document = function(uri)
  local params = {
    textDocument = {
      uri = uri,
    },
  }
  local result = lsp.buf_request_sync(0, "deno/virtualTextDocument", params)
  virtual_text_document_handler(uri, result)
end

local denols_handler = function(err, result, ctx)
  if not (result or vim.tbl_isempty(result)) then
    return nil
  end

  for _, res in ipairs(result) do
    local uri = res.uri or res.targetUri
    if uri:match "^deno:" then
      virtual_text_document(uri)
      res['uri'] = uri
      res['targetUri'] = uri
    end
  end
  lsp.handlers[ctx.method](err, result, ctx)
end

local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd          = { "deno", "lsp" },
  root_markers = ft.lsp.deno,
  autostart = true,
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
  filetypes = ft.lang.js,
  handlers = {
    ["textDocument/definition"] = denols_handler,
    ["textDocument/references"] = denols_handler,
  },

  settings = {
    deno = {
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        parameterNames = {
          enabled = true,
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = true,
        },
      },
    },
  },
}
