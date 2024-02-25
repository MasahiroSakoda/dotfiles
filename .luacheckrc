std = {
  globals = {
    "vim",
    "require",
    "pcall",
    "ipairs",
  },
  ignore = {
    "122", -- Mutating read-only global variable
    "131", -- Unused global variable
    "211", -- Unused variable
    "221", -- Variable is never set
    "231", -- Variable is never accessed
  },
}
