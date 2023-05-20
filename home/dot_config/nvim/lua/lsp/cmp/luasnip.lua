local ok, luasnip = pcall(require, "luasnip")
if not ok then return end

-- https://github.com/yutkat/dotfiles/blob/main/.config/nvim/lua/rc/pluginconfig/LuaSnip.lua#L47
luasnip.setup({
  history = true,

  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
  -- This can be especially useful when `history` is enabled.
  delete_check_events = "TextChanged",

  ft_func = function() vim.split(vim.bo.filetype, ".", true) end,
})

require("luasnip.loaders.from_vscode").lazy_load({
  paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
})

luasnip.filetype_extend("all", { "_" })
