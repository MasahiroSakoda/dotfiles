local ok, gpt = pcall(require, "nvim-gpt")
if not ok then return end

gpt.setup({
  ---@Usage "gpt-3.5-turbo", "gpt-4", "gpt-4-32k", "creative", "balanced", "percise"
  model = "balanced",
  no_default_keymaps = true,
  window_width = 45,
})
