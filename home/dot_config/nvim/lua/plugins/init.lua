-- -*-mode:lua-*- vim:ft=lua
local plugins = {}
local list = {
  "plugins.dependencies",
  "plugins.appearance",
  "plugins.editor",
  "plugins.lsp",
  "plugins.cmp",
  "plugins.dap",
  "plugins.treesitter",
  "plugins.ai",
  "plugins.misc",
}

for _, plugin in ipairs(list) do
  vim.tbl_deep_extend("keep", plugins, require(plugin))
end

return plugins
