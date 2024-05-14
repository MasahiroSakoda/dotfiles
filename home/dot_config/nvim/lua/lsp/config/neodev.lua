-- -*-mode:lua-*- vim:ft=lua

local ok, neodev = pcall(require, "neodev")
if not ok then return end

neodev.setup({
  override = function(root_dir, library)
    local util = require("neodev.util")
    if util.has_file(root_dir, "~/.local/share/chezmoi") then
      library.enabled = true
      library.plugins = true
    end
  end,
})
