-- -*-mode:lua-*- vim:ft=lua

---@see https://eiji.page/blog/neovim-diagnostic-config/
vim.diagnostic.config({
  underline     = true,
  severity_sort = true,
  severity      = { min = vim.diagnostic.severity.HINT },
  virtual_text  = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end
  },
})
