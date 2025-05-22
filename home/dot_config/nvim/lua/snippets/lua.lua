-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local d  = ls.dynamic_node
local r  = ls.restore_node
local f  = ls.function_node
local sn = ls.snippet_node
-- local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

ls.filetype_extend("lua", { "luadoc" })

local snippets = {
  ---------------------------------------------------------------------------------------
  ---Snippet templates
  ---------------------------------------------------------------------------------------
  -- snippet file template
  s({ trig = "luasnip", name = "snippet file template", dscr = "LuaSnip snippet file template" },
    fmta([[
      ---@diagnostic disable: unused-local
      local ls = require("luasnip")
      local s  = ls.snippet
      local t  = ls.text_node
      local i  = ls.insert_node
      local c  = ls.choice_node
      local d  = ls.dynamic_node
      local r  = ls.restore_node
      local f  = ls.function_node
      local sn = ls.snippet_node
      local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
      local extras = require("luasnip.extras")
      local rep    = extras.rep
      local m      = extras.m
      local l      = extras.l
      local fmt     = require("luasnip.extras.fmt").fmt
      local fmta    = require("luasnip.extras.fmt").fmta
      local postfix = require("luasnip.extras.postfix").postfix
      local conds   = require("luasnip.extras.conditions")
      local condse  = require("luasnip.extras.conditions.expand")

      local snippets = {
        <>
      }
      return snippets
    ]],{ i(0) })
  ),
  s({ trig = "snipf", name = "snippet template", dscr = "snippet template" },
    fmta('s({ trig = "<>", name = "<>", dscr = "<>" },\n\t<>\n),', {
      i(1, "trigger"),
      i(2, "name"),
      i(3, "description"),
      c(4, {
        sn(nil, { t("fmt("),    r(1, "format"), t(", { "), r(2, "nodes"), t(" }"), t(")") }),
        sn(nil, { t("fmta("),   r(1, "format"), t(", { "), r(2, "nodes"), t(" }"), t(")") }),
        sn(nil, { t("{ t(\""),  r(1, "text"),   t("\") }") }),
      }),
    })
  ),
  s({ trig = "snipr", name = "regex snippet", dscr = "RegExp triggereed snippet" },
    fmta('s({ trig = "<>", dscr = "<>", regTrig = true }\n\tfmta(<>, { <> }\n)', {
      i(1, "trigger"),
      i(2, "description"),
      c(3, {
        sn(nil, { t("'"), r(1, "format"), t("'") }),
        sn(nil, { t("[["), r(1, "format"), t("]]") }),
      }),
      i(0),
    })
  ),

  -- snippet components
  s({ trig = "inode", name = "insert node", dscr = "insert node snippet" }, fmta('i(<>)', { i(0, "index") })),
  s({ trig = "cnode", name = "choice node", dscr = "choice node snippet" },
    fmta('c(<>, {{\n<>\n}}),', { i(1, "index"), i(0, "choices") })
  ),
  s({ trig = "snode", name = "snippet node", dscr = "snippet node snippet" },
    fmta('sn(<>, { <> })', { i(1, "jump index"), i(0, "node") })
  ),

  ---------------------------------------------------------------------------------------
  ---Lua snippets
  ---------------------------------------------------------------------------------------
  s({ trig = "fn", name = "function template", dscr = "selectable function template" },
    fmta('<><>(<>)\n\t<>\nend\n', {
      c(1, { t("function "), t("local function "), t("function M.") }), i(2, "name"), i(3, "param"), i(0),
    })
  ),
  s({ trig = "lm", name = "init module as variable", dscr = "init module as variable" },
    fmta('local <> = require("<>")', {
      f(function(values)
        local path = vim.split(values[1][1], "%.")
        return path[#path]
      end, { 1 }),
      i(1)
    })
  ),
  s({ trig = "diagnostic", name = "diagnostic", dscr = "diagnostic" },
    fmta('---@diagnostic <>: <>', { c(1, { t("disable"), t("disable-next-line") }), i(0) })
  ),
  s({ trig = "l2", name = "define two variables", dscr = "define two local variables" },
    fmta('local <>, <> = <>, <>\n<>', { i(1, "var1"), i(2, "var2"), i(3, "c1"), i(4, "c2"), i(0) })
  ),
  s({ trig = "module", name = "lua module template", dscr = "lua module template" },
    fmta('local M = {}\n\n<>\n\nreturn M', { i(0) })
  ),
  s({ trig = "pp", name = "print lua table", dscr = "print lua table beautifully" },
    fmta('print(vim.inspect(<>))', { i(0) })
  ),
  s({ trig = "for", name = "for loop", dscr = "for loop" },
    fmta('for <>, <> in <> do\n\t<>\nend', {
      i(1, "key"),
      i(2, "value"),
      c(3, { sn(nil, { t("pairs("), r(1, "table"), t(")") }), sn(nil, { t("ipairs("), r(1, "table"), t(")") }) }),
      i(0)
    })
  ),

  ---------------------------------------------------------------------------------------
  ---Vim snippets
  ---------------------------------------------------------------------------------------
  s({ trig = "notify", name = "vim.notify template", dscr = "vim.notify template" },
    fmta('vim.notify(<>, vim.log.levels.<><>)', {
      i(1, "string"), c(2, { t("DEBUG"), t("INFO"), t("WARN"), t("ERROR"), t("TRACE") }), i(0),
    })
  ),
  s({ trig = "augroup", name = "augroup template", dscr = "vim.api.nvim_create_augroup template" },
    fmta('vim.api.nvim_create_augroup("<>", {{ clear = true }})\n<>', { i(1, "group"), i(0)})
  ),
  s({ trig = "autocmd", name = "autocmd template", dscr = "vim.api.nvim_create_autocmd template" },
    fmta([[
      vim.api.nvim_create_autocmd("<>", {
        desc     = "<>",
        group    = vim.api.nvim_create_augroup("<>", { clear = true }),
        callback = function(ev)
          <>
        end
      })
    ]], { i(1, "event"), i(2, "desc"), i(3, "group"), i(0) })
  ),
  s({ trig = "command", name = "user command", dscr = "create user command" },
    fmta('vim.api.nvim_create_user_command("<>", function(<>)\n\t<>\nend, { desc = "<>", nargs = "*", bang = true})',{
      i(1, "Command Name"), i(2, "parameter"), i(3, "code"), i(4, "description"),
    })
  ),
  s({ trig = "vinput", name = "vim.ui.input", dscr = "vim.ui.input" },
    fmta('vim.ui.input({ prompt = "<>", default = "<>", function(name)\n\t<>\nend})', {
      i(1, "prompt"), i(2, "default value"), i(0),
    })
  ),
  s({ trig = "vselect", name = "vim.ui.select", dscr = "vim.ui.select" },
    fmta([[
      vim.ui.select(<>, {
        prompt = "<>",
        format_item = function(item)
          <>
        end,
        }, function(choice)
          if choice then
            <>
          end
        end,
      )
    ]], { i(1, "array"), i(2, "prompt"), i(3, "format code"), i(0) })
  ),

  s({ trig = "ign", name = "Disable formatting", dscr = "Disable formatting via stylua" },
    fmta('-- stylua: ignore<>\n<>', { c(1, { t(""), t(" start"), t(" end") }), i(0) })
  ),

  ---------------------------------------------------------------------------------------
  ---Others
  ---------------------------------------------------------------------------------------
  s({ trig = "@lazy", name = "lazy.nvim plugin config", dscr = "plugin config via lazy.nvim" },
    fmta('{\n\t"<>",\n\tconfig = function() require("<>") end,\n},', { i(1, "plugin"), i(0) })
  ),

  s({ trig = "@setup", name = "Plugin setup", dscr = "Plugin setup template" },
    fmta([[
      local ok, <> = pcall(require, "<>")
      if not ok then return end

      <>.setup({
        <>,
      })
    ]], { i(1, "module"), rep(1), rep(1), i(0) })
  ),

  s({ trig = "@keymap", name = "add keymap config", dscr = "keymap config for which-key.nvim" },
    fmta('{ "<>", <>, icon = "<> ", desc = "<>" },', {
      c(1, {
        sn(1, { t("<Leader>"), r(1, "user_lhs") }),
        sn(1, { t(","), r(1, "user_lhs") }),
        sn(1, { r(1, "user_lhs") }),
      }),
      c(2, {
        sn(1, { r(1, "user_rhs") }),
        sn(1, { t("\"<CMD>"), r(1, "user_lhs"), t("<CR>\"") }),
        sn(1, { t("function() "), r(1, "user_rhs"), t(" end") }),
      }),
      i(3, "icon"),
      i(0),
    })
  ),
}

return snippets
