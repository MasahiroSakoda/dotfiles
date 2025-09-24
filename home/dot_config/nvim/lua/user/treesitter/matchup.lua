-- -*-mode:lua-*- vim:ft=lua
-- local ok, matchup = pcall(require, "match-up")
-- if not ok then return end

-- ---@type matchup.Config
-- matchup.setup({
--   ---@type matchup.TreesitterConfig
--   treesitter = {
--     enabled  = true,
--     disabled = {},
--     stopline = 500,
--     include_match_words  = true,
--     disable_virtual_text = true,
--     enable_quotes        = true,
--   },
--   text_obj = {
--     enabled = 1,
--     linewise_operators = { "y", "d" },
--   },
-- })

vim.g.matchup_matchparen_offscreen            = { method = "status_manual" }
vim.g.matchup_treesitter_stopline             = 500
vim.g.matchup_treesitter_enable_quotes        = true
vim.g.matchup_treesitter_disable_virtual_text = true
vim.g.matchup_treesitter_include_match_words  = true
