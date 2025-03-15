-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn =
  ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
---@diagnostic disable-next-line: unused-local
local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
---@diagnostic disable-next-line: unused-local
local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")
---@diagnostic disable-next-line: unused-local
local rep = require("luasnip.extras").rep

local snippets = {
  -- snippet file template
  s("luasnip", fmt([[
      local ls = require("luasnip")
      ---@diagnostic disable-next-line: unused-local
      local s, t, i, c, r, f, sn =
        ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
      ---@diagnostic disable-next-line: unused-local
      local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
      ---@diagnostic disable-next-line: unused-local
      local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")
      ---@diagnostic disable-next-line: unused-local
      local rep = require("luasnip.extras").rep

      local snippets = {{
        {}
      }}
      return snippets
    ]], { i(1, "-- Snippets goes here") })
  ),
  -- single line snippet
  s("snip", fmt('s("{}", fmt("{}", {{ i({}) }})),', { i(1), i(2), i(3) })),
  -- multiline snippet
  s("SNIP", fmt([=[
    s("{}", fmt([[
        {}
      ]], {{ {}, {} }})
    )
    ]=], { i(1, "name"), i(2, "body"), i(3, "node"), i(0, "") })
  ),

  s("fn",  fmt('function({})\n\t{}\nend\n',            { i(1, "parameter"), i(2, "code") })),
  s("lfn", fmt('local {} = function({})\n\t{}\nend\n', { i(1, "variable"),  i(2, "parameter"), i(3, "code") })),
  s("mfn", fmt('M.{} = function({})\n\t{}\nend\n',     { i(1, "variable"),  i(2, "parameter"), i(3, "code") })),
  s("l2",  fmt('local {}, {} = {}, {}',                { i(1, "var1"), i(2, "var2"), i(3, "c1"), i(4, "c2") })),

  s("augroup", fmt('vim.api.nvim_create_augroup("{}", {{ clear = true }}){}', { i(1, "group"), i(2, "")})),
  s("autocmd", fmt([[
      vim.api.nvim_create_autocmd("{}", {{
        desc     = "{}",
        group    = vim.api.nvim_create_augroup("{}", {{ clear = true }}),
        callback = function(ev)
          {}
       end
      }})
    ]], { i(1, "event"), i(2, "desc"), i(3, "group"), i(4, "") })
  ),

  -- Add plugin with lazy.nvim
  s("lazyadd", fmt([[
      {{
        "{}",
        event  = {{ "{}" }},
        config = function() require("{}") end,
      }},
    ]], { i(1, "path"), i(2, "event"), i(3, "module") })
  ),
  -- Plugin setup
  s("setup", fmt([[
      local ok, {} = pcall(require, "{}")
      if not ok then return end

      {}.setup({{
        {body},
      }})
    ]], { i(1, "module"), rep(1), rep(1), body = i(3, "body") })
  ),

  -- which-key.nvim keymap
  s("keymap", fmt('{{ "{}", "{}", icon = " ", desc = "{}" }},', { i(1, "keymap"), i(2, "cmd"), i(3, "desc") }))
}

return snippets
