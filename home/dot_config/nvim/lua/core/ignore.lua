-- -*-mode:lua-*- vim:ft=lua

local files = {}
for _, categories in pairs(require("user.filetypes").ignore) do
  for _, filetype in pairs(categories) do table.insert(files, filetype) end
end

return {
  files = files,
  autopairs  = { "TelescopePrompt", "vim" },
  illuminate = { "alpha", "lazy", "oil", "TelescopePrompt", "toggleterm", "Trouble" },

  lualine = {
    statusline = { "alpha", "dashboard", "lazy", "lspsagaoutline" },
    winbar     = { "alpha", "dashboard", "dapui*", "Trouble", "oil" },
  },
  flash = { "flash_prompt", "notify", "noice", "oil", "cmp_menu" },
  oil   = {
    ".", "..", ".git", ".DS_Store",
    ".venv", ".direnv", ".devenv",
    ".cargo", "node_modules", "__pycache__", ".mypy_cache", ".pytest_cache", ".ruff_cache",
  },
}
