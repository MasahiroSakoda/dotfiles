-- -*-mode:lua-*- vim:ft=lua
local M = {}
local ls = require("luasnip")

function M.reload()
  require("luasnip.loaders.from_vscode").load()
  require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
 })
end

---@return snacks.picker.Item[]
function M.snippets()
  local snippets = {} ---@type snacks.picker.Item[]
  for ft, file in pairs(ls.available()) do
    -- if not type(file) == "table" then break end
    for i, snip in ipairs(file) do
      ---@type snacks.picker.Item
      local snippet = {
        idx = i,
        score = 0,
        file  = ft,
        trig  = snip.trigger,
        ft    = ft,
        name  = snip.name,
        desc  = snip.description[1] or "",
        text  = string.format("(%s) %-04s, %s", ft, snip.trigger, snip.description[1] or ""),
      }
      table.insert(snippets, snippet)
    end
  end
  return snippets
end

return M
