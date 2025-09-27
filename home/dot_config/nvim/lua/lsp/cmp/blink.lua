-- -*-mode:lua-*- vim:ft=lua
local ok, blink = pcall(require, "blink.cmp")
if not ok then return end

---@module "blink.cmp"
---@type blink.cmp.Config
blink.setup({
  ---@see https://cmp.saghen.dev/configuration/keymap.html
  keymap = {
    preset = "super-tab",
    ["<C-d>"]   = { "show", "show_documentation", "hide_documentation", "fallback" },
    ["<C-s>"]   = { "show_signature", "hide_signature", "fallback" },
    ["<C-c>"]   = { "cancel", "fallback" },
    ["<C-e>"]   = { "hide", "fallback" },
    ["<Tab>"]   = {
      function(cmp)
        if vim.b[vim.api.nvim_get_current_buf()].nes_state then
          cmp.hide()
          return (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
        end
        return cmp.snippet_active() and cmp.accept() or cmp.select_and_accept()
      end,
      "snippet_forward",
      "fallback",
    },
    ["<C-p>"]   = { "select_prev", "fallback" },
    ["<C-n>"]   = { "select_next", "fallback" },
    ["<C-b>"]   = { "scroll_documentation_up",   "fallback" },
    ["<C-f>"]   = { "scroll_documentation_down", "fallback" },

    ["<Left>"]  = { "hide", "fallback" },
    ["<Right>"] = { "select_and_accept", "fallback" },

    -- ["<CR>"]    = { "select_and_accept" },
  },

  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono", ---@type "mono"|"normal"
    kind_icons = require("lspkind").presets,
  },

  signature = { enabled = true }, -- Experimental option

  sources = {
    default = { "lsp", "lazydev", "path", "buffer", "snippets", "markdown" },

    providers = {
      lsp      = { min_keyword_length = function(ctx) return ctx.trigger.kind == "manual" and 0 or 2  end },
      path     = { min_keyword_length = 0 },
      buffer   = { min_keyword_length = 5 },
      snippets = { min_keyword_length = 1 },

      -- Third party plugin integration
      lazydev       = { name = "LazyDev",        module = "lazydev.integrations.blink",  fallbacks = { "lazy_dev" } },
      markdown      = { name = 'RenderMarkdown', module = 'render-markdown.integ.blink', fallbacks = { 'lsp' } },
    },
  },

  ---@see https://cmp.saghen.dev/modes/cmdline.html
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<Left>"]  = { "hide", "fallback" },
      ["<Right>"] = { "select_and_accept", "fallback" },
    },
    completion = {
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
        },
      },
    },
  },

  term = {
    enabled = true,
    keymap  = { preset = "none" },
    sources = { "path", "buffer" },
    completion = {
      list       = { selection = { preselect = false, auto_insert = false } },
      menu       = { auto_show = false },
      ghost_text = { enabled   = true }
    },
  },

  snippets = { preset = "luasnip" },

  completion = {
    ghost_text = { enabled = true },
    accept     = { auto_brackets = { enabled = true } },
    keyword    = { range = "full" },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      treesitter_highlighting = true,
      window = { border = "rounded" },
    },
    list = {
      max_items = 15,
      selection = {
        preselect   = function(ctx)
          return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
        end,
        auto_insert = function(ctx) return ctx.mode ~= "cmdline" end,
      },
    },
    trigger = {
      show_in_snippet = false,
      show_on_insert_on_trigger_character = false,
      show_on_accept_on_trigger_character = false,
    },
    menu = {
      winblend   = 20,
      min_width  = 25,
      max_height = 40,
      auto_show = function(ctx)
        return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
      end,
      border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
      draw = {
        columns = {
          { "kind_icon", gap = 1 },
          { "label", "label_description", gap = 1 },
          { "source_name" },
        },
        treesitter = { "lsp" },
      },
    },
  },
})
