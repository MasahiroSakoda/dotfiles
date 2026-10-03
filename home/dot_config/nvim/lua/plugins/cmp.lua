-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "L3MON4D3/LuaSnip", -- Snippet completion sources
    dependencies = { "rafamadriz/friendly-snippets" },
    build   = "make install_jsregexp",
    version = "v2.*",
    event   = "InsertEnter",
    config  = function () require("config.editor.snippets") end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "onsails/lspkind.nvim" },
    cond         = not vim.g.vscode,
    event        = { "InsertEnter", "CmdlineEnter" },
    opts_extend  = { "sources.default", "sources.completion.enabled_providers" },
    config       = function() require("config.editor.completion") end,
  },
}
