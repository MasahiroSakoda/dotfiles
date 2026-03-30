-- -*-mode:lua-*- vim:ft=lua

---@type vim.diagnostic.Opts
vim.diagnostic.config({
  severity_sort = true,
  severity      = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.ERROR },
  underline     = { severity = vim.diagnostic.severity.ERROR },
  jump          = {
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then return end
      vim.schedule(function()
        vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
      end)
    end,
  },
  virtual_text  = {
    prefix = "●",
    spacing = 2,
    format = function(d)
      return string.format("%s (%s: %s)", d.message, d.source, d.code)
    end,
  },
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk",    { link = "DiagnosticOk" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { link = "DiagnosticHint" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { link = "DiagnosticInfo" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "DiagnosticError" })
