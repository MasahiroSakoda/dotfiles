---------------------------------------------------------------------------
-- Binding Rules:
-- Builtin keymap: <Leader> + h: help, H: history, b: Buffer, t: Tab, s: Split
-- LSP keymap: <Leader> + l
-- DAP keymap: <Leader> + d
-- Git Keymap: <Leader> + g
-- Fuzzy Finder: <Leader> + f
-- Task Runner: <Leader> + o
---------------------------------------------------------------------------
local is_vscode = vim.g.vscode
local opts = { noremap = true }
local nv, nx, nt, nxo, o, ox, c = {"n", "v"}, {"n", "x"}, {"n", "t"}, {"n", "x", "o"}, {"o"}, {"o", "x"}, {"c"}

local ok, wk = pcall(require, "which-key")
if not ok then vim.notify("Failed loading " .. "which-key", vim.log.levels.WARN) end

-- Abbreviation for typo
vim.cmd[[
  cnoreabbrev Q! q!
  cnoreabbrev q1 q!
  cnoreabbrev Q1 q!
  cnoreabbrev W! w!
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
]]

---------------------------------------------------------------------------
-- which-key: <Leader> + w
---------------------------------------------------------------------------
wk.add({
  { "<Leader>w", group = "Which-Key", icon = "⌨️ " },
  { "<Leader>wk", "<CMD>WhichKey<CR>",            icon = " ", desc = "All maps" },
  { "<Leader>wl", "<CMD>WhichKey <Leader><CR>",   icon = " ", desc = "All <Leader> maps" },
  { "<Leader>wv", "<CMD>WhichKey <Leader> v<CR>", icon = " ", desc = "All <Leader> maps for VISUAL mode" },
}, opts)

---------------------------------------------------------------------------
-- ❓ Help: <Leader> + H
---------------------------------------------------------------------------
wk.add({
  { "<Leader>h", ":help<Space>", icon = "❓ ", desc = "Open Help page" },
}, opts)

---------------------------------------------------------------------------
-- 🕒  History: <Leader> + h
---------------------------------------------------------------------------
wk.add({
  silent = false,
  { "<Leader>H", group = "History", icon = "🕒 " },
  { "<Leader>HS", "<CR>q?", icon = " ", desc = "Backward Search History" },
  { "<Leader>Hc", "<CR>q:", icon = " ", desc = "Command History" },
  { "<Leader>Hs", "<CR>q/", icon = " ", desc = "Forward Search History" },
}, opts)

---------------------------------------------------------------------------
-- Cursor
---------------------------------------------------------------------------
local flash = require("flash")
wk.add({
  { "jj", "<ESC>", mode = "i", icon = " ", desc = "Return to NORMAL mode" },
  { "kk", "<ESC>", mode = "i", icon = " ", desc = "Return to NORMAL mode" },

  { "s", function() flash.jump() end,              mode = nxo, icon = " ", desc = "Flash" },
  { "S", function() flash.treesitter() end,        mode = nxo, icon = " ", desc = "Flash Treesitter" },

  { "r", function() flash.remote() end,            mode = o,   icon = " ", desc = "Remote Flash" },
  { "R", function() flash.treesitter_search() end, mode = ox,  icon = " ", desc = "Treesitter Search" },

  { "<C-s>", function() flash.treesitter_search() end, mode = c, icon = " ", desc = "Toggle Flash Search" },
}, opts)

---------------------------------------------------------------------------
-- Search
---------------------------------------------------------------------------
wk.add({
  mode = nx,
  { "#",   "<Plug>(asterisk-#)",   icon = "  ", desc = "Search backward" },
  { "*",   "<Plug>(asterisk-*)",   icon = "  ", desc = "Search forward" },
  { "g#",  "<Plug>(asterisk-g#)",  icon = "  ", desc = "Partial search backward" },
  { "g*",  "<Plug>(asterisk-g*)",  icon = "  ", desc = "Partial Search forward" },
  { "gz#", "<Plug>(asterisk-gz#)", icon = "  ", desc = "Partial search backward (in-place)" },
  { "gz*", "<Plug>(asterisk-gz*)", icon = "  ", desc = "Partial Search forward (in-place)" },

  { "z", group = "Search in-place", icon = " " },
  { "z#", "<Plug>(asterisk-z#)", icon = " ", desc = "Search backward (in-place)" },
  { "z*", "<Plug>(asterisk-z*)", icon = " ", desc = "Search forward (in-place)" },
}, opts)

---------------------------------------------------------------------------
-- 📑  Tab / Buffer / Window
---------------------------------------------------------------------------
local snacks = require("snacks")
wk.add({
  { "[b", "<CMD>bprev<CR>", icon = " ", desc = "Move to prev buffer" },
  { "]b", "<CMD>bnext<CR>", icon = " ", desc = "Move to next buffer" },

  -- Buffer Naigation
  { "<Leader>b", group = "Buffer Navigation", icon = "🖥 " },
  { "<Leader>bb", "<CMD>Telescope buffers<CR>",   icon = " ", desc = "Display buffers list" },
  { "<Leader>bn", "<CMD>BufferLineCycleNext<CR>", icon = " ", desc = "Move to next buffer" },
  { "<Leader>bp", "<CMD>BufferLineCyclePrev<CR>", icon = " ", desc = "Move to prev buffer" },
  { "<Leader>bdc", function() snacks.bufdelete() end,       icon = " ", desc = "Delete current buffer" },
  { "<Leader>bdo", function() snacks.bufdelete.other() end, icon = " ", desc = "Delete other buffers" },

  -- Tab Navigation
  { "[t", "<CMD>tabprevious<CR>", icon = " ", desc = "Move to prev tab" },
  { "]t", "<CMD>tabnext<CR>",     icon = " ", desc = "Move to next tab" },
  { "[1", "<CMD>tabfirst<CR>",    icon = " ", desc = "Move to First tab" },
  { "]9", "<CMD>tablast<CR>",     icon = " ", desc = "Move to Last tab" },

  -- Tab Control via Telescope
  { "<Leader>t", group = "Tab", icon = "📑 " },
  { "<Leader>tc", "<CMD>tabclose<CR>", icon = " ", desc = "Close current tab" },
  { "<Leader>te", ":tabedit<Space>",   icon = " ", desc = "Edit file in new tab" },
  { "<Leader>tn", ":tabnew<Space>",    icon = " ", desc = "Edit file in new tab" },

  -- Window Moving
  { "[w", "<C-w>h", icon = " ", desc = "Move to Left  Window" },
  { "]w", "<C-w>l", icon = " ", desc = "Move to Right Window" },
  { "[W", "<C-w>j", icon = " ", desc = "Move to Above Window" },
  { "]W", "<C-w>k", icon = " ", desc = "Move to Below Window" },

  -- Split Window
  { "<Leader>s", group = "Split Window", icon = "📖 " },
  { "<Leader>sh", ":split<Space>",  icon = " ", desc = "Split window horizontally" },
  { "<Leader>sv", ":vsplit<Space>", icon = " ", desc = "Split window vertically" },
}, opts)

---------------------------------------------------------------------------
-- Line Number
---------------------------------------------------------------------------
local ui = require("utils.ui")
wk.add({
  { ",n", ui.toggle_line_number,     icon = " ", desc = "Toggle Line Number" },
  { ",N", ui.toggle_relative_number, icon = " ", desc = "Toggle Relatieve Number" },
}, opts)

---------------------------------------------------------------------------
-- dial.nvim: Increment/Decrement plugin: <C-a> or <C-x>
---------------------------------------------------------------------------
local map = require("dial.map")
wk.add({
  { "<C-a>",  map.inc_normal(),  icon = " ", desc = "Increment variable" },
  { "<C-x>",  map.dec_normal(),  icon = " ", desc = "Decrement variable" },
  { "g<C-a>", map.inc_gnormal(), icon = " ", desc = "Increment variable" },
  { "g<C-x>", map.dec_gnormal(), icon = " ", desc = "Decrement variable" },

  { "<C-a>",  map.inc_visual(),  mode = "v", icon = " ", desc = "Increment variable" },
  { "<C-x>",  map.dec_visual(),  mode = "v", icon = " ", desc = "Decrement variable" },
  { "g<C-a>", map.inc_gvisual(), mode = "v", icon = " ", desc = "Increment variable" },
  { "g<C-x>", map.dec_gvisual(), mode = "v", icon = " ", desc = "Decrement variable" },
}, opts)

---------------------------------------------------------------------------
-- 🛠  overseer.nvim: Task Runner: <Leader> + o
---------------------------------------------------------------------------
wk.add({
  { "<Leader>o", group = "Task Runner", icon = "✅  " },

  -- Async commands
  { "<Leader>og", "<CMD>cclose | Grep <cword><CR>", icon = " ", desc = "Grep cursor word asynchronously" },
  { "<Leader>om", "<CMD>Make<CR>",                  icon = " ", desc = "Run make asynchronously" },

  -- overseed.nvim commands
  { "<Leader>or", "<CMD>OverseerRun<CR>",         icon = " ", desc = "Run a task from a template" },
  { "<Leader>ol", "<CMD>OverseerRestartLast<CR>", icon = " ", desc = "Restart Last Action" },
  { "<Leader>ot", "<CMD>OverseerToggle<CR>",      icon = " ", desc = "Toggle overseer window" },
  { "<Leader>oa", "<CMD>OverseerTaskAction<CR>",  icon = " ", desc = "Select a task to run an action on" },
  { "<Leader>oq", "<CMD>OverseerQuickAction<CR>", icon = " ", desc = "Run an action on the most recent task" },
}, opts)

---------------------------------------------------------------------------
-- 🔭  Telescope: <Leader> + f
---------------------------------------------------------------------------
-- Disable Telescope keymap for VSCode
if not is_vscode then
  require("utils.telescope")

  wk.add({
    { "<Leader>f", group = "Telescope: Fuzzy Finder", icon = "🔭 " },

    -- Builtin
    { "<Leader>F",  "<CMD>Telescope find_files<CR>",  icon = " ", desc = "Find files in current directory" },
    { "<Leader>fo", "<CMD>Telescope oldfiles<CR>",    icon = " ", desc = "Recently files" },

    -- Grep
    { "<Leader>fg", "<CMD>Telescope live_grep<CR>",   icon = " ", desc = "Live grep with args" },
    { "<Leader>fG", "<CMD>Telescope grep_string<CR>", icon = " ", desc = "Grep string in working directory" },
    { "<Leader>fw", "<CMD>TelescopeSearchCword<CR>",  icon = " ", desc = "grep with cursor word" },
    { "<Leader>fW", "<CMD>TelescopeSearchCWORD<CR>",  icon = " ", desc = "grep with cursor WORD" },

    -- Vim
    { "<Leader>fh", "<CMD>Telescope help_tags<CR>",   icon = " ", desc = "Help via Telescope" },
    { "<Leader>fq", "<CMD>Telescope quickfix<CR>",    icon = " ", desc = "Quickfix list" },
    { "<Leader>fb", "<CMD>Telescope buffers<CR>",     icon = " ", desc = "Buffer list" },
    { "<Leader>fv", "<CMD>Telescope vim_options<CR>", icon = " ", desc = "Vim options" },
    { "<Leader>fR", "<CMD>Telescope registers<CR>",   icon = " ", desc = "Vim Register list" },
    { "<Leader>fj", "<CMD>Telescope jumplist<CR>",    icon = " ", desc = "Vim Jump list" },

    -- history
    { "<Leader>fC", "<CMD>Telescope command_history<CR>", icon = " ", desc = "Command history" },
    { "<Leader>fS", "<CMD>Telescope search_history<CR>",  icon = " ", desc = "Search history" },
    { "<Leader>fr", "<CMD>Telescope resume<CR>",          icon = " ", desc = "Resume previous picker" },

    -- telescope.nvim extensions
    { "<Leader>ff", "<CMD>Telescope frecency<CR>",     icon = " ", desc = "Frecency algorithm Search" },
    { "<C-g>",      "<CMD>Telescope egrepify<CR>",     icon = " ", desc = "Live grep with egrepify" },
    { "<Leader>fs", "<CMD>Telescope luasnip<CR>",      icon = " ", desc = "LuaSnip Browser" },
    { "<Leader>fl", "<CMD>Telescope lazy<CR>",         icon = " ", desc = "lazy.nvim Browser" },
    { "<Leader>ft", "<CMD>TodoTelescope<CR>",          icon = " ", desc = "Display Project ToDo" },

    { "<Leader>fn", function() snacks.notifier.show_history() end, icon = " ", desc = "Notification History" },

    { "<Leader>fd", group = "Telescope DAP Integration", icon = " " },
    { "<Leader>fdC", "<CMD>TelescopeDapCommands<CR>",    icon = " ", desc = "Commands" },
    { "<Leader>fdc", "<CMD>TelescopeDapConfig<CR>",      icon = " ", desc = "Configs" },
    { "<Leader>fdf", "<CMD>TelescopeDapFrames<CR>",      icon = " ", desc = "Frames" },
    { "<Leader>fdl", "<CMD>TelescopeDapBreakpoints<CR>", icon = " ", desc = "Breakpoints" },
    { "<Leader>fdv", "<CMD>TelescopeDapVariables<CR>",   icon = " ", desc = "Variables" },

    { "<Leader>fc",  "<CMD>TelescopeChezmoiFind<CR>",        icon = " ", desc = "Search chezmoi files" },
  }, opts)
end

---------------------------------------------------------------------------
-- LSP: Language Server Protocol: <Leader> + l
---------------------------------------------------------------------------
wk.add({
  { "K", "<NOP" },
  { "<Leader>P", "<CMD>Lazy<CR>",                        icon = " ", desc = "Open lazy.nvim Window" },
  { "<Leader>M", "<CMD>Mason<CR>",                       icon = " ", desc = "Open mason.nvim Window" },
  { "g[",  "<CMD>Lspsaga diagnostic_jump_prev<CR>",      icon = " ", desc = "Go to prev diagnostics" },
  { "g]",  "<CMD>Lspsaga diagnostic_jump_next<CR>",      icon = " ", desc = "Go to next diagnostics" },
  { "go",  "<CMD>Lspsaga outline<CR>",                   icon = " ", desc = "Code outline" },
  { "gn",  "<CMD>Lspsaga rename<CR>",                    icon = " ", desc = "Rename" },
  { "gci", "<CMD>Lspsaga incoming_calls<CR>",            icon = " ", desc = "Call incoming hierarchy" },
  { "gco", "<CMD>Lspsaga outcoming_calls<CR>",           icon = " ", desc = "Call outcoming hierarchy" },

  { "ga", "<CMD>Lspsaga code_action<CR>", mode = nv, icon = " ", desc = "Code Action" },
}, opts)

--------------------------------------------------
---- 🚦  Keymap for LSP via Telescope
--------------------------------------------------
wk.add({
  { "<Leader>l", group = "LSP", icon = "🚦 " },
  { "<Leader>li", "<CMD>LspInfo<CR>",                             icon = " ", desc = "Display LSP Info" },
  { "<Leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",      icon = " ", desc = "Document Symbol" },
}, opts)

---------------------------------------------------------------------------
-- 🐛  DAP: Debugger Adapter Protocol: <Leader> + d
---------------------------------------------------------------------------
require("utils.dap")

wk.add({
  -- DAP keymap like VSCode
  { "<F5>",    "<CMD>DapContinue<CR>",  icon = "", desc = "Continue Process" },
  { "<S-F5>",  "<CMD>DapTerminate<CR>", icon = "□", desc = "Terminate Process" },
  { "<F10>",   "<CMD>DapStepOver<CR>",  icon = "", desc = "Step Over" },
  { "<F11>",   "<CMD>DapStepInto<CR>",  icon = "", desc = "Step Into" },
  { "<S-F11>", "<CMD>DapStepOut<CR>",   icon = "", desc = "Step Out" },

  -- Debugger Control
  { "<Leader>d", group = "Debugger", icon = "🐛 " },
  { "<Leader>db", "<CMD>DapToggleBreakpoint<CR>", icon = " ", desc = "Toggle DAP Breakpoints" },
  { "<Leader>dc", "<CMD>DapContinue<CR>",         icon = " ", desc = "Continue Process" },
  { "<Leader>do", "<CMD>DapStepOver<CR>",         icon = " ", desc = "Step Over" },
  { "<Leader>di", "<CMD>DapStepInto<CR>",         icon = " ", desc = "Step Into" },
  { "<Leader>dO", "<CMD>DapStepOut<CR>",          icon = " ", desc = "Step Out" },
  { "<Leader>dB", "<CMD>DapStepBack<CR>",         icon = " ", desc = "Step Back" },
  { "<Leader>dt", "<CMD>DapTerminate<CR>",        icon = "□ ", desc = "Terminate Process" },

  { "<Leader>dd", "<CMD>DapToggleUI<CR>",    icon = ":", desc = "Toggle Debugger UI" },
  { "<Leader>dp", "<CMD>DapPreview<CR>",     icon = " ", desc = "DAP Preview" },
  { "<Leader>dh", "<CMD>DapHover<CR>",       icon = " ", desc = "Hover DAP widgets" },
  { "<Leader>dl", "<CMD>DapLog<CR>",         icon = "󰌱 ", desc = "Open DAP log" },
  { "<Leader>dL", "<CMD>DapRunLast<CR>",     icon = "↻ ", desc = "Run Last" },
  { "<Leader>ds", "<CMD>DapFloatScope<CR>",  icon = " ", desc = "Float scopes" },
  { "<Leader>dS", "<CMD>DapFloatStacks<CR>", icon = " ", desc = "Float stacks" },
  { "<Leader>dw", "<CMD>DapFloatWatch<CR>",  icon = " ", desc = "Float watches" },
}, opts)

---------------------------------------------------------------------------
-- Git: <Leader> + g
---------------------------------------------------------------------------
require("utils.git")

wk.add({
  { "<Leader>g", group = "Git Integration", icon = " " },
  { "<Leader>gb", "<CMD>GitBlameLine<CR>",     icon = " ", desc = "Git Blame Line" },
  { "<Leader>gg", "<CMD>ToggleLazygit<CR>",    icon = " ", desc = "Toggle lazygit w/ terminal" },
  { "<Leader>gh", "<CMD>ToggleGitHubDash<CR>", icon = " ", desc = "Toggle gh dash w/ terminal" },
}, opts)

---------------------------------------------------------------------------
-- 🤖  AI Interaction: <Leader> + a
---------------------------------------------------------------------------
if not is_vscode then
  require("utils.ai")

  -- avante.nvim
  wk.add({
    mode = nv,
    { "<Leader>a", group = "avante.nvim", icon = "🤖 " },
    { "<Leader>at", "<CMD>AvanteToggle<CR>",         icon = "", desc = "Toggle Avante Chat" },
    { "<Leader>aa", "<CMD>AvanteAsk<CR>",            icon = "", desc = "Avante Ask" },
    { "<Leader>ac", "<CMD>AvanteChat<CR>",           icon = "", desc = "Avante Chat" },
    { "<Leader>ae", "<CMD>AvanteEdit<CR>",           icon = "", desc = "Avante Editor" },
    { "<Leader>ar", "<CMD>AvanteRefresh<CR>",        icon = "", desc = "Refresh Avante Window" },

    { "<Leader>as", ":AvanteSwitchProvider<Space>",  icon = "", desc = "Switch Avante Provider" },
    { "<Leader>aS", "<CMD>AvanteSwitchLocalLLM<CR>", icon = "", desc = "Switch Local Language Model" },
  }, opts)
end

---------------------------------------------------------------------------
---File Explorer: <Leader> + e
-----------------------------------------------------------------------
if not is_vscode then
  require("utils.explorer")

  wk.add({
    mode = nt,
    { "<Leader>e", group = "oil.nvim", icon = "📁 " },
    { "<Leader>eh", "<CMD>OilToggleHidden<CR>",    icon = " ", desc = "Toggle Hidden files" },
    { "<Leader>ef", "<CMD>OilToggleFloat<CR>",     icon = " ", desc = "Explore parent directory" },
    { "<Leader>er", "<CMD>OilToggleFloatRoot<CR>", icon = " ", desc = "Explore project root" },
    { "<Leader>ed", ":OilToggleFloatDir<Space>",   icon = " ", desc = "Explore directory with arg" },
  }, opts)
end

---------------------------------------------------------------------------
-- Others:
---------------------------------------------------------------------------

if not is_vscode then
  require("utils.terminal")
  -- Toggle Plugin
  wk.add({
    { ",/", "<CMD>HlSearchLensToggle<CR>", icon = " ", desc = "Toggle Hlsearch lens"  },
    { ",m", "<CMD>TSJToggle<CR>",          icon = " ", desc = "Toggle node under cursor" },
    { ",c", "<CMD>ColorizerToggle<CR>",    icon = " ", desc = "Toggle Colorizer" },

    { ",x", "<CMD>Trouble diagnostics toggle<CR>", icon = " ", desc = "Toggle Diagnostics" },
    { ",X", "<CMD>Trouble symbols toggle<CR>",     icon = " ", desc = "Toggle Symbols" },
    { ",q", "<CMD>Trouble qflist toggle<CR>",      icon = " ", desc = "Toggle Quickfix list" },

    { ",t", "<CMD>ToggleTerm<CR>",   mode = nt, icon = " ", desc = "Toggle Terminal" },
    { ",b", "<CMD>ToggleBottom<CR>", mode = nt, icon = " ", desc = "Toggle Process Monitor w/ Terminal" },
  }, opts)
end
