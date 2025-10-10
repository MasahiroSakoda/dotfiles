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
