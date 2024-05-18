-- -*-mode:lua-*- vim:ft=lua

return {
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "mortepau/codicons.nvim", config = function() require("ui.codicons") end },
}
