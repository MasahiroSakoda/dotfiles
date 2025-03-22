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
    "type",
    "string",
    "table",
    "unpack",
    "math",
    "tonumber",
    "tostring",
  },
  ignore = {
    "122",    -- Mutating read-only global variable
    "131",    -- Unused global variable
    "211/_*", -- Unused variable
    "212/_*", -- Unused argument.
    "221/_*", -- Variable is never set
    "231/_*", -- Variable is never accessed
  },
}
