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

ls.filetype_extend("metal", { "cpp" })

local snippets = {
  -- Vector / Matrix
  s({ trig = "vec2", name = "vec2 template", dsrc = "2 element vector function template" },
    fmt('vec2({}, {})', { i(1, "param1"), i(2, "param2") })
  ),
  s({ trig = "vec3", name = "vec3 template", dsrc = "3 element vector function template" },
    fmt('vec3({}, {}, {})',     { i(1, "param1"), i(2, "param2"), i(3, "param3") })
  ),
  s({ trig = "vec4", name = "vec4 template", dsrc = "4 element vector function template" },
    fmt('vec3({}, {}, {}, {})', { i(1, "param1"), i(2, "param2"), i(3, "param3"), i(4, "param4") })
  ),
  s({ trig = "mat2", name = "mat2 template", dsrc = "2 dimention matrix template" },
    fmt('mat2({}, {})', { i(1, "param1"), i(2, "param2") })
  ),
  s({ trig = "mat3", name = "mat3 template", dsrc = "3 dimention matrix template" },
    fmt('mat3({}, {}, {})',      { i(1, "param1"), i(2, "param2"), i(3, "param3") })
  ),
  s({ trig = "mat4", name = "mat4 template", dsrc = "4 dimention matrix template" },
    fmt('mat4({}, {}, {}, P{})', { i(1, "param1"), i(2, "param2"), i(3, "param3"), i(4, "param4") })
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
    }}
    ]], { i(1, "") })
  ),
}
return snippets
