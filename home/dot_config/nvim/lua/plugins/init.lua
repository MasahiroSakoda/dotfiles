-- -*-mode:lua-*- vim:ft=lua

return {
  -- Dependencies
  require("plugins.dependencies"),

  -- Appearance
  require("plugins.appearance"),

  -- Editor
  require("plugins.editor"),

  -- LSP: Language Server Protocol
  require("plugins.lsp"),

  -- Completion
  require("plugins.cmp"),

  -- DAP: Debug Adapter Protocol
  require("plugins.dap"),

  -- Treesitter: Language Parser / Syntax highlighter
  require("plugins.treesitter"),

  -- Telescope: Fuzzy Finder
  require("plugins.telescope"),

  -- AI Assistant
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
