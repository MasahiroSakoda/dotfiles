local ok, treesj = pcall(require, "treesj")
if not ok then return end

-- https://github.com/Wansmer/treesj#settings
treesj.setup({
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = false,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

-- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 150,

  -- Use `dot` for repeat action
  dot_repeat = true,
})
