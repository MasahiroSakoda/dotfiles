-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")

---@type snacks.Config
return {
  supports_live = false,
  preview = "preview",

  format = function(item, picker)
    local ret = {} ---@type snacks.picker.Highlight
    local icon, hl = require("snacks.util").icon(item.ft, "filetype")
    local a = require("snacks.picker").util.align
    ret[#ret + 1] = { a(icon, 5), hl }
    ret[#ret + 1] = { a(item.ft == nil and "all" or item.ft, 10), hl }
    ret[#ret + 1] = { a(item.trigger, 15), "SnacksPickerFile" }
    ret[#ret + 1] = { a(item.name, picker.align_1 + 5), item.ft == nil and "Comment" or "SnacksPickerCmd" }
    ret[#ret + 1] = { a(item.description, 35), "CursorLineFold" }
    return ret
  end,

  finder = function(_, ctx)
    local snippets = {}
    for _, snip in ipairs(ls.get_snippets().all) do
      table.insert(snippets, snip)
    end

    for _, snip in ipairs(ls.get_snippets(vim.bo.ft)) do
      snip.ft = vim.bo.ft
      table.insert(snippets, snip)
    end

    local align_1 = 0
    for _, snip in pairs(snippets) do
      align_1 = math.max(align_1, #snip.name)
    end

    ctx.picker.align_1 = align_1
    local items = {}
    for _, snip in pairs(snippets) do
      local docstring = snip:get_docstring()
      if type(docstring) == "table" then
        docstring = table.concat(docstring)
      end
      local name, desc = snip.name, table.concat(snip.description)
      desc = name == desc and "" or desc
      table.insert(items, {
        text = name .. " " .. desc, -- search string
        name = name,
        description = desc,
        trigger = snip.trigger,
        ft = snip.ft,
        preview = { ft = snip.ft, text = docstring },
      })
    end
    return items
  end,

  confirm = function(picker, item)
    picker:close()
    local expand = {}
    ls.available(function(snippet)
      if snippet.trigger == item.trigger then
        table.insert(expand, snippet)
      end
      return snippet
    end)
    if #expand > 0 then
      vim.cmd ":startinsert!"
      vim.defer_fn(function()
        ls.snip_expand(expand[1])
      end, 50)
    else
      vim.notify("No snippet found", vim.log.levels.INFO)
    end
  end,

  actions = {
  },

  win = {
    input = {
      keys = {
        ["<CR>"] = {},
      },
    },
  },
}
