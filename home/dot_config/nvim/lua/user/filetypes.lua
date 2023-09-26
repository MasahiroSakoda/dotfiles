local Filetypes = {}

Filetypes.log  = { "log", "txt", "text" }
Filetypes.js   = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
Filetypes.json = { "json", "json5", "jsonc" }
Filetypes.makefile = { "Makefile", "MAKEFILE", "makefile", "make" }
Filetypes.markdown = { "markdown", "md" }

Filetypes.treesitter = {
  -- Compiled Languages
  "c", "cpp", "arduino", "swift", "llvm",
  "c_sharp", "java", "scala", "kotlin", "clojure",
  "erlang", "elixir",
  "go", "haskell", "rust", "zig",
  -- Script Languages
  "perl", "php", "python", "ruby", "lua", "vim", "r",
  -- Javascript
  "javascript", "typescript", "tsx", "vue",
  "json", "json5", "jsonc",
  -- Markup Languages
  "html", "css", "scss",
  "yaml", "toml", "markdown", "markdown_inline", "latex",
  -- Shell
  "awk", "bash", "fish", -- "zsh",
  -- Command
  "vimdoc", "diff", "regex",
  -- Git
  "gitattributes", "gitignore", "gitcommit", "git_rebase",
  -- Build
  "make", "cmake",
  -- DevOps
  "dockerfile", "terraform",
  -- Protocol
  "http",
  -- Query Languages
  "sql", "graphql",
  -- ORM
  "prisma",
}

Filetypes.colorizer = {
  "vim", "lua",
  "html", "eruby", "css", "markdown",
  "javascript", "typescript", "javascriptreact", "typescriptreact",
}

Filetypes.autotag = {
  "html", "xhtml", "xml",
  "javascript", "typescript",
  "javascriptreact", "typescriptreact", "markdown",
}

Filetypes.endwise = {
  "lua", "vim", "ruby", "elixir" ,"bash",  "fish",
}

Filetypes.matchup = {
  "sh", "bash", "csh", "zsh",
  "vim", "lua",
  "make", "cmake",
  "c", "cpp",
  "ruby", "eruby",
  "perl", "php",
  "javascript", "javascriptreact", "typescriptreact",
  "html", "xhtml", "xml", "haml",
}

Filetypes.lsp = {
  clang_format = { ".clang_format" },
  stylua       = { "stylua.toml", ".stylua.toml" },
  rubocop      = { ".rubocop.yml" },
  prettier     = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" },
  eslint       = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" },
  terraform    = { "terraform", "tf" },
}

Filetypes.tabnine = {
  "*.rs", "*.go", "*.sh", "*.py", "*.rb", "*.lua",
  "*.html", "*.css", "*.scss",
  "*.js", "*.jsx", "*.ts", "*.tsx",
}

return Filetypes
