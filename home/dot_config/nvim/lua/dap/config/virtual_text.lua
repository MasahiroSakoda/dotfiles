local ok, vt = pcall(require, "nvim-dap-virtual-text")
if not ok then return end

vt.setup({
  enabled   = true,
  commented = false,
  only_first_definition = false,
  show_stop_reason = true,
  all_references = true,

  -- experimental features:
  virt_lines = false,
})
