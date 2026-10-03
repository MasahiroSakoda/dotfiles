-- -*-mode:lua-*- vim:ft=lua
local plugins = {}
local list = {
  "plugins.dependencies",
  "plugins.editor",
  "plugins.treesitter",
  "plugins.ui",
  "plugins.lsp",
  "plugins.dap",
  "plugins.ai",
  "plugins.misc",
}

for _, plugin in ipairs(list) do
  vim.tbl_deep_extend("keep", plugins, require(plugin))
end

return plugins
