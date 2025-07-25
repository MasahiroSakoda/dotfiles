local Filetypes = {}

Filetypes.log  = { "log", "txt", "text" }
Filetypes.makefile = { "Makefile", "MAKEFILE", "makefile", "make" }
Filetypes.markdown = { "markdown", "md", "vimwiki" }

Filetypes.lang = {
  shell = { "sh",  "bash", "zsh" },
  go    = { "go", "gomod", "gosum", "templ", "gotempl" },
  json  = { "json",  "json5", "jsonc" },
  js    = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  html  = { "html", "templ", "htmldjango", "eruby" },
  glsl  = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
  latex = { "tex", "plaintex", "bib" },
}

Filetypes.treesitter = {
  -- Compiled Languages
  "c", "cpp", "objc", "arduino", "swift", "llvm",
  "c_sharp", "java", "scala", "kotlin", "clojure",
  "erlang", "elixir",
  "go", "gomod", "gosum", "gowork", "gotmpl", "templ",
  "haskell", "rust", "zig", "nasm", "cuda",
  -- Script Languages
  "perl", "php", "python", "requirements", "ruby", "lua", "luadoc", "vim", "r", "matlab",
  -- Javascript
  "javascript", "typescript", "tsx", "vue", "svelte",
  "json", "json5", "jsonc", "jsdoc", "jq",
  -- Markup Languages
  "html", "css", "scss",
  "xml", "yaml", "toml", "kdl", "markdown", "markdown_inline", "latex", "rst",
  "glimmer",
  -- Shader Languages
  "glsl", "hlsl", "wgsl",
  -- Shell
  "awk", "bash", "fish", "nu",
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
  "ini", "comment", "editorconfig",
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

Filetypes.endwise = { "lua", "vim", "ruby", "elixir", "bash", "fish" }

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
  rust         = { "Cargo.toml", "rust-project.json" },
  golangci     = { ".golangci.yml", ".golangci.yaml", ".golangci.toml", ".golangci.json" },
  pyright      = { ".venv", "venv", "setup.py", "setup.cfg", "requirements.txt", "pyproject.toml" },
  ruff         = { "pyproject.toml", "ruff.toml", ".ruff.toml" },
  ruby         = { ".git", "Gemfile" },
  tsserver     = { "jsconfig.json", "tsconfig.json" },
  prettier     = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" },
  eslint       = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" },
  deno         = { "deno.json", "deno.jsonc" },
  biome        = { "biome.json", "biome.jsonc" },
  tailwindcss  = {
    "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts",
    "postcss.config.js", "postcss.config.cjs", "postcss.config.mjs", "postcss.config.ts",
    "app/assets/stylesheets/application.tailwind.css", "app/assets/tailwind/application.css",
  },
  terraform    = { "terraform", "tf", "terraform-vars", "hcl" },
  tombi        = { "tombi.toml", "pyprojet.toml", ".git" },
  texlab       = { ".latexmkrc", "latexmkrc", ".textlabroot", "textlabroot", "Tectonic.toml" },
  sqruff       = { ".sqruff" },
}

Filetypes.ignore = {
  archive = { "%.tar$", "%.tar.gz$", "%.tar.xz$", "%.zip$", "%.rar$", "%.7z$", "%.bz2$" },
  vcs     = { "^.git/", "^.svn/", "^.hg/" },
  build   = { "build/", "dist/", "%.o$", "%.obj$", "%.so$", "%.a$", "%.out$", "%.whl$", "%.bin$" },
  ide     = { "^.idea/", "^.vscode/", "^.project/" },
  node    = { "node_modules/", "^.yarn/", "^.pnpm/", "^.npm", "%-lock.json$" },
  js      = { "%.min.js$", "%.min.gzip.js$" },
  java    = { "^.gradle/", "^.classpath/", "^.factorypath/", "%.class$", "%.jar$", "%.war$" },
  python  = { "^.venv/", "%.pyc$", "__pycache__", "%.ipynb$" },
  ruby    = { "vendor/", "deps/" },
  db      = { "%.sqlite$", "%.sqlite3$", "%.db$" },
  win     = { "%.exe$", "Thumb.db$", "desktop.ini$$$", "%.dll$", "%.pdb$" },
  mac     = { "^.DS_Store", "%.dylib$", "^.Trashs/" },
  font    = { "%.otf$", "%.ttf$", "%.woff$" },
  image   = { "%.png$", "%.jpg$", "%.jpeg$", "%.webp$", "%.gif$" },
  video   = { "%.mp4$", "%.mkv$", "%.m4v$", "%.avi$", "%.flv$" },
  audio   = { "%.wav$", "%.flac$", "%.ttf$", "%.mp3$", "%.m4a$", "%.ogg$" },
  office  = { "%.doc$", "%.xls$", "%.ppt$", "%.pdf$", "%.epub$" },
}

return Filetypes
