local ok, luasnip = pcall(require, "luasnip")
if not ok then return end

luasnip.filetype_extend("c",      { "cdoc" })
luasnip.filetype_extend("cpp",    { "cppdoc" })
luasnip.filetype_extend("rust",   { "rustdoc" })
luasnip.filetype_extend("kotlin", { "kdoc" })
luasnip.filetype_extend("php",    { "phpdoc" })
luasnip.filetype_extend("ruby",   { "rdoc", "rails" })
luasnip.filetype_extend("python", { "pydoc", "django" })
luasnip.filetype_extend("lua",    { "luadoc" })
luasnip.filetype_extend("javascript", { "javascriptreact", "html" })
luasnip.filetype_extend("typescript", { "typescript", "html" })
luasnip.filetype_extend("javascriptreact", { "javascript", "html" })
luasnip.filetype_extend("typescriptreact", { "typescript", "html" })

luasnip.config.set_config({
  history = true,

  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",

  -- This can be especially useful when `history` is enabled.
  delete_check_events = "TextChanged",
  enable_autosnippets = true,

  ft_func = require("luasnip.extras.filetype_functions").from_cursor,

  -- extend filetypes
  load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
    markdown   = { "html", "css", "lua", "json", "yaml", "javascript", "typescript", "typescriptreact" },
    html       = { "css", "javascript", "json", "graphql" },
    javascript = { "html", "css", "graphql" },
    typescript = { "html", "css", "graphql" },
    javascriptreact = { "javascript" },
    typescriptreact = { "javascript", "typescript", "javascriptreact" },
    python = { "ipynb" },
  })
})
