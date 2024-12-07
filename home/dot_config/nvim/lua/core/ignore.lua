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
  scrollbar = {
    buftypes  = { "nofile", "nowrite", "prompt", "TelescopePrompt", "toggleterm", "oil", "noice", "notify" },
    filetypes = { "alpha", "dashboard", "dapui*", "oil", "noice", "notify", "qf", "TelescopePrompt" },
  },
  flash = { "flash_prompt", "notify", "noice", "oil", "cmp_menu" },
}
