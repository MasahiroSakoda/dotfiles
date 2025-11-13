local ok, hlslens = pcall(require, "hlslens")
if not ok then return end

hlslens.setup({
  calm_down = true,
  nearest_only = true,
  -- nearest_float_when = 'always',

  -- build_position_cb = function(plist, _, _, _)
  --   searchbar.handler.show(plist.start_pos)
  -- end,
})
