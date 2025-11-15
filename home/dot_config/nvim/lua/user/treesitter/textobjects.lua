-- -*-mode:lua-*- vim:ft=lua
local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if not ok then return end

textobjects.setup({
  move   = { set_jump = true },
  select = {
    lockahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@parameter.inner"] = "v",
      ["@function.outer"]  = "V",
      ["@return.outer"]    = "V",
      ["@class.outer"]     = "<c-v>",
    },
    include_surrounding_whitespace = true,
  },
})

-- Mappings
local xo, nxo = { "x", "o" }, { "n", "x", "o" }
local wk = require("which-key")
-- Select
local select  = require("nvim-treesitter-textobjects.select").select_textobject
wk.add({
  mode = xo,
  { "ac", function() select("@class.outer",       "textobjects") end, icon = " ", desc = "Select around class" },
  { "ic", function() select("@class.inner",       "textobjects") end, icon = " ", desc = "Select inside class" },
  { "af", function() select("@function.outer",    "textobjects") end, icon = " ", desc = "Select around func" },
  { "if", function() select("@function.inner",    "textobjects") end, icon = " ", desc = "Select inside func" },
  { "ar", function() select("@return.outer",      "textobjects") end, icon = " ", desc = "Select around return" },
  { "ir", function() select("@return.inner",      "textobjects") end, icon = " ", desc = "Select inside return" },
  { "ab", function() select("@block.outer",       "textobjects") end, icon = " ", desc = "Select around block" },
  { "ib", function() select("@block.inner",       "textobjects") end, icon = " ", desc = "Select inside block" },
  { "al", function() select("@loop.outer",        "textobjects") end, icon = "󰅲 ", desc = "Select around loop" },
  { "il", function() select("@loop.inner",        "textobjects") end, icon = "󰅲 ", desc = "Select inside loop" },
  { "a?", function() select("@conditional.outer", "textobjects") end, icon = " ", desc = "Select around cond" },
  { "i?", function() select("@conditional.inner", "textobjects") end, icon = " ", desc = "Select inside cond" },
  { "ap", function() select("@parameter.outer",   "textobjects") end, icon = " ", desc = "Select around param" },
  { "ip", function() select("@parameter.inner",   "textobjects") end, icon = " ", desc = "Select inside param" },
  { "as", function() select("@local.scope",       "textobjects") end, icon = " ", desc = "Select local scope" },
}, { noremap = true })
-- Swap
local swap   = require("nvim-treesitter-textobjects.swap")
local sp, sn = swap.swap_previous, swap.swap_next
wk.add({
  mode = "n",
  { "g<", function() sp("@parameter.inner") end, icon = " ", desc = "Swap prev argument" },
  { "g>", function() sn("@parameter.inner") end, icon = " ", desc = "Swap next argument" },
}, { noremap = true })
-- Move
local move = require("nvim-treesitter-textobjects.move")
local gps, gns = move.goto_previous_start, move.goto_next_start
wk.add({
  mode = nxo,
  { "[c", function() gps("@class.outer",       "textobjects") end, icon = " ", desc = "Go to prev class start" },
  { "[f", function() gps("@function.outer",    "textobjects") end, icon = " ", desc = "Go to prev func start" },
  { "[l", function() gps("@loop.outer",        "textobjects") end, icon = "󰅲 ", desc = "Go to prev loop start" },
  { "[?", function() gps("@conditional.outer", "textobjects") end, icon = " ", desc = "Go to prev cond start" },
  { "[p", function() gps("@parameter.inner",   "textobjects") end, icon = " ", desc = "Go to prev param start" },
  { "[r", function() gps("@return.inner",      "textobjects") end, icon = " ", desc = "Go to prev return" },
  { "]c", function() gns("@class.outer",       "textobjects") end, icon = " ", desc = "Go to next class start" },
  { "]f", function() gns("@function.outer",    "textobjects") end, icon = " ", desc = "Go to next func start" },
  { "]l", function() gns("@loop.outer",        "textobjects") end, icon = "󰅲 ", desc = "Go to next loop start" },
  { "]?", function() gns("@conditional.outer", "textobjects") end, icon = " ", desc = "Go to next cond start" },
  { "]p", function() gns("@parameter.inner",   "textobjects") end, icon = " ", desc = "Go to prev param start" },
  { "]r", function() gns("@return.inner",      "textobjects") end, icon = " ", desc = "Go to next return" },
}, { noremap = true })
-- Repeatable Move
local repmove = require("nvim-treesitter-textobjects.repeatable_move")
wk.add({
  mode = nxo,
  { ";", repmove.repeat_last_move,                       icon = "󰑙 ", desc = "Repeat last move forward" },
  { ",", repmove.repeat_last_move_opposite,              icon = "󰑙 ", desc = "Repeat last move backward" },
  { "f", repmove.builtin_f_expr,            expr = true, icon = " ", desc = "Repeat moving with f" },
  { "F", repmove.builtin_F_expr,            expr = true, icon = " ", desc = "Repeat moving with F" },
  { "t", repmove.builtin_t_expr,            expr = true, icon = " ", desc = "Repeat moving with t" },
  { "T", repmove.builtin_T_expr,            expr = true, icon = " ", desc = "Repeat moving with T" },
}, { noremap = true })
