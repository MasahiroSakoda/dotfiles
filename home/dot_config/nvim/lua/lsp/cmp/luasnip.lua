local ok, luasnip = pcall(require, "luasnip")
if not ok then return end

local types = require("luasnip.util.types")

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

luasnip.config.setup({
  history = true,

  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",

  -- This can be especially useful when `history` is enabled.
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
  enable_autosnippets = true,

  ft_func = require("luasnip.extras.filetype_functions").from_cursor,

  ext_opts = {
    [types.insertNode] = { active = { virt_text = { { "●", "GruvboxBlue" } },   hl_mode = "combine" } },
    [types.choiceNode] = { active = { virt_text = { { "●", "GruvboxOrange" } }, hl_mode = "combine" } },
  },

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

vim.api.nvim_create_user_command("LuaSnipReload", function()
  require("utils.snippet").reload()
end, { desc = "Reload luasnip snippets", nargs = "*", bang = true })

vim.api.nvim_create_user_command("LuaSnipEdit", function()
  -- require("luasnip.loaders").edit_snippet_files({})
  Snacks.picker.smart({ cwd = os.getenv("XDG_DATA_HOME") .. "/chezmoi/home/dot_config/nvim/lua/snippets" })
end, { desc = "", nargs = "*", bang = true })

vim.api.nvim_create_user_command("LuaSnipBrowse", function()
  local items = require("utils.snippet").snippets()
  Snacks.picker.pick({
    items  = items,
    format = function(item, _)
      local snip, a = {}, Snacks.picker.util.align
      local icon, icon_hl = Snacks.util.icon(item.file, "snippet")
      snip[#snip + 1] = { a(string.format("%-03d", item.idx), 3) }
      snip[#snip + 1] = { a(icon, 3), icon_hl }
      snip[#snip + 1] = { a(item.file, 10) }
      snip[#snip + 1] = { a(item.trig, 15) }
      snip[#snip + 1] = { a(item.name, 20) }
      return snip
    end,
    preview = "none",
    confirm = function(picker, item) picker:close() end,
  })
end, { desc = "", nargs = "*", bang = true })
