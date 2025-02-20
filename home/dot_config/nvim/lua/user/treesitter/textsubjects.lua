-- -*-mode:lua-*- vim:ft=lua
local ok, ts = pcall(require, "nvim-treesitter-textsubjects")
if not ok then return end

ts.configure({
  textsubjects = {
    enable = true,
    -- prev_selection = ",",
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-inner",
      ["i;"] = "textsubjects-container-outner",
    },
  },
})
