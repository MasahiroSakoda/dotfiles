local ok, flash = pcall(require, "flash")
if not ok then return end

flash.setup({
  label = "hjklasdfgyuiopqwertnmzxcvb",
  search = {
    -- search/jump in all windows
    multi_window = true,
    -- search direction
    forward = true,
  },

  jump = {
    -- save location in the jumplist
    jumplist = true,
    -- jump position
    pos = "start", ---@type "start" | "end" | "range"
  },
  modes = {
    -- options used for treesitter selections
    -- `require("flash").treesitter()`
    treesitter = {
      labels = "hjklasdfgyuiopqwertnmzxcvb",
    },
  },
})
