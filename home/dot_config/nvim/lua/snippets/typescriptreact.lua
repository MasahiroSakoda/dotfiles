-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
local d  = ls.dynamic_node
-- local r  = ls.restore_node
local f  = ls.function_node
local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

ls.filetype_extend("javascriptreact", { "javascript" })


-- Then this function would return `{"prop1", "prop2"}
---@param id_node {} Stands for "interface declaration node"
---@return string[]
local function get_prop_names(id_node)
  local object_type_node = id_node:child(3)
  if object_type_node:type() ~= 'object_type' then
    return {}
  end

  local prop_names = {}

  for prop_signature in object_type_node:iter_children() do
    if prop_signature:type() == 'property_signature' then
      local prop_iden = prop_signature:child(0)
      local prop_name = vim.treesitter.get_node_text(prop_iden, 0)
      prop_names[#prop_names + 1] = prop_name
    end
  end

  return prop_names
end

local snippets = {

  s({ trig = "nxp", name = "Next.js page", dscr = "Next.js page" },
    fmta('export default function <>(<>) {\n\treturn (\n\t<>\n)\n}', { i(1, "Page Name"), i(2, "Parameters"), i(0) })
  ),

  -- React components
  s({ trig = "us", name = "useState", dscr = "useState" },
    fmt('const [{}, <>] = useState<{}>({})', {
      i(1, "state"),
      f(function(args) return args[1][1]:gsub("^%l", string.upper) end, { 1 }),
      i(3, "type"),
      i(0),
    })
  ),
  s({ trig = "ue", name = "useEffect", dscr = "useEffect" },
    fmta('useEffect(() => {\n\t<>\n}, [<>], ', { i(1, "body"), i(0) })
  ),

  s({ trig = "c", name = "const", dscr = "const" },
    fmta([[
      <>type <>Props = {
        <>
      }

      <>const <> = ({<>}): <>Props) => {
        <>
      }
    ]], {
      -- Import React if it's not yet imported
        f(function()
          local bufnr  = 0
          local parser = vim.treesitter.get_parser(bufnr, "tsx")
          if not parser then return "" end
          local tree = parser:parse()[1]

          local query = vim.treesitter.query.parse("tsx", '((identifier) @hello (#eq? @hello "React"))')
          local has_match = false
          for _, _ in query:iter_matches(tree:root(), bufnr) do
            has_match = true
          end

          if not has_match then
            return { "import React from 'react';", "", "" }
          end
          return ''
        end),
        -- Initialize component name to file name
        d(2, function(_, snip)
          local filename = vim.fn.substitute(snip.env.TM_FILENAME, "\\..*$", "", "g")
          -- Convert from kebab-case file names to PascalCase
          local component_name = string.gsub('-' .. filename, '%W%l', string.upper):sub(2)

          return sn(nil, {
            i(1, component_name),
          })
        end, { 1 }),
        i(3, "// Props"),
        i(1, "export "),
        rep(2),
        f(function(_, snip, _)
          local pos_begin = snip.nodes[6].mark:pos_begin()
          local pos_end   = snip.nodes[6].mark:pos_end()
          local parser = vim.treesitter.get_parser(0, "tsx")
          if not parser then return "" end
          local tstree = parser:parse()
          if not tstree then return "" end

          local node = tstree[1]:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

          while node ~= nil and node:type() ~= 'type_alias_declaration' do
            node = node:parent()
          end

          if node == nil then return "" end

          -- `node` is now surely of type "type_alias_declaration"
          local prop_names = get_prop_names(node)

          return table.concat(prop_names, ', ')
        end, { 3 }),
        rep(2),
        i(4, 'return <div></div>'),
      })
  ),
}
return snippets
