-- -*-mode:lua-*- vim:ft=lua

---@type snacks.scratch.Config
return {
  enabled = true,
  -- ft = function()
  --   if vim.bo.buftype ~= "" or vim.bo.ft == "" then return "markdown" end
  --   return vim.bo.ft
  -- end,

  win = {
    width  = 0.55,
    height = 0.55,

    border     = "double",
    title_pos  = "center",
    footer_pos = "center",
  },
}
