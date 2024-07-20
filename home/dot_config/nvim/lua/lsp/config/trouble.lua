local ok, trouble = pcall(require, "trouble")
if not ok then return end

trouble.setup({
  auto_close    = false, -- auto close when there are no items
  auto_open     = false, -- auto open when there are items
  auto_preview  = true,  -- automatically open preview when on an item
  auto_refresh  = true,  -- auto refresh when open
  auto_jump     = false, -- auto jump to the item when there's only one
  focus         = true,  -- Focus the window when opened
  restore       = true,  -- restores the last location in the list when opening
  follow        = true,  -- Follow the current item
  indent_guides = true,  -- show indent guides
  max_items     = 200,   -- limit number of items that can be displayed per section
  multiline     = true,  -- render multi-line messages
  pinned        = false, -- When pinned, the opened trouble window will be bound to the current buffer

  warn_no_results = false, -- show a warning when there are no results
  open_no_results = true,  -- open the trouble window when there are no results

})
