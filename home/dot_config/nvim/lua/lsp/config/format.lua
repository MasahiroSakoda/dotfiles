-- -*-mode:lua-*- vim:ft=lua
return function()
  vim.lsp.format({
    async = true,
    timeout_ms = 2000,
    filter = function(client)
      return not vim.tbl_contains(require("lsp.config.ignore").format, client.name)
    end,
  })
end
