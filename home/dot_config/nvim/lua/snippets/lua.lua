-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local r  = ls.restore_node
-- local f  = ls.function_node
local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt    = require("luasnip.extras.fmt").fmt
-- local fmta   = require("luasnip.extras.fmta")
-- local conds  = require("luasnip.extras.conditions")
-- local condse = require("luasnip.extras.conditions.expand")

ls.filetype_extend("lua", { "luadoc" })

local snippets = {
  -- snippet file template
  s({ trig = "luasnip", name = "snippet file template", dscr = "LuaSnip snippet file template" },
    fmt([[
      local ls = require("luasnip")
      local s  = ls.snippet
      local t  = ls.text_node
      local i  = ls.insert_node
      local c  = ls.choice_node
      local r  = ls.restore_node
      local f  = ls.function_node
      local sn = ls.snippet_node
      local extras = require("luasnip.extras")
      local rep    = extras.rep
      local m      = extras.m
      local l      = extras.l
      local fmt    = require("luasnip.extras.fmt")
      local fmta   = require("luasnip.extras.fmta")
      local conds  = require("luasnip.extras.conditions")
      local condse = require("luasnip.extras.conditions.expand")

      local snippets = {{
        {}
      }}
      return snippets
      {}
    ]],{ i(1, "-- Snippets goes here"), i(0) })
  ),
  s({ trig = "snipf", name = "simplified snippet", dscr = "simple snippet template" },
    fmt('s({{ trig = "{}", name = "{}", dscr = "{}" }},\n\tfmt(\'{}\', {{ {} }})\n),',
      { i(1, "trigger"), i(2, "name"), i(3, "desc"), i(4, "snip"), i(0) })
  ),
  s({ trig = "SNIPF", name = "multiline snippet", dscr = "multiline snippet definition" },
    fmt([=[
    s({{ trig = "{}", name = "{}", dscr = "{}" }},
      fmt([[
        {}
      ]], {{ {} }})
    ),{}
    ]=], { i(1, "trigger"), i(2, "name"), i(3, "desc"), i(4, "snip"), i(5, "node"), i(0) })
  ),
  s({ trig = "snipt", name = "text snippet", dscr = "simple text snippet" },
    fmt('s({{ trig = "{}", name = "{}", dscr = "{}" }}, {{\n\tt("{}")\n}},\n{})', {
      i(1, "trigger"), i(2, "name"), i(3, "description"), i(4, "snippet text"), i(0)
    })
  ),

  -- snippet components
  s({ trig = "snipi", name = "insert node", dscr = "insert node snippet" }, fmt('i({}){}', { i(1, "index"), i(0) })),
  s({ trig = "snipc", name = "choice node", dscr = "choice node snippet" },
    fmt('c({}, {{\n{}\n}}),{}', { i(1, "index"), i(2, "choices"), i(0) })
  ),
  s({ trig = "snips", name = "snippet node", dscr = "snippet node snippet" },
    fmt('sn({}, {{ {} }}){}', { i(1, "jump index"), i(2, "node"), i(0) })
  ),

  s({ trig = "fn", name = "function template", dscr = "selectable function template" },
    fmt('{}{}({})\n\t{}\nend\n', {
      c(1, { t("function "), t("local function "), t("function M.") }),
      i(2, "name"),
      i(3, "param"),
      i(0),
    })
  ),
  s({ trig = "l2", name = "define two variables", dscr = "define two local variables" },
    fmt('local {}, {} = {}, {}\n{}', { i(1, "var1"), i(2, "var2"), i(3, "c1"), i(4, "c2"), i(0) })
  ),
  s({ trig = "module", name = "lua module template", dscr = "lua module template" },
    fmt('local M = {{}}\n\n{}\n\nreturn M', { i(0) })
  ),
  s({ trig = "pp", name = "print lua table", dscr = "print lua table beautifully" },
    fmt('print(vim.inspect({}))', { i(0) })
  ),

  s({ trig = "notify", name = "vim.notify template", dscr = "vim.notify template" },
    fmt('vim.notify({}, vim.log.levels.{}{})', {
      i(1, "string"),
      c(2, { t("DEBUG"), t("INFO"), t("WARN"), t("ERROR"), t("TRACE") }),
      i(0),
    })
  ),
  s({ trig = "augroup", name = "augroup template", dscr = "vim.api.nvim_create_augroup template" },
    fmt('vim.api.nvim_create_augroup("{}", {{ clear = true }})\n{}', { i(1, "group"), i(0)})
  ),
  s({ trig = "autocmd", name = "autocmd template", dscr = "vim.api.nvim_create_autocmd template" },
    fmt([[
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
  s({ trig = "command", name = "user command", dscr = "create user command" },
    fmt([[
      vim.api.nvim_create_user_command("{}", function({})
        {}
      end, {{ desc = "{}", nargs = "*", bang = true }})
    ]], { i(1, "Command Name"), i(2, "parameter"), i(3, "code"), i(0) })
  ),

  s({ trig = "ign", name = "Disable formatting", dscr = "Disable formatting via stylua" },
    fmt('-- stylua: ignore{}\n{}', { c(1, { t(""), t(" start"), t(" end") }), i(0) })
  ),

  s({ trig = "lazyadd", name = "Plugin config to use `lazy.nvim`", dscr = "plugin config via lazy.nvim" },
    fmt([[
      {{
        "{}",
        event  = {{ "{}" }},
        config = function() require("{}") end,
      }},
      {}
    ]], { i(1, "path"), i(2, "event"), i(3, "module"), i(0) })
  ),
  s({ trig = "setup", name = "Plugin setup", dscr = "Plugin setup template" },
    fmt([[
      local ok, {} = pcall(require, "{}")
      if not ok then return end

      {}.setup({{
        {body},
      }})
      {}
    ]], { i(1, "module"), rep(1), rep(1), body = i(3, "body"), i(0) })
  ),

  s({ trig = "keymap", name = "add keymap config", dscr = "keymap config for which-key.nvim" },
    fmt('{{ "{}", {}, icon = " ", desc = "{}" }},', {
      c(1, {
        sn(1, { t("<Leader>"), r(1, "user_lhs") }),
        sn(1, { t(","), r(1, "user_lhs") }),
        sn(1, { r(1, "user_lhs") }),
      }),
      c(2, {
        { t("\"<CMD>"),     r(1, "user_rhs"), t("<CR>\"") },
        { t("function() "), r(1, "user_rhs"), t(" end") },
        { r(1, "use_rhs")},
      }),
      i(0),
    })
  ),
}

return snippets
