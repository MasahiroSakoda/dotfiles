-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node     -- luacheck: no unused
local i  = ls.insert_node   -- luacheck: no unused
local c  = ls.choice_node   -- luacheck: no unused
local d  = ls.dynamic_node  -- luacheck: no unused
local r  = ls.restore_node  -- luacheck: no unused
local f  = ls.function_node -- luacheck: no unused
local sn = ls.snippet_node  -- luacheck: no unused
local extras = require("luasnip.extras")
local rep    = extras.rep   -- luacheck: no unused
local m      = extras.m     -- luacheck: no unused
local l      = extras.l     -- luacheck: no unused
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta          -- luacheck: no unused
local postfix = require("luasnip.extras.postfix").postfix   -- luacheck: no unused
local conds   = require("luasnip.extras.conditions")        -- luacheck: no unused
local condse  = require("luasnip.extras.conditions.expand") -- luacheck: no unused

ls.filetype_extend("metal", { "cpp" })

local snippets = {
  -- Vector / Matrix
  s({ trig = "vec2", name = "vec2 template", dsrc = "2 element vector function template" },
    fmt('vec2({}, {})\n{}', { i(1, "param1"), i(2, "param2"), i(0) })
  ),
  s({ trig = "vec3", name = "vec3 template", dsrc = "3 element vector function template" },
    fmt('vec3({}, {}, {})\n{}',     { i(1, "param1"), i(2, "param2"), i(3, "param3"), i(0) })
  ),
  s({ trig = "vec4", name = "vec4 template", dsrc = "4 element vector function template" },
    fmt('vec3({}, {}, {}, {})\n{}', { i(1, "param1"), i(2, "param2"), i(3, "param3"), i(4, "param4"), i(0) })
  ),
  s({ trig = "mat2", name = "mat2 template", dsrc = "2 dimention matrix template" },
    fmt('mat2({}, {})\n{}', { i(1, "param1"), i(2, "param2"), i(0) })
  ),
  s({ trig = "mat3", name = "mat3 template", dsrc = "3 dimention matrix template" },
    fmt('mat3({}, {}, {})\n{}',      { i(1, "param1"), i(2, "param2"), i(3, "param3"), i(0) })
  ),
  s({ trig = "mat4", name = "mat4 template", dsrc = "4 dimention matrix template" },
    fmt('mat4({}, {}, {}, P{})\n{}', { i(1, "param1"), i(2, "param2"), i(3, "param3"), i(4, "param4"), i(0) })
  ),

  s({ trig = "metal", name = "metal shader setup", dscr = "metal shader primary template" },
    fmt([[
      #include <metal_stdlib>
      using namespace metal;

      struct VertexInput {{
          packed_float3 position;
      }};

      struct VertexOutput {{
          float4 position \[\[position\]\];
      }};

      struct Locals {{
      }};

      vertex VertexOutput vertex_main(
          device const VertexInput* vertices \[\[buffer(0)\]\],
          device const Locals& locals \[\[buffer(1)\]\],
          uint vertex_idx \[\[vertex_id\]\]
      ) {{
          VertexOutput out;
          VertexInput in = vertices[vertex_idx];

          out.position = float4(in.position, 1.0);

          return out;
      }}
      fragment float4 fragment_main(VertexOutput in \[\[stage_in\]\]) {{
          return float4(1.0);
      }}
      {}
    ]], { i(0) })
  ),
}
return snippets
