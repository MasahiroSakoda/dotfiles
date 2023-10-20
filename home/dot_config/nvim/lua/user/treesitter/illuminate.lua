local ok, illuminate = pcall(require, "illuminate")
if not ok then return end

illuminate.configure({
  delay = 95,
  -- filetype_overrides: filetype specific overrides.
  -- The keys are strings to represent the filetype while the values are tables that
  -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
  filetype_overrides = {},
  -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
  filetypes_denylist = {
    "dirbuf",
    "dirvish",
    "alpha",
    "fugitive",
    "TelescopePrompt",
    "Trouble",
  },
})

local hl = vim.api.nvim_set_hl
local opts = { bold = true, underline = true }
hl(0, "IlluminatedWordText",  vim.tbl_deep_extend("force", opts, { bg = "#002171" } ))
hl(0, "IlluminatedWordRead",  vim.tbl_deep_extend("force", opts, { bg = "#1A5626" } ))
hl(0, "IlluminatedWordWrite", vim.tbl_deep_extend("force", opts, { bg = "#755B1C", underdotted = true }))
