-- -*-mode:lua-*- vim:ft=lua

return {
  require("plugins.dependencies"),
  require("plugins.appearance"),
  require("plugins.editor"),
  require("plugins.lsp"),
  require("plugins.cmp"),
  require("plugins.dap"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.ai"),

  ------------------------------------------------------------------------
  -- Others
  ------------------------------------------------------------------------
  -- Translate Engine
  { "potamides/pantran.nvim", cmd = "Pantran", config = function() require("user.pantran") end },

  { "vim-denops/denops.vim" },
  -- Markdown Previewer
  {
    "kat0h/bufpreview.vim",
    dependencies = { "vim-denops/denops.vim" },
    build = "deno task prepare",
    ft    = "markdown",
    cmd   = "PreviewMarkdown",
  },
}
