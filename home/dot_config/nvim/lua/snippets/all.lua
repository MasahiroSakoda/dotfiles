-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
-- local i  = ls.insert_node
local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
local f  = ls.function_node
-- local sn = ls.snippet_node
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
-- local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local function expand(arg) return vim.fn.expand(arg) end
local function filename() return expand("%") end
local function extension() return expand("%:e") end
local function basename() return expand("%:r") end
local function fullpath() return expand("%:p") end
local function pathname() return expand("%:p:h") end

local snippets = {
  s({ trig = "header", name = "filetype header", dscr = "filetype header template", prioriy = -100 },
    fmt('{}-*-mode:{}-*- vim:ft={}\n', {
      f(function() return vim.bo.commentstring:gsub("%%s", "") end),
      f(function() return vim.bo.filetype end),
      f(function() return vim.bo.filetype end),
    })
  ),

  s({ trig = "filename", name = "File Name", dscr = "Print File Name" }, {
    c(1, { f(filename), f(extension), f(basename) }),
  }),
  s({ trig = "basename", name = "Basename", dscr = "Print Basename" }, {
    c(1, { f(basename), f(filename), f(extension) }),
  }),
  s({ trig = "extension", name = "Extension", dscr = "Print Extension" }, { c(1, { f(extension) }) }),
  s({ trig = "pathname",  name = "Path Name", dscr = "Print Path" },      { c(1, { f(pathname), f(fullpath) }) }),
  s({ trig = "fullpath",  name = "Full Path", dscr = "Print Full Path" }, { c(1, { f(pathname), f(fullpath) }) }),
}
return snippets
