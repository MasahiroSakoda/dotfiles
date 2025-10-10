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
vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_definition] = function(err, result, ctx, config)
  if not result or vim.tbl_isempty(result) then
    vim.notify("[LSP]: Could not find definition\n" .. err, vim.log.levels.INFO)
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end
