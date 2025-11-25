-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
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

local snippets = {
  s({ trig = "header", name = "filetype header", dscr = "filetype header template", prioriy = -100 },
    fmt('{}-*-mode:{}-*- vim:ft={}\n', {
      f(function() return vim.bo.commentstring:gsub("%%s", "") end),
      f(function() return vim.bo.filetype end),
      f(function() return vim.bo.filetype end),
    })
  ),
  s({ trig = "MIT", name = "MIT License", dscr = "MIT License template", prioriy = -1000 },
    fmt([[
      The MIT License (MIT)

      Copyright (c) {} {}

      Permission is hereby granted, free of charge, to any person obtaining a copy
      of this software and associated documentation files (the "Software"), to deal
      in the Software without restriction, including without limitation the rights
      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      copies of the Software, and to permit persons to whom the Software is
      furnished to do so, subject to the following conditions:

      The above copyright notice and this permission notice shall be included in
      all copies or substantial portions of the Software.

      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
      THE SOFTWARE.
      {}
    ]], {
      f(function() return os.date("%Y") end, {}),
      i(1, "project"),
      i(0),
    })
  ),
  s({ trig = "APACHE", name = "Apache License", dscr = "Apache License template", prioriy = -1000 },
    fmt([[
      Copyright {} {}

      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.
      {}
    ]], {
      f(function() return os.date("%Y") end, {}),
      i(2, "project"),
      i(0),
    })
  ),
}
return snippets
