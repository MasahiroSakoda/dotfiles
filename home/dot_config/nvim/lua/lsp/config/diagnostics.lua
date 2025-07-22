-- -*-mode:lua-*- vim:ft=lua

---@type vim.diagnostic.Opts
vim.diagnostic.config({
  severity_sort = true,
  severity      = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.ERROR },
  underline     = { severity = vim.diagnostic.severity.ERROR },
  jump          = { float = true },
  virtual_text  = {
    prefix = "●",
    spacing = 2,
    format = function(d)
      return string.format("%s (%s: %s)", d.message, d.source, d.code)
    end,
  },
})
