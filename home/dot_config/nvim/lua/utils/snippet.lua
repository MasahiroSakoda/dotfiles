-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local M = {}
local ls = require("luasnip")
-- local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
local sn = ls.snippet_node
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
-- local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")

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
    for index, snip in ipairs(file) do
      ---@type snacks.picker.Item
      local snippet = {
        idx = index,
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

function M.capture(_, snip)
  return snip.captures[1]
end

-- visual util to add insert node - thanks ejmastnak!
function M.get_visual(_, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

function M.clipborad()
  return vim.fn.getreg("+")
end

return M
