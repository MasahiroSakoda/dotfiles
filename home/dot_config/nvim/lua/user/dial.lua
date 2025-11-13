local dial_ok, dial     = pcall(require, "dial.config")
local augend_ok, augend = pcall(require, "dial.augend")
if not (dial_ok or augend_ok) then return end

local default_augends = {
  augend.integer.alias.decimal,
  augend.integer.alias.hex,
  augend.constant.alias.bool,
  augend.constant.alias.Alpha,
  augend.constant.alias.alpha,
  augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true, preserve_case = true }),
  augend.date.alias["%m/%d/%Y"],
  augend.date.alias["%Y-%m-%d"],
  augend.date.alias["%m/%d/%Y"],
  augend.date.alias["%m/%d"],
  augend.date.alias["%H:%M"],
  augend.date.alias["%H:%M:%S"],
  augend.date.new({ pattern = "%a", default_kind = "day", word = true }),
  augend.date.new({ pattern = "%a", default_kind = "day", word = true }),
  augend.date.new({ pattern = "%b", default_kind = "day", word = true }),
  augend.date.new({ pattern = "%B", default_kind = "day", word = true }),
  augend.constant.alias.ja_weekday,
  augend.constant.alias.ja_weekday_full,

  augend.hexcolor.new({ case = "lower", cyclic = true }),
  augend.case.new({
    types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
    cyclic = true,
  }),

  augend.semver.alias.semver,
  augend.constant.new({ elements = { "yes", "no" },  word = true,  cyclic = true, preserve_case = true }),
  augend.constant.new({ elements = { "and", "or" },  word = true,  cyclic = true, preserve_case = true }),
  augend.constant.new({ elements = { "&&", "||" },   word = false, cyclic = true }),
  augend.constant.new({ elements = { "==", "!=" },   word = false, cyclic = true }),
  augend.constant.new({ elements = { "public", "private" }, word = true, cyclic = true, preserve_case = true }),

  augend.constant.new({ elements = { "prev", "next" },  word = true, cyclic = true, preserve_case = true }),
  augend.constant.new({ elements = { "open", "close" }, word = true, cyclic = true, preserve_case = true }),
  augend.constant.new({ elements = { "up", "down" },    word = true, cyclic = true, preserve_case = true }),
  augend.constant.new({ elements = { "read", "unread" },          word = true, cyclic = true }),
  augend.constant.new({ elements = { "ascending", "descending" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "horizontal", "vertical" },  word = true, cyclic = true }),
  augend.constant.new({ elements = { "top", "middle", "bottom" }, word = true, cyclic = true }),
  augend.constant.new({
    elements = { "ollama", "groq", "copilot", "openai", "anthropic", "google" },
    word = true,
    cyclic = true,
    preserve_case = true,
  }),
}

dial.augends:register_group({ default = default_augends })

dial.augends:on_filetype({
  lua = vim.list_extend(default_augends, {
    augend.paren.alias.lua_str_literal,
    augend.constant.new({ elements = { "==", "~=" }, word = false, cyclic = true }),
    augend.constant.new({
      elements = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
      word = true,
      cyclic = true,
      preserve_case = true,
    }),
  }),

  markdown = vim.list_extend(default_augends, {
    augend.misc.alias.markdown_header,
    augend.constant.new({ elements = { "[x]", "[ ]" }, word = false, cyclic = true }),
  }),

  rust = vim.list_extend(default_augends, {
    augend.paren.alias.rust_str_literal,
    augend.constant.new({ elements = { "let", "const" },                    word = true, cyclic = true }),
    augend.constant.new({ elements = { "type", "trait", "struct", "enum" }, word = true, cyclic = true }),
    augend.constant.new({ elements = { "isize", "i8", "i16", "i32", "i64", "i128" }, word = true, cyclic = true }),
    augend.constant.new({ elements = { "usize", "u8", "u16", "u32", "u64", "u128" }, word = true, cyclic = true }),
    augend.constant.new({ elements = { "f32", "f64" },                               word = true, cyclic = true }),
  }),

  zig = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "var", "const" }, word = true, cyclic = true }),
  }),

  haskell = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "==", "/=" }, word = false, cyclic = true }),
  }),

  go = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { ":=", "=" },             word = false, cyclic = true }),
    augend.constant.new({ elements = { "interface", "struct" }, word = true,  cyclic = true }),

    augend.constant.new({ elements = { "int", "int8", "int16", "int32", "int64" },      word = true,  cyclic = true }),
    augend.constant.new({ elements = { "uint", "uint8", "uint16", "uint32", "uint64" }, word = true,  cyclic = true }),
    augend.constant.new({ elements = { "float32", "float64" },                          word = true,  cyclic = true }),
    augend.constant.new({ elements = { "complex64", "complex128" },                     word = true,  cyclic = true }),
  }),

  java = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "private", "public", "protected" }, word = true, cyclic = true }),
    augend.constant.new({ elements = { "class", "interface", "enum" },     word = true, cyclic = true }),
  }),

  python = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "True", "False" }, word = true, cyclic = true }),
  }),

  css = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "px", "em", "rem", "%" }, word = false, cyclic = true }),
  }),
})

local js_augends = vim.list_extend(default_augends, {
  augend.constant.new({ elements = { "===", "!==" },                     word = false, cyclic = true }),
  augend.constant.new({ elements = { "of", "in" },                       word = true,  cyclic = true }),
  augend.constant.new({ elements = { "let", "const" },                   word = true,  cyclic = true }),
  augend.constant.new({ elements = { "private", "public", "protected" }, word = true,  cyclic = true }),
})

vim.iter({
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "jsx",
  "tsx",
  "vue",
  "svelte",
  "astro",
}):each(function(ft)
  dial.augends:on_filetype({
    [ft] = js_augends,
  })
end)
