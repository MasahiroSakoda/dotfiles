-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, t, i = ls.snippet, ls.text_node, ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local conds = require("luasnip.extras.conditions")
local rep = require("luasnip.extras").rep

ls.filetype_extend("lua", { "luadoc" })

local snippets = {
  -- snippet file template
  s({ trig = "luasnip", name = "snippet file template", dscr = "LuaSnip snippet file template" }, fmt([[
      local ls = require("luasnip")
      local s, t, i, c, r, f, sn =
        ls.snippet, ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
      local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
      local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")
      local rep = require("luasnip.extras").rep

      local snippets = {{
        {}
      }}
      return snippets
    ]], { i(1, "-- Snippets goes here") })
  ),
  s({ trig = "snipf", name = "simplified snippet", dscr = "simple snippet template" },
    fmt('s({{ trig = "{}", name = "{}", dscr = "{}" }},\n\tfmt(\'{}\', {{ i(1, "{}") }})\n),\n{}',
      { i(1, "trigger"), i(2, "name"), i(3, "desc"), i(4, "snip"), i(5, "name"), i(0) })
  ),
  s({ trig = "SNIPF", name = "multiline snippet", dscr = "multiline snippet definition" }, fmt([=[
    s({{ trig = "{}", name = "{}", dscr = "{}" }}, fmt([[
        {}
      ]], {{ {} }})
    ),
    {}
    ]=], { i(1, "trigger"), i(2, "name"), i(3, "desc"), i(4, "snip"), i(5, "node"), i(0) })
  ),
  s({ trig = "snipt", name = "text snippet", dscr = "simple text snippet" },
    fmt('s({{ trig = "{}", name = "{}", dscr = "{}", {{\n\tt("{}")\n}} }},\n{})', {
      i(1, "trigger"), i(2, "name"), i(3, "description"), i(4, "snippet text"), i(0)
    })
  ),

  s({ trig = "fn", name = "function template", dscr = "normal function template" },
    fmt('function({})\n\t{}\nend\n{}', { i(1, "parameter"), i(2, "code"), i(0) })
  ),
  s({ trig = "lfn", name = "local function template", dscr = "local function template" },
    fmt('local {} = function({})\n\t{}\nend\n{}', { i(1, "variable"),  i(2, "parameter"), i(3, "code"), i(0) })
  ),
  s({ trig = "mfn", name = "M tabled function", dscr = "function tempalte related module" },
    fmt('M.{} = function({})\n\t{}\nend\n{}', { i(1, "variable"),  i(2, "parameter"), i(3, "code"), i(0) })
  ),
  s({ trig = "l2", name = "define two variables", dscr = "define two local variables" },
    fmt('local {}, {} = {}, {}\n{}', { i(1, "var1"), i(2, "var2"), i(3, "c1"), i(4, "c2"), i(0) })
  ),

  s({ trig = "augroup", name = "augroup template", dscr = "vim.api.nvim_create_augroup template" },
    fmt('vim.api.nvim_create_augroup("{}", {{ clear = true }})\n{}', { i(1, "group"), i(0)})
  ),
  s({ trig = "autocmd", name = "autocmd template", dscr = "vim.api.nvim_create_autocmd template" }, fmt([[
      vim.api.nvim_create_autocmd("{}", {{
        desc     = "{}",
        group    = vim.api.nvim_create_augroup("{}", {{ clear = true }}),
        callback = function(ev)
          {}
        end
      }})
      {}
    ]], { i(1, "event"), i(2, "desc"), i(3, "group"), i(4, "callback code"), i(0) })
  ),

  s({ trig = "ign", name = "Disable formatting", dscr = "Disable formatting via stylua" },
    fmt('-- stylua: ignore\n{}', { i(0) }, { condition = conds.line_begin })
  ),

  s({ trig = "lazyadd", name = "Plugin config to use `lazy.nvim`", dscr = "plugin config via lazy.nvim" }, fmt([[
      {{
        "{}",
        event  = {{ "{}" }},
        config = function() require("{}") end,
      }},
      {}
    ]], { i(1, "path"), i(2, "event"), i(3, "module"), i(0) })
  ),
  s({ trig = "setup", name = "Plugin setup", dscr = "Plugin setup template" }, fmt([[
      local ok, {} = pcall(require, "{}")
      if not ok then return end

      {}.setup({{
        {body},
      }})
      {}
    ]], { i(1, "module"), rep(1), rep(1), body = i(3, "body"), i(0) })
  ),

  s({ trig = "keymap", name = "add keymap config", dscr = "keymap config for which-key.nvim" },
    fmt('{{ "<Leader>{}", "<CMD>{}<CR>", icon = " ", desc = "{}" }}\n{}', {
      i(1, "keymap"),
      i(2, "command"),
      -- TODO: enable choice selection from codicons.nvim
      i(3, "description"),
      i(0),
    })
  ),
}

return snippets
