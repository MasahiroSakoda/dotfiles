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
  s({ trig = "luasnip", name = "snippet file", dscr = "LuaSnip snippet file template" },
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
  s({ trig = "snipf", name = "snippet", dscr = "snippet template" },
    fmta('s({ trig = "<>", name = "<>", dscr = "<>" },\n\t<>\n),', {
      i(1, "trigger"),
      i(2, "name"),
      i(3, "description"),
      c(4, {
        sn(nil, { t("fmt("),  r(1, "format"), t(", { "), r(2, "nodes"), t(" }"), t(")") }),
        sn(nil, { t("fmta("), r(1, "format"), t(", { "), r(2, "nodes"), t(" }"), t(")") }),
      }),
    })
  ),
  s({ trig = "snipr", name = "regex snippet", dscr = "RegExp triggereed snippet" },
    fmta('s({ trig = "<>", dscr = "<>", regTrig = true }\n\tfmta(<>, { <> }\n)', {
      i(1, "trigger"),
      i(2, "description"),
      c(3, {
        sn(nil, { t("'"),  r(1, "format"), t("'") }),
        sn(nil, { t("[["), r(1, "format"), t("]]") }),
      }),
      i(0),
    })
  ),

  -- snippet components
  s({ trig = "tnode", name = "text node",   dscr = "text node snippet" },   fmta('t("<>")', { i(0, "text")})),
  s({ trig = "inode", name = "insert node", dscr = "insert node snippet" }, fmta('i(<>)',   { i(0, "index") })),
  s({ trig = "cnode", name = "choice node", dscr = "choice node snippet" },
    fmta('c(<>, {\n\t<>\n})', { i(1, "index"), i(0, "choice")})
  ),
  s({ trig = "snode", name = "snippet node", dscr = "snippet node snippet" },
    fmta('sn(<>, { <> })', { i(1, "index"), i(0, "node") })
  ),

  ---------------------------------------------------------------------------------------
  ---Lua snippets
  ---------------------------------------------------------------------------------------
  s({ trig = "fn", name = "function", dscr = "selectable function template" },
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
  s({ trig = "diagnostic", name = "@diagnostic", dscr = "@diagnostic" },
    fmta('---@diagnostic <>: <>', { c(1, { t("disable"), t("disable-next-line") }), i(0) })
  ),
  s({ trig = "loc", name = "define two variables", dscr = "define two local variables" },
    fmta('local <>, <> = <>, <>\n<>', { i(1, "var1"), i(2, "var2"), i(3, "c1"), i(4, "c2"), i(0) })
  ),
  s({ trig = "module", name = "lua module", dscr = "lua module template" },
    fmta('local M = {}\n\n<>\n\nreturn M', { i(0) })
  ),
  s({ trig = "print", name = "print lua table", dscr = "print lua table beautifully" },
    fmta('print(vim.inspect(<>))', { i(0) })
  ),
  s({ trig = "for", name = "for loop", dscr = "for loop" },
    fmta('for <>, <> in <> do\n\t<>\nend', {
      i(1, "key"),
      i(2, "value"),
      c(3, {
        sn(nil, { t("pairs("),  r(1, "table"), t(")") }),
        sn(nil, { t("ipairs("), r(1, "table"), t(")") }),
      }),
      i(0)
    })
  ),

  ---------------------------------------------------------------------------------------
  ---Vim snippets
  ---------------------------------------------------------------------------------------
  s({ trig = "vcmd",    name = "vim.cmd",    dscr = "vim.cmd template" }, fmta('vim.cmd(<>)', { i(0) })),
  s({ trig = "vnotify", name = "vim.notify", dscr = "vim.notify template" },
    fmta('vim.notify(<>, vim.log.levels.<>)', {
      i(1, "string"), c(2, { t("DEBUG"), t("INFO"), t("WARN"), t("ERROR"), t("TRACE") }),
    })
  ),
  s({ trig = "augroup", name = "augroup", dscr = "augroup snippet" },
    fmta('vim.api.nvim_create_augroup("<>", {{ clear = true }})', { i(0) })
  ),
  s({ trig = "autocmd", name = "autocmd", dscr = "autocmd snippet" },
    fmta([[
      vim.api.nvim_create_autocmd({ "<event>" }, {
        group    = <group>,
        pattern  = { "<pattern>" },
        callback = function(<params>)
          <callback>
        end,
      })
    ]], {
      event = i(1, "event"),
      group = c(2, {
        sn(1, { r(1, "group") }),
        sn(1, { t('vim.api.nvim_create_augroup("'), r(1, "group"), t('", { clear = true})') }),
      }),
      pattern  = i(3, "pattern"),
      params   = c(4, { t("_"), t("ev") }),
      callback = i(0),
    })
  ),
  s({ trig = "usercmd", name = "user command", dscr = "create user command" },
    fmta('vim.api.nvim_create_user_command("<>", function(<>)\n\t<>\nend, { desc = "<>", nargs = "*", bang = true })',{
      i(1, "cmd"), i(2, "params"), i(3, "code"), i(0, "desc"),
    })
  ),
  s({ trig = "highlight", name = "Highlight", dscr = "vim.api.nvim_set_hl", },
    fmta('vim.api.nvim_set_hl(0, "<>", { <><> })', {
      i(1, "highlight"),
      c(2, {
        sn(1, { t('fg = "'), r(1, "rgb"), t('"') }),
        sn(1, { t('fg = "'), r(1, "rgb"), t('"') }),
        t('italic = true'),
        t('bold = true'),
        t('underline = true'),
        t('undercurl = true'),
      }),
      i(0),
    })
  ),
  s({ trig = "vinput", name = "vim.ui.input", dscr = "vim.ui.input" },
    fmta('vim.ui.input({ prompt = "<>", default = "<>", function(name)\n\t<>\nend})', {
      i(1, "prompt"), i(2, "default value"), i(0),
    })
  ),
  s({ trig = "vselect", name = "vim.ui.select", dscr = "vim.ui.select" },
    fmta([[
      vim.ui.select(<items>, {
        prompt = "<prompt>",
        format_item = function(item)
          <format>
        end,
        }, function(choice)
          if choice then
            <>
          end
        end,
      )
    ]], {
      items = c(1, {
        sn(1, { r(1, "items") }),
        sn(1, { t('{ "'), r(1, "items"), t('" }') }),
      }),
      prompt = i(2, "prompt"),
      format = i(3, "format"),
      i(0),
    })
  ),

  s({ trig = "ignore", name = "Disable formatting", dscr = "Disable formatting via stylua" },
    fmta('-- stylua: ignore<>\n<>', { c(1, { t(""), t(" start"), t(" end") }), i(0) })
  ),

  ---------------------------------------------------------------------------------------
  ---Others
  ---------------------------------------------------------------------------------------
  s({ trig = "lazyp", name = "Plugin Config", dscr = "Plugin config" },
    fmta('{\n\t"<>",\n\tconfig = function() require("<>") end,\n},', { i(1, "plugin"), i(0) })
  ),
  s({ trig = "lazyd", name = "Plugin Deps", dscr = "Plugin deps" },
    fmta('dependencies = { "<>"<> },', { i(1, "deps"), i(0) })
  ),
  s({ trig = "lazyc", name = "Plugin Command", dscr = "Plugin trigger command" },
    fmta('cmd = { "<>"<> },', { i(1, "command"), i(0) })
  ),
  s({ trig = "lazye", name = "Plugin Event", dscr = "Plugin trigger event"},
    fmta('event = { "<>"<> },', {
      c(1, { t("BufNewFile"), t("BufReadPre"), t("BufReadPost"), t("InserEnter"), t("CmdlineEnter"), t("VeryLazy") }),
      i(0)
    })
  ),
  s({ trig = "lazyf", name = "Plugin Filetypes", dscr = "Plugin filetype trigger" },
    fmta('ft = { "<>"<> },', { i(1, "filetype"), i(0) })
  ),

  s({ trig = "setup", name = "Plugin setup", dscr = "Plugin setup template" },
    fmta([[
      local ok, <> = pcall(require, "<>")
      if not ok then return end

      <>.setup({
        <>,
      })
    ]], { i(1, "module"), rep(1), rep(1), i(0) })
  ),

  s({ trig = "wkeygrp", name = "Keymap Group",  dscr = "Keymap Group for which-key.nvim" },
    fmta('{ "<lhs>", group = "<grp>", icon = "<icon> " },', {
      lhs  = c(1, {
        sn(1, { t("<Leader>"), r(1, "lhs") }),
        sn(1, { r(1, "lhs") }),
      }),
      grp  = i(2, "group"),
      icon = i(0, "icon")
    }),
    { stored = { lhs = i(1, "lhs") } }
  ),
  s({ trig = "wkeymap", name = "Keymap Config", dscr = "Keymap Config for which-key.nvim" },
    fmta('{ "<lhs>", <rhs>, icon = "<icon> ", desc = "<desc>" },', {
      lhs = c(1, {
        sn(1, { t("<Leader>"), r(1, "user_lhs") }),
        sn(1, { r(1, "user_lhs") }),
      }),
      rhs = c(2, {
        { t("<CMD>"), r(1, "user_rhs"), t("<CR>") },
        { t("function()"), r(1, "user_rhs"), t("end") },
        { t(":"), r(1, "user_lhs"), t("<Space>") },
      }),
      icon = i(3, "icon"),
      desc = i(0, "description"),
    }),
    { stored = { user_lhs = i(1, "user_lhs"), user_rhs = i(1, "user_rhs") } }
  ),
  s({ trig = "keymaap", name = "Keymap Config", dscr = "vim.keymap.set" },
    fmta('vim.keymap.set(<mode>, "<lhs>", <rhs>, {<opts>})', {
      mode = c(1, { sn(1, { r(1, "mode") }), sn(1, { t('{ "'), r(1, "mode"), t('" }') }) }),
      lhs  = c(2, { sn(1, { t("<Leader>"), r(1, "user_lhs") }), sn(1, { r(1, "user_lhs") }) }),
      rhs  = c(3, {
        sn(1, { t('"<CMD>'), r(1, "user_rhs"), t('<CR>"') }),
        sn(1, { t('function() '), r(1, "user_rhs"), t(' end') }),
        sn(1, { r(1, "user_rhs") }),
      }),
      opts = c(4, {
        sn(1, { t(' desc = "'), r(1, "desc"), t('" ') }),
        sn(1, { t(' desc = "'), r(1, "desc"), t('" '), t(' silent = true,') }),
        t(""),
      }),
    })
  ),
}

return snippets
