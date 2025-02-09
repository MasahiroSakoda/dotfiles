-- -*-mode:lua-*- vim:ft=lua
local cmp_ok,     cmp     = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
local lspkind_ok, lspkind = pcall(require, "lspkind")
if not (cmp_ok or lspkind_ok or luasnip_ok) then return end

local compare = cmp.config.compare
local border_opts = {
  border = "rounded", ---@Usage "single", "rounded"
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}
local select_opts = { behavior = cmp.SelectBehavior.Select }
local anyWord = [[\k\+]]

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local menu = {
  cmdline         = "[Cmd]",
  path            = "[Path]",
  nvim_lsp        = "[LSP]",
  luasnip         = "[Snip]",
  cmdline_history = "[Hist]",
  buffer          = "[Buf]",
}

local fd_opts = {
  fd_timeout_msec = 2500,
  fd_cmd = {
    "fd", "--hidden", "-d", "20",
    "-E", ".git/**", "-E", "node_modules/**", "-E", ".venv/**", "-E", "*.pyc", "-E", "vendor",
  },
}
local ignore_cmds = { "Man", "!", "q", "qa", "w", "wq", "x", "xa", "cq", "cqa", "cw", "cwq", "cx", "cxa" }
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

local sources = {
  { name = "lazydev",  group_index = 0 },
  { name = "luasnip",  group_index = 1, priority = 100, max_item_count = 15 },
  { name = "nvim_lsp", group_index = 2, priority = 90,  max_item_count = 15 },
  { name = "path",     keyword_length = 3, max_item_count = 5 },
  { name = "buffer",   keyword_length = 3, max_item_count = 5, option = { keyword_pattern = anyWord } },
}

local comparators = {
  compare.offset,
  compare.exact,
  -- compare.scopes,
  compare.score,
  compare.recently_used,
  compare.locality,
  compare.kind,
  compare.sort_text,
  compare.length,
  compare.order,
}

cmp.setup({
  window = {
    completion    = cmp.config.window.bordered(border_opts),
    documentation = cmp.config.window.bordered(border_opts),
  },
  completion = {
    border = "rounded",
    winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    completeopt = "menu,menuone,noinsert",
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select   = false,
  },

  formatting = {
    expandable_indicator = true,
    fields = { "abbr", "kind", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      ellipsis_char = '...',
      symbol_map = { copilot = "", tabnine = "", Codeium = "", },
      before = function (entry, vim_item)
        vim_item.menu = menu[entry.source.name]
        -- Delete duplicates
        vim_item.dup = ({ cmdline = 0 })[entry.source.name] or 0
        return vim_item
      end,
    })
  },

  sources = sources,
  sorting = {
    priority_weight = 2,
    comparators = comparators,
  },

  preselect = cmp.PreselectMode.None,
  -- duplicates = {
  --   nvim_lsp = 1,
  --   path     = 1,
  -- },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For luasnip users
    end,
  },

  mapping = cmp.mapping.preset.insert({
    -- Scroll
    ["<C-f>"]  = cmp.mapping(cmp.mapping.scroll_docs(4),  { "i", "c" }),
    ["<C-b>"]  = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),

    ["<Left>"]  = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
    ["<Right>"] = cmp.mapping(cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Insert,
    }), { 'i', 'c' }),
    ["<Up>"]    = cmp.mapping.select_prev_item(select_opts),
    ["<Down>"]  = cmp.mapping.select_next_item(select_opts),
    ["<C-p>"]   = cmp.mapping.select_prev_item(select_opts),
    ["<C-n>"]   = cmp.mapping.select_next_item(select_opts),

    ["<Tab>"]  = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Backspace>"]  = cmp.mapping(function(fallback)
      if cmp.visible() and not has_words_before() then
        cmp.close()
      end
      fallback()
    end, { "i", "s" }),

    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"]  = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = {
      hl_group = "CmpGhostText",
    },
  },
})

-- Search Completion
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer",          keyword_length = 1, option = { keyword_pattern = anyWord } },
    { name = "cmdline_history", keyword_length = 2, option = { keyword_pattern = anyWord } },
  },
})

-- Command Line Completion
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {
      name = "cmdline",
      group_index    = 1,
      priority       = 2,
      max_item_count = 5,
      keyword_length = 2,
      option = { ignore_cmds = ignore_cmds },
      keyword_pattern = [=[[^[:blank:]\!]*]=]
    },
    { name = "cmdline_history", group_index = 2, priority = 1, max_item_count = 5, keyword_length = 1  },
    { name = "path",            group_index = 2, priority = 2, max_item_count = 20, option = fd_opts },
  },
  formatting = {
    expandable_indicator = true,
    fields = { "menu", "abbr", "kind" },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      ellipsis_char = "...",
      menu = menu,
      before = function(entry, vim_item)
        -- Delete duplicates
        vim_item.dup = ({ cmdline = 0 })[entry.source.name] or 0
        return vim_item
      end
    })
  },
})
