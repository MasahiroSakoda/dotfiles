-- -*-mode:lua-*- vim:ft=lua
local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if not ok then return end

textobjects.setup({
  move   = { set_jump = true },
  select = {
    lockahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"]  = "V",
      ["@class.outer"]     = "<c-v>",
    },
    include_surrounding_whitespace = true,
  },
})

-- Mappings
local xo, nxo = { "x", "o" }, { "n", "x", "o" }
local select  = require("nvim-treesitter-textobjects.select")
local swap    = require("nvim-treesitter-textobjects.swap")
local move    = require("nvim-treesitter-textobjects.move")
local repmove = require("nvim-treesitter-textobjects.repeatable_move")
-- Select
vim.keymap.set(xo, "af", function() select.seleect_object("@function.outer",    "textobjects") end)
vim.keymap.set(xo, "if", function() select.seleect_object("@function.inner",    "textobjects") end)
vim.keymap.set(xo, "ac", function() select.seleect_object("@class.outer",       "textobjects") end)
vim.keymap.set(xo, "ic", function() select.seleect_object("@class.inner",       "textobjects") end)
vim.keymap.set(xo, "ab", function() select.seleect_object("@block.outer",       "textobjects") end)
vim.keymap.set(xo, "ib", function() select.seleect_object("@block.inner",       "textobjects") end)
vim.keymap.set(xo, "al", function() select.seleect_object("@loop.outer",        "textobjects") end)
vim.keymap.set(xo, "il", function() select.seleect_object("@loop.inner",        "textobjects") end)
vim.keymap.set(xo, "a?", function() select.seleect_object("@conditional.outer", "textobjects") end)
vim.keymap.set(xo, "i?", function() select.seleect_object("@conditional.inner", "textobjects") end)
vim.keymap.set(xo, "as", function() select.seleect_object("@local.scope",       "textobjects") end)
-- Swap
vim.keymap.set("n", "<leader>a", function() swap.swap_next("@parameter.inner") end)
vim.keymap.set("n", "<leader>A", function() swap.swap_previous("@parameter.outer") end)
-- Move
vim.keymap.set(nxo, "[C", function() move.goto_previous_start("@class.outer",       "textobjects") end)
vim.keymap.set(nxo, "[F", function() move.goto_previous_start("@function.outer",    "textobjects") end)
vim.keymap.set(nxo, "[L", function() move.goto_previous_start("@loop.outer",        "textobjects") end)
vim.keymap.set(nxo, "[D", function() move.goto_previous_start("@conditional.outer", "textobjects") end)
vim.keymap.set(nxo, "]C", function() move.goto_previous_end("@class.outer",         "textobjects") end)
vim.keymap.set(nxo, "]F", function() move.goto_previous_end("@function.outer",      "textobjects") end)
vim.keymap.set(nxo, "]L", function() move.goto_previous_end("@loop.outer",          "textobjects") end)
vim.keymap.set(nxo, "]D", function() move.goto_previous_end("@conditional.outer",   "textobjects") end)
vim.keymap.set(nxo, "[c", function() move.goto_next_start("@class.outer",           "textobjects") end)
vim.keymap.set(nxo, "[f", function() move.goto_next_start("@function.outer",        "textobjects") end)
vim.keymap.set(nxo, "[l", function() move.goto_next_start("@loop.outer",            "textobjects") end)
vim.keymap.set(nxo, "[d", function() move.goto_next_start("@conditional.outer",     "textobjects") end)
vim.keymap.set(nxo, "]c", function() move.goto_next_end("@class.outer",             "textobjects") end)
vim.keymap.set(nxo, "]f", function() move.goto_next_end("@function.outer",          "textobjects") end)
vim.keymap.set(nxo, "]l", function() move.goto_next_end("@loop.outer",              "textobjects") end)
vim.keymap.set(nxo, "]d", function() move.goto_next_end("@conditional.outer",       "textobjects") end)
-- Repeatable Move
vim.keymap.set(nxo, ";", repmove.repeat_last_move)
vim.keymap.set(nxo, ",", repmove.repeat_last_move_opposite)
vim.keymap.set(nxo, "f", repmove.builtin_f_expr, { expr = true })
vim.keymap.set(nxo, "F", repmove.builtin_F_expr, { expr = true })
vim.keymap.set(nxo, "t", repmove.builtin_t_expr, { expr = true })
vim.keymap.set(nxo, "T", repmove.builtin_T_expr, { expr = true })
