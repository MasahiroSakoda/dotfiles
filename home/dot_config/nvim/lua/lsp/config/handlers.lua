-- -*-mode:lua-*- vim:ft=lua

-- Supress "No Information Available" notifications
vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = function(_, result, _, config)
  config = config or {}
  if not (result and result.contents) then
    return
  end

  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.split(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then
    return
  end

  return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

-- Jump directly to the first available definition every time.
vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_definition] = function(err, result, ctx, _)
  local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
  if err then
    vim.notify(string.format("[%s] Definition error: ", client.name, err), vim.log.levels.ERROR)
    return
  end

  if not result or vim.tbl_isempty(result) then
    vim.notify(string.format("[%s]: Could not find definition", client.name), vim.log.levels.INFO)
    return
  end

  if vim.islist(result) then
    vim.lsp.util.show_document(result[1], client.offset_encoding, { reuse_win = false, focus = true })
  else
    vim.lsp.util.show_document(result, client.offset_encoding, { reuse_win = false, focus = true })
  end
end

vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_references] = function(err, result, ctx, _)
  local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
  if err then
    vim.notify(string.format("[%s] Reference error: %s", client.name, err), vim.log.levels.ERROR)
    return
  end

  if not result or vim.tbl_isempty(result) then
    vim.notify(string.format("[%s]: No references found", client.name), vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist(vim.lsp.util.locations_to_items(result, "utf-8"))
  vim.api.nvim_command("copen")
end

vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_codeAction] = function(_, _, actions)
  if not actions or vim.tbl_isempty(actions) then
    return
  end

  vim.lsp.util.show_code_actions(actions)
end
