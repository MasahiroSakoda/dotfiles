local ok, align = pcall(require, "mini.align")
if not ok then return end

align.setup({
  mappings = {
    start              = "<Leader>ma",
    start_with_preview = "<Leader>mA",
  },

  modifiers = {
    -- Main option modifiers
    -- ["s"] = --<function: enter split pattern>,
    -- ["j"] = --<function: choose justify side>,
    -- ["m"] = --<function: enter merge delimiter>,

    -- Modifiers adding pre-steps
    -- ["f"] = --<function: filter parts by entering Lua expression>,
    -- ["i"] = --<function: ignore some split matches>,
    -- ["p"] = --<function: pair parts>,
    -- ["t"] = --<function: trim parts>,

    -- Delete some last pre-step
    -- ["<BS>"] = --<function: delete some last pre-step>,

    -- Special configurations for common splits
    -- ["="] = --<function: enhanced setup for "=">,
    -- [","] = --<function: enhanced setup for ",">,
    -- ["|"] = --<function: enhanced setup for "|">,
    -- [" "] = --<function: enhanced setup for " ">,
  },

  options = {
    split_pattern = "",
    justify_side = "left",
    merge_delimiter = "",
  },

  steps = {
    pre_split   = {},
    split       = nil,
    pre_justify = {},
    justify     = nil,
    pre_merge   = {},
    merge       = nil,
  },

  -- Whether to disable showing non-error feedback
  -- This also affects (purely informational) helper messages shown after
  -- idle time if user input is required.
  silent = false,
})
