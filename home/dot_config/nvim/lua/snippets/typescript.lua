---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local d  = ls.dynamic_node
local r  = ls.restore_node
-- local f  = ls.function_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
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

local function functionator(type)
  return fmta('<doc>\n<type> <async><name>(<params>): <ret>{\n\t<body>\n}', {
    doc    = isn(1, {
      t({ "/**", " " }),
      i(1, "function description"),
      c(2, { sn(nil, { t({ "", " @returns " }), i(1, "return description") }) }),
      t({ "", "/" }),
    }, "$PARENT_INDENT *"),
    type   = t(type),
    async  = c(2, { t("async "), t("") }),
    name   = i(3, "function name"),
    params = i(4),
    ret    = d(5, function(args)
      local async = string.match(args[1][1], "async")
        if async == nil then
          return sn(nil, { r(1, "return_type", i(nil, "void")) } )
        end
        return sn(nil, { t("Promise<"), r(1, "return_type", i(nil, "void")), t(">") } )
    end),
    body = i(0),
  })
end

local function looper(type)
  return fmta('.<type>{<async>}<<item>> => {\n\t<body>\n}', {
    type  = t(type),
    async = c(1, { t(""), t("async ") }),
    item  = c(2, { i(1, "item"), sn(nil, { t("{ "), i(1, "field"), t(" }") }) }),
    body  = i(0),
  })
end

local snippets = {
  -- Function snippets
  s({ trig = "pbf", name = "public function",  dscr = "public function" },  functionator("public") ),
  s({ trig = "prf", name = "private function", dscr = "private function" }, functionator("private") ),

  -- Array snippets
  s({ trig = ".map",     name = "map",     dscr = "" }, looper("map") ),
  s({ trig = ".filter",  name = "filter",  dscr = "" }, looper("filter") ),
  s({ trig = ".forEach", name = "forEach", dscr = "" }, looper("forEach") ),
  s({ trig = ".find",    name = "find",    dscr = "" }, looper("find") ),
  s({ trig = ".some",    name = "some",    dscr = "" }, looper("some") ),
  s({ trig = ".every",   name = "every",   dscr = "" }, looper("every") ),

  s({ trig = "cl", name = "console.log", dscr = "console.log" }, fmta('console.log(<>);', { i(0) }) ),
  s({ trig = "clv", name = "console.log w/ variables", dscr = "console.log with variables" },
    fmta('console.log("<>", <>);', { i(1), rep(1) })
  ),
}
return snippets
