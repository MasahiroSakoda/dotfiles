local Filetypes = {}

Filetypes.log  = { "log", "txt", "text" }
Filetypes.js   = { "javascript", "typescript", "javascript.jsx", "typescript.tsx", "javascriptreact", "typescriptreact" }
Filetypes.json = { "json", "json5", "jsonc" }
Filetypes.makefile = { "Makefile", "MAKEFILE", "makefile", "make" }
Filetypes.markdown = { "markdown", "md", "vimwiki" }

Filetypes.treesitter = {
  -- Compiled Languages
  "c", "cpp", "objc", "arduino", "swift", "llvm",
  "c_sharp", "java", "scala", "kotlin", "clojure",
  "erlang", "elixir",
  "go", "gomod", "gosum", "gowork", "templ",
  "haskell", "rust", "zig", "nasm", "cuda",
  -- Script Languages
  "perl", "php", "python", "requirements", "ruby", "lua", "luadoc", "vim", "r", "matlab",
  -- Javascript
  "javascript", "typescript", "tsx", "vue",
  "json", "json5", "jsonc", "jsdoc", "jq",
  -- Markup Languages
  "html", "css", "scss",
  "xml", "yaml", "toml", "kdl", "markdown", "markdown_inline", "latex", "rst",
  -- Shader Languages
  "glsl", "hlsl", "wgsl",
  -- Shell
  "awk", "bash", "fish", -- "zsh",
  -- Command
  "vimdoc", "diff", "regex",
  -- Security
  "ssh_config", "gpg",
  -- Git
  "git_config", "gitattributes", "gitignore", "gitcommit", "git_rebase",
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
  -- saparated value
  "csv", "tsv",
  -- Package manager
  "nix",
  -- Others
  "ini", "comment",
}

Filetypes.actions = { "yaml.github" }

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
  revive       = { "revive.toml" },
  ruff         = { "pyproject.toml", "ruff.toml", ".ruff.toml" },
  rubocop      = { ".rubocop.yml" },
  tsserver     = { "jsconfig.json", "tsconfig.json" },
  prettier     = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" },
  eslint       = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" },
  deno         = { "deno.json", "deno.jsonc" },
  biome        = { "biome.json" },
  terraform    = { "terraform", "tf" },
  markdownlint = { ".markdownlintrc", ".markdownlint.json", ".markdownlint.jsonc" },
}

Filetypes.tabnine = {
  "*.rs", "*.go", "*.sh", "*.py", "*.rb", "*.lua",
  "*.html", "*.css", "*.scss",
  "*.js", "*.jsx", "*.ts", "*.tsx",
}

return Filetypes
