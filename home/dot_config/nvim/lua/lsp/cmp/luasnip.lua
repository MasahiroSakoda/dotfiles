-- -*-mode:lua-*- vim:ft=lua
local ok, ls = pcall(require, "luasnip")
if not ok then return end

local types = require("luasnip.util.types")

require("luasnip.loaders.from_vscode").lazy_load({})
require("luasnip.loaders.from_lua").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
  fs_event_providers = { libuv = true },
})

ls.filetype_extend("rust",   { "rustdoc" })
ls.filetype_extend("kotlin", { "kdoc" })
ls.filetype_extend("php",    { "phpdoc" })

ls.config.setup({
  history = true,

  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",

  -- This can be especially useful when `history` is enabled.
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
  enable_autosnippets = true,

  ft_func = require("luasnip.extras.filetype_functions").from_cursor,

  ext_opts = {
    [types.insertNode] = {
      active    = { virt_text = { { "●", "yellow" } } },
      unvisited = { virt_text = { { "|", "Conceal" } }, hl_mode = "combine" },
    },
    [types.choiceNode] = {
      active    = { virt_text = { { "●", "Special" } }, hl_mode = "combine" },
    },
    [types.exitNode] = {
      unvisited = { virt_text = { { "|", "Conceal" } }, hl_mode = "combine" },
    }
  },

  load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
    markdown   = { "lua", "json", "yaml" },
    html       = { "css", "javascript", "json", "graphql" },
    javascript = { "html", "css", "graphql" },
    typescript = { "html", "css", "graphql" },
    javascriptreact = { "javascript" },
    typescriptreact = { "javascript", "typescript", "javascriptreact" },
    python = { "ipynb" },
  }),
})

local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
local current_win = nil

local function window_for_choiceNode(choiceNode)
  local buf, buf_text = vim.api.nvim_create_buf(false, true), {}
  local row_selection, row_offset = 0, 0
  local text
  for _, node in ipairs(choiceNode.choices) do
    text = node:get_docstring()
    -- find one that is currently showing
    if node == choiceNode.active_choice then
      -- current line is starter from buffer list which is length usually
      row_selection = #buf_text
      -- finding how many lines total within a choice selection
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
  local w, h = vim.lsp.util._make_floating_popup_size(buf_text, {})

  -- adding highlight so we can see which one is been selected.
  local extmark = vim.api.nvim_buf_set_extmark(buf, current_nsid, row_selection, 0, {
    hl_group = "incsearch",
    end_line = row_selection + row_offset,
  })

  -- shows window at a beginning of choiceNode.
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "win",
    width    = w,
    height   = h,
    bufpos   = choiceNode.mark:pos_begin_end(),
    style    = "minimal",
    border   = "rounded",
  })

  -- return with 3 main important so we can use them again
  return { win_id = win, extmark = extmark, buf = buf }
end

local function choice_popup(choiceNode)
  -- build stack for nested choiceNodes.
  if current_win then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  end
  local create_win = window_for_choiceNode(choiceNode)
  current_win = {
    win_id  = create_win.win_id,
    prev    = current_win,
    node    = choiceNode,
    extmark = create_win.extmark,
    buf     = create_win.buf
  }
end

local function update_choice_popup(choiceNode)
  if not current_win then return end
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  local create_win = window_for_choiceNode(choiceNode)
  current_win.win_id  = create_win.win_id
  current_win.extmark = create_win.extmark
  current_win.buf     = create_win.buf
end

local function choice_popup_close()
  if not current_win then return end
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  -- now we are checking if we still have previous choice we were in after exit nested choice
  current_win = current_win.prev
  if current_win then
    -- reopen window further down in the stack.
    local create_win    = window_for_choiceNode(current_win.node)
    current_win.win_id  = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf     = create_win.buf
  end
end

local choice_group = vim.api.nvim_create_augroup("LuaSnipChoicePopup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern  = "LuasnipChoiceNodeEnter",
  group    = choice_group,
  callback = function(_) choice_popup(ls.session.event_node) end,
})

vim.api.nvim_create_autocmd("User", {
  pattern  = "LuasnipChoiceNodeLeave",
  group    = choice_group,
  callback = function(_) choice_popup_close() end,
})

vim.api.nvim_create_autocmd("User", {
  pattern  = "LuasnipChangeChoice",
  group    = choice_group,
  callback = function(_) update_choice_popup(ls.session.event_node) end,
})

local util      = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")

local function find_dynamic_node(node)
  -- the dynamicNode-key is set on snippets generated by a dynamicNode only (its'
  -- actual use is to refer to the dynamicNode that generated the snippet).
  while not node.dynamicNode do
    node = node.parent
    if not node then
      return
    end
  end
  return node.dynamicNode
end

local external_update_id = 0
-- func_indx to update the dynamicNode with different functions.
function _G.dynamic_node_external_update(func_indx)
  -- most of this function is about restoring the cursor to the correct
  -- position+mode, the important part are the few lines from
  -- `dynamic_node.snip:store()`.

  -- find current node and the innermost dynamicNode it is inside.
  local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
  local dynamic_node = find_dynamic_node(current_node)

  if not dynamic_node then
    return
  end

  -- to identify current node in new snippet, if it is available.
  external_update_id = external_update_id + 1
  current_node.external_update_id = external_update_id
  local current_node_key = current_node.key

  -- store which mode we're in to restore later.
  local insert_pre_call = vim.fn.mode() == "i"
  -- is byte-indexed! Doesn't matter here, but important to be aware of.
  local cursor_pos_end_relative = util.pos_sub(
    util.get_cursor_0ind(),
    current_node.mark:get_endpoint(1)
  )

  -- leave current generated snippet.
  node_util.leave_nodes_between(dynamic_node.snip, current_node)

  -- call update-function.
  local func = dynamic_node.user_args[func_indx]
  if func then
    -- the same snippet passed to the dynamicNode-function. Any output from func
    -- should be stored in it under some unused key.
    func(dynamic_node.parent.snippet)
  end

  -- last_args is used to store the last args that were used to generate the
  -- snippet. If this function is called, these will most probably not have
  -- changed, so they are set to nil, which will force an update.
  dynamic_node.last_args = nil
  dynamic_node:update()

  -- everything below here isn't strictly necessary, but it's pretty nice to have.


  -- try to find the node we marked earlier, or a node with the same key.
  -- Both are getting equal priority here, it might make sense to give "exact
  -- same node" higher priority by doing two searches (but that would require
  -- two searches :( )
  local target_node = dynamic_node:find_node(function(test_node)
    return (test_node.external_update_id == external_update_id)
      or (current_node_key ~= nil and test_node.key == current_node_key)
  end)

  if target_node then
    -- the node that the cursor was in when changeChoice was called exists
    -- in the active choice! Enter it and all nodes between it and this choiceNode,
    -- then set the cursor.
    node_util.enter_nodes_between(dynamic_node, target_node)

    if insert_pre_call then
      -- restore cursor-position if the node, or a corresponding node,
      -- could be found.
      -- It is restored relative to the end of the node (as opposed to the
      -- beginning). This does not matter if the text in the node is
      -- unchanged, but if the length changed, we may move the cursor
      -- relative to its immediate neighboring characters.
      -- I assume that it is more likely that the text before the cursor
      -- got longer (since it is very likely that the cursor is just at
      -- the end of the node), and thus restoring relative to the
      -- beginning would shift the cursor back.
      --
      -- However, restoring to any fixed endpoint is likely to not be
      -- perfect, an interesting enhancement would be to compare the new
      -- and old text/[neighborhood of the cursor], and find its new position
      -- based on that.
      util.set_cursor_0ind(
        util.pos_add(
          target_node.mark:get_endpoint(1),
          cursor_pos_end_relative
        )
      )
    else
      node_util.select_node(target_node)
    end
    -- set the new current node correctly.
    ls.session.current_nodes[vim.api.nvim_get_current_buf()] = target_node
  else
    -- the marked node wasn't found, just jump into the new snippet noremally.
    ls.session.current_nodes[vim.api.nvim_get_current_buf()] = dynamic_node.snip:jump_into(1)
  end

end

require("which-key").add({
  { "<C-t>", function() _G.dynamic_node_external_update(1) end, mode = "i", icon = " ", desc = "" },
  { "<C-t>", function() _G.dynamic_node_external_update(1) end, mode = "s", icon = " ", desc = "" },
  { "<C-g>", function() _G.dynamic_node_external_update(2) end, mode = "i", icon = " ", desc = "" },
  { "<C-g>", function() _G.dynamic_node_external_update(2) end, mode = "s", icon = " ", desc = "" },
}, { noremp = true })
