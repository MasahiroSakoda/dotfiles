-- -*-mode:lua-*- vim:ft=lua
return function()
  vim.lsp.buf.format({
    async = false,
    timeout_ms = 2000,
    filter = function(c)
      return (not vim.tbl_contains(require("lsp.config.ignore").format, c.name) and c.name ~= "null-ls")
    end,
  })
end
