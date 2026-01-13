-- -*-mode:lua-*- vim:ft=lua

local files = {}
for _, categories in pairs(require("user.filetypes").ignore) do
  for _, filetype in pairs(categories) do table.insert(files, filetype) end
end

return {
  files = files,
  autopairs  = { "fzf", "vim", "snacks_picker_input" },
  illuminate = { "lazy", "oil", "fzf" },

  lualine = {
    statusline = { "dashboard", "lazy" },
    winbar     = { "dashboard", "dapui*", "oil" },
  },
  flash = {
    "flash_prompt", "notify", "noice", "oil", "cmp_menu", "blink-cmp-menu", "snacks_dashboard",
    function(win) return not vim.api.nvim_win_get_config(win).focusable end,
  },
  oil   = {
    ".", "..", ".git", ".DS_Store",
    ".venv", ".direnv", ".devenv",
    ".cargo", "node_modules", "__pycache__", ".mypy_cache", ".pytest_cache", ".ruff_cache",
  },
}
