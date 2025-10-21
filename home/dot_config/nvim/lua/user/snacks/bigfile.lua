-- -*-mode:lua-*- vim:ft=lua

---@class snacks.bigfile.Config
return {
  enable = true,
  notify = true, -- show notification when big file detected
  size = 1.5 * 1024 * 1024, -- 1.5MB
  line_length = 5000, -- files with a line >= this number is considered big file
  -- Enable or disable features when big file detected
  ---@param ctx {buf: number, ft:string}
  setup = function(ctx)
    vim.b.minianimate_disable = true
    vim.schedule(function()
      vim.bo[ctx.buf].syntax = ctx.ft
    end)
  end,
}
