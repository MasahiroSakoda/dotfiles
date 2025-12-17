local dial_ok, dial     = pcall(require, "dial.config")
local augend_ok, augend = pcall(require, "dial.augend")
if not (dial_ok or augend_ok) then return end

local default_augends = {
  -- dial.nvim primitives
  augend.integer.alias.decimal,
  augend.integer.alias.hex,
  augend.constant.alias.bool,
  augend.constant.alias.Alpha,
  augend.constant.alias.alpha,
  augend.constant.new({ elements = { "true", "false" }, word = true, preserve_case = true }),
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
  augend.hexcolor.new({ case = "lower" }),
  augend.case.new({ types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" } }),

  augend.semver.alias.semver,

  -- Antonyms
  augend.constant.new({ elements = { "yes", "no" },                word = true, preserve_case = true }),
  augend.constant.new({ elements = { "and", "or" },                word = true, preserve_case = true }),
  augend.constant.new({ elements = { "on", "off" },                word = true, preserve_case = true }),
  augend.constant.new({ elements = { "in", "out" },                word = true, preserve_case = true }),
  augend.constant.new({ elements = { "inner", "outer" },           word = true, preserve_case = true }),
  augend.constant.new({ elements = { "new", "old" },               word = true, preserve_case = true }),
  augend.constant.new({ elements = { "get", "set" },               word = true, preserve_case = true }),
  augend.constant.new({ elements = { "min", "max" },               word = true, preserve_case = true }),
  augend.constant.new({ elements = { "enable", "disable" },        word = true, preserve_case = true }),
  augend.constant.new({ elements = { "public", "private" },        word = true, preserve_case = true }),
  augend.constant.new({ elements = { "previous", "prev", "next" }, word = true, preserve_case = true }),
  augend.constant.new({ elements = { "Previous", "Prev", "Next" }, word = true, preserve_case = true }),
  augend.constant.new({ elements = { "first", "last" },            word = true, preserve_case = true }),
  augend.constant.new({ elements = { "open", "close" },            word = true, preserve_case = true }),
  augend.constant.new({ elements = { "up", "down" },               word = true, preserve_case = true }),
  augend.constant.new({ elements = { "high", "low" },              word = true, preserve_case = true }),
  augend.constant.new({ elements = { "read", "write" },            word = true, preserve_case = true }),
  augend.constant.new({ elements = { "width", "height" },          word = true, preserve_case = true }),
  augend.constant.new({ elements = { "asc", "desc" },              word = true, preserve_case = true }),
  augend.constant.new({ elements = { "ascending", "descending" },  word = true, preserve_case = true }),
  augend.constant.new({ elements = { "incoming", "outgoing" },     word = true, preserve_case = true }),
  augend.constant.new({ elements = { "increase", "decrease" },     word = true, preserve_case = true }),
  augend.constant.new({ elements = { "horizontal", "vertical" },   word = true, preserve_case = true }),
  augend.constant.new({ elements = { "top", "middle", "bottom" },  word = true, preserve_case = true }),
  augend.constant.new({ elements = { "above", "below" },           word = true, preserve_case = true }),
  augend.constant.new({ elements = { "before", "after" },          word = true, preserve_case = true }),
  augend.constant.new({ elements = { "forward", "backward" },      word = true, preserve_case = true }),
  augend.constant.new({ elements = { "foreground", "background" }, word = true, preserve_case = true }),
  augend.constant.new({ elements = { "fg", "bg" },                 word = true, preserve_case = true }),
  augend.constant.new({ elements = { "collapse", "expand" },       word = true, preserve_case = true }),
  augend.constant.new({ elements = { "positive", "negative" },     word = true, preserve_case = true }),
  augend.constant.new({ elements = { "passive", "active" },        word = true, preserve_case = true }),

  -- Programming symbols
  augend.constant.new({ elements = { "&&", "||" }, word = false }),
  augend.constant.new({ elements = { "==", "!=" }, word = false }),
  augend.constant.new({ elements = { "+=", "-=" }, word = false }),
  augend.constant.new({ elements = { "stdin", "stdout", "stderr" }, preserve_case = true }),
  augend.constant.new({ elements = { "trace", "debug", "info", "warn", "error", "fatal" }, word = true }),

  augend.constant.new({ elements = { "north", "east", "south", "west" }, word = true }),
  augend.constant.new({
    elements = { "ollama", "groq", "copilot", "openai", "anthropic", "google" },
    word = true,
    preserve_case = true,
  }),
}

dial.augends:register_group({ default = default_augends })

dial.augends:on_filetype({
  lua = vim.list_extend(default_augends, {
    augend.paren.alias.lua_str_literal,
    augend.constant.new({ elements = { "==", "~=" }, word = false }),
  }),

  markdown = vim.list_extend(default_augends, {
    augend.misc.alias.markdown_header,
    augend.constant.new({ elements = { "[x]", "[ ]" }, word = false }),
  }),

  rust = vim.list_extend(default_augends, {
    augend.paren.alias.rust_str_literal,
    augend.constant.new({ elements = { "let", "const" },                    word = true }),
    augend.constant.new({ elements = { "type", "trait", "struct", "enum" }, word = true }),
    augend.constant.new({ elements = { "isize", "i8", "i16", "i32", "i64", "i128" }, word = true }),
    augend.constant.new({ elements = { "usize", "u8", "u16", "u32", "u64", "u128" }, word = true }),
    augend.constant.new({ elements = { "f32", "f64" },                               word = true }),
  }),

  zig = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "var", "const" }, word = true }),
  }),

  haskell = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "==", "/=" }, word = false }),
  }),

  go = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { ":=", "=" },             word = false }),
    augend.constant.new({ elements = { "interface", "struct" }, word = true }),

    augend.constant.new({ elements = { "int", "int8", "int16", "int32", "int64" },      word = true }),
    augend.constant.new({ elements = { "uint", "uint8", "uint16", "uint32", "uint64" }, word = true }),
    augend.constant.new({ elements = { "float32", "float64" },                          word = true }),
    augend.constant.new({ elements = { "complex64", "complex128" },                     word = true }),
  }),

  java = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "private", "public", "protected" }, word = true }),
    augend.constant.new({ elements = { "class", "interface", "enum" },     word = true }),
  }),

  python = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "True", "False" }, word = true }),
  }),

  css = vim.list_extend(default_augends, {
    augend.constant.new({ elements = { "px", "em", "rem", "%" }, word = false }),
  }),
})

local js_augends = vim.list_extend(default_augends, {
  augend.constant.new({ elements = { "===", "!==" },                     word = false }),
  augend.constant.new({ elements = { "of", "in" },                       word = true }),
  augend.constant.new({ elements = { "let", "const" },                   word = true }),
  augend.constant.new({ elements = { "private", "public", "protected" }, word = true }),
})

vim.iter(require("user.filetypes").lang.js):each(function(ft)
  dial.augends:on_filetype({ [ft] = js_augends })
end)
