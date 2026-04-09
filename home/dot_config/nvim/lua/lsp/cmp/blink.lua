-- -*-mode:lua-*- vim:ft=lua
local ok, blink = pcall(require, "blink.cmp")
if not ok then return end

local ls = require("luasnip")

---@module "blink.cmp"
---@type blink.cmp.Config
blink.setup({
  ---@see https://cmp.saghen.dev/configuration/keymap.html
  keymap = {
    preset = "default", ---@type "default"|"super-tab"|"enter"|"none"
    ["<C-c>"] = { "cancel", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "select_and_accept" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    ["<S-k>"] = { "show", "show_documentation", "hide_documentation", "fallback" },

    ["<Tab>"]   = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    ["<C-p>"]   = {
      function(_)
        if ls.choice_active() then
          vim.schedule(function() ls.change_choice(-1) end)
          return true
        end
      end,
      "select_prev",
      "fallback_to_mappings",
    },
    ["<C-n>"]   = {
      function(_)
        if ls.choice_active() then
          vim.schedule(function() ls.change_choice(1) end)
          return true
        end
      end,
      "select_next",
      "fallback_to_mappings",
    },
    ["<Up>"]    = { "select_prev", "fallback" },
    ["<Down>"]  = { "select_next", "fallback" },
    ["<Left>"]  = { "hide", "fallback" },
    ["<Right>"] = { "select_and_accept", "fallback" },

  },

  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono", ---@type "mono"|"normal"
    kind_icons = require("lspkind").presets.default,
  },

  signature = { enabled = true }, -- Experimental option

  sources = {
    default = { "lsp", "path", "buffer", "snippets" },

    per_filetype = {
      lua      = { "lazydev", "lsp", "snippets", "path", "buffer" },
      markdown = { "markdown", "lsp", "snippets", "path", "buffer" },
    },
    providers = {
      lazydev  = { name = "LazyDev",        module = "lazydev.integrations.blink",  score_offset = 100 },
      markdown = { name = 'RenderMarkdown', module = "render-markdown.integ.blink", fallbacks = { "lsp" } },
    },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },

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
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" and not vim.tbl_contains({"/", "?"}, vim.fn.getcmdtype())
        end,
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
    ghost_text = { enabled = true, show_with_menu = true },
    accept     = { auto_brackets = { enabled = true } },
    keyword    = { range = "full" },

    documentation = { auto_show = true, auto_show_delay_ms = 100 },
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
      show_on_trigger_character = true,
      show_on_insert_on_trigger_character = true,
      show_on_accept_on_trigger_character = false,
      show_on_blocked_trigger_characters = { " ", "\n", "\t" },
    },
    menu = {
      winblend = 20,
      auto_show = function(ctx)
        return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
      end,
      border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
        treesitter = { "lsp" },
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then icon = dev_icon end
              else
                icon = require("lspkind").symbol_map[ctx.kind] or ""
              end
              return icon .. ctx.icon_gap
            end,

            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then hl = dev_hl end
              end
              return hl
            end,
          }
        }
      },
    },
  },
})
