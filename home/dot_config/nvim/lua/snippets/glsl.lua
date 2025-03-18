-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, i = ls.snippet, ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("glsl", { "c" })

local snippets = {
  s({ trig = "maini", name = "mainImage", dscr = "mainImage function template" }, fmt([[
      void mainImage( out vec4 fragColor, in vec2 fragCoord ) {{
          // Normalized pixel coordinates (from 0 to 1)
          vec2 uv = fragCoord/iResolution.xy;
          vec4 terminalColor = texture(iChannel0, uv);
          fragColor = vec4(vec3(sin(uv.x * 30. + iTime)), terminalColor.a);
      }}
      {}
    ]], { i(0) })
  ),

  s({ trig = "c2p", name = "cartesian to polar coords", dscr = "cartesian coords to polar coords" },
    fmt([[
      // Normalized to -1~1 (in order to centerize screen origin)
      vec2 uv = (fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;

      // Length from uv value
      float r = length(uv);

      // Normalized to handle positions on a unit circle
      vec2 nuv = normalize(uv);

      // Normalized to handle positions on a unit circle
      float theta = fract(atan(nuv.y, nuv.x) / PI_TWO);
      {}
    ]], { i(0) })
  ),

  s({ trig = "p2x", name = "x from polar coords", dscr = "x value from polar coordinates" }, fmt([[
      float x = r * cos(theta)
      {}
    ]], { i(0) })
  ),
  s({ trig = "p2y", name = "x from polar coords", dscr = "x value from polar coordinates" }, fmt([[
      float x = r * sin(theta)
      {}
    ]], { i(0) })
  ),
  s({ trig = "xy2r", name = "length from x, y coords", dscr = "length from cartesian coordinates" }, fmt([[
      float r = length(uv);
      {}
    ]], { i(0) })
  ),
  s({ trig = "xy2th", name = "argument from xy coords", dscr = "argument from cartesian coordinates" }, fmt([[
      float theta = fract(atan(nuv.y, nuv.x) / PI_TWO);
      {}
    ]], { i(0) })
  ),
}
return snippets
