local ok, vt = pcall(require, "nvim-dap-virtual-text")
if not ok then return end

vt.setup({
  enabled   = true,
  commented = false,
  only_first_definition = false,
  show_stop_reason = true,
  all_references = true,

  -- builtin LSP inlay hints on Neovim >= 0.10.0
  virtual_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

  -- experimental features:
  virt_lines = false,
})
