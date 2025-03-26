local ok, vt = pcall(require, "nvim-dap-virtual-text")
if not ok then return end

vt.setup({
  enabled    = true,
  enable_commands = true,
  all_frames = false,
  commented  = false,
  only_first_definition = false,
  show_stop_reason = true,
  all_references   = true,
  separator    = "",
  text_prefix  = "",
  info_prefix  = "",
  error_prefix = "",
  highlight_changed_variables = true,
  highlight_new_as_changed    = false,
  filter_references_pattern = "",
  virt_text_pos = "eol",
  virt_lines_above = true,
  display_callback = nil,
  clear_on_continue = false,

  -- builtin LSP inlay hints on Neovim >= 0.10.0
  virtual_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

  -- experimental features:
  virt_lines = false,
})
