std = {
  globals = {
    "vim",
    "hs",
    "package",
    "require",
    "pcall",
    "pairs",
    "ipairs",
    "print",
    "next",
    "select",
    "assert",
    "describe",
    "rawget",
    "os",
    "io",
    "coroutine",
    "type",
    "string",
    "table",
    "unpack",
    "math",
    "tonumber",
    "tostring",
  },
  ignore = {
    "122", -- Mutating read-only global variable
    "131", -- Unused global variable
    "211", -- Unused variable
    "212", -- Unused argument.
    "221", -- Variable is never set
    "231", -- Variable is never accessed
  },
}
