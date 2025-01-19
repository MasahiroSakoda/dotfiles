-- -*-mode:lua-*- vim:ft=lua
local fzf = require("fzf-lua")
local M = {}

M.search_snippets = function()
  local luasnip = require("luasnip")
  local snippets = luasnip.available()
  local entries = {}
  for category, snippet_list in pairs(snippets) do
    if type(snippet_list) == "table" then
      for _, snippet in ipairs(snippet_list) do
        local description = snippet.description[1] or "" -- Extract the first description if available
        local entry = string.format("%s - %s (%s) : %s", snippet.trigger, snippet.name, category, description)
        table.insert(entries, entry)
      end
    end
  end

  -- Use fzf-lua to search through snippets
  fzf.fzf_exec(entries, {
    prompt = "Select Snippet> ",
    actions = {
      ["default"] = function(selected)
        if #selected > 0 then
          -- Extract the trigger from the selected entry
          local trigger = selected[1]:match("^(.-)%s+-")

          -- Insert the trigger into the current buffer and go into insert mode
          vim.api.nvim_put({ trigger }, "c", true, true)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>i", true, true, true), "n", true)
        end
      end,
    },
  })
end

M.search_plugins = function()
  local path = vim.fn.stdpath("data") .. "/lazy/"
  local dirs = vim.fs.dir(path)
  local plugins = {}
  for dir in dirs do
    table.insert(plugins, dir)
  end

  fzf.fzf_exec({
    prompt = "Plugin> ",
    actions = {
      ["default"] = {
        function(selected) fzf.files({ cwd = path .. selected[1] }) end,
      },
    },
  })
end

return M
