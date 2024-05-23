-- -*-mode:lua-*- vim:ft=lua

local files = {}
for _, ft in ipairs(require("user.filetypes").ignore) do
  table.insert(files, unpack(ft))
end

return {
  files = files,
  autopairs  = { "TelescopePrompt", "vim" },
  illuminate = { "alpha", "lazy", "neo-tree*", "TelescopePrompt", "toggleterm", "Trouble" },

  lualine = {
    statusline = { "alpha", "dashboard", "lazy", "lspsagaoutline",  "neo-tree*" },
    winbar     = { "alpha", "dashboard", "dapui*", "neo-tree*", "Trouble" },
  },
  scrollbar = {
    buftypes  = { "nofile", "nowrite", "prompt", "TelescopePrompt", "toggleterm", "neo-tree*", "noice", "notify" },
    filetypes = { "alpha", "dashboard", "dapui*", "neo-tree*", "noice", "notify", "qf", "TelescopePrompt" },
  },
  flash = { "flash_prompt", "notify", "noice", "neo-tree*", "cmp_menu" },
}
