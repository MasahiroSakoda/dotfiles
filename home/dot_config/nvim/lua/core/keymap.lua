---------------------------------------------------------------------------
-- Binding Rules:
-- Vim由来のコマンドを割り当てる場合の修飾キーは"<Space> + h/H/b/t/s"
-- h: history, H: Help, b: Buffer, t: Tab, s: Split Window
-- Telescopeの割り当て修飾キーは"<Space> + f"
-- LSPの割り当て修飾キー: "<Space> + l"
-- DAPの割り当て修飾キー: "<Space> + d"
-- Gitの割り当て修飾キー: "<Space> + g"
---------------------------------------------------------------------------
local keymap = vim.keymap.set -- instead of nvim_keymap_set()
local is_vscode = vim.g.vscode
local opts = { noremap = true }
local nv, nx, nt, nxo, o, ox, c = {"n", "v"}, {"n", "x"}, {"n", "t"}, {"n", "x", "o"}, {"o"}, {"o", "x"}, {"c"}

local ok, wk = pcall(require, "which-key")
if not ok then vim.notify("Failed loading " .. "which-key", vim.log.levels.WARN) end

---------------------------------------------------------------------------
-- which-key commands
---------------------------------------------------------------------------
wk.add({
  { "<Leader>w", group = "Which-Key", icon = "⌨️ " },
  { "<Leader>wk", "<CMD>WhichKey<CR>",            icon = " ", desc = "All maps" },
  { "<Leader>wl", "<CMD>WhichKey <Leader><CR>",   icon = " ", desc = "All <Leader> maps" },
  { "<Leader>wv", "<CMD>WhichKey <Leader> v<CR>", icon = " ", desc = "All <Leader> maps for VISUAL mode" },
}, opts)

---------------------------------------------------------------------------
-- ❓ Help: <Leader>+H
---------------------------------------------------------------------------
vim.cmd [[
  cnoreabbrev H vert help
  cnoreabbrev HR vert bo h
]]

wk.add({
  { "<Leader>h", group = "Help", icon = "❓ " },
  { "<Leader>hh", ":horizontal above help<Space>",    icon = " ", desc = "Open Help page above buffer" },
  { "<Leader>hv", ":vertical belowright help<Space>", icon = " ", desc = "Open Help page right side" },
}, opts)

---------------------------------------------------------------------------
-- 🕒  History: <Leader>+h
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
-- Insert Modeでjj/jk ESC
keymap("i", "jj", "<ESC>")

-- flash.nvim
wk.add({
  mode = nxo,
  { "s", "<CMD>lua require'flash'.jump()<CR>",       icon = " ", desc = "Flash" },
  { "S", "<CMD>lua require'flash'.treesitter()<CR>", icon = " ", desc = "Flash Treesitter" },
}, opts)

wk.add({
  mode = o,
  { "r", "<CMD>lua require'flash'.remote()<CR>", icon = " ", desc = "Remote Flash" }
}, opts)

wk.add({
  mode = ox,
  { "r", "<CMD>lua require'flash'.treesitter_search()<CR>", icon = " ", desc = "Treesitter Search" }
}, opts)

wk.add({
  mode = c,
  { "r", "<CMD>lua require'flash'.treesitter_search()<CR>", icon = " ", desc = "Toggle Flash Search" }
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
wk.add({
  { "[b", "<CMD>bprev<CR>", icon = " ", desc = "Move to prev buffer" },
  { "]b", "<CMD>bnext<CR>", icon = " ", desc = "Move to next buffer" },
}, opts)

-- Buffer Naigation
wk.add({
  { "<Leader>b", group = "Buffer Navigation", icon = "🖥 " },
  { "<Leader>bb", "<CMD>Telescope buffers<CR>",   icon = " ", desc = "Display buffers list" },
  { "<Leader>bd", "<CMD>bdelete<CR>",             icon = " ", desc = "Delete buffer" },
  { "<Leader>bn", "<CMD>BufferLineCycleNext<CR>", icon = " ", desc = "Move to next buffer" },
  { "<Leader>bp", "<CMD>BufferLineCyclePrev<CR>", icon = " ", desc = "Move to prev buffer" },
}, opts)

-- Tab Navigation
wk.add({
  { "[t", "<CMD>tabprevious<CR>", icon = " ", desc = "Move to prev tab" },
  { "]t", "<CMD>tabnext<CR>",     icon = " ", desc = "Move to next tab" },
  { "[1", "<CMD>tabfirst<CR>",    icon = " ", desc = "Move to First tab" },
  { "]9", "<CMD>tablast<CR>",     icon = " ", desc = "Move to Last tab" },
}, opts)

-- Tab Control via Telescope
wk.add({
    { "<Leader>t", group = "Tab", icon = "📑 " },
    { "<Leader>tc", "<CMD>tabclose<CR>", icon = " ", desc = "Close current tab" },
    { "<Leader>te", ":tabedit<Space>",   icon = " ", desc = "Edit file in new tab" },
    { "<Leader>tn", ":tabnew<Space>",    icon = " ", desc = "Edit file in new tab" },
}, opts)

-- Window Moving
wk.add({
  { "[w", "<C-w>h", icon = " ", desc = "Move to Left  Window" },
  { "]w", "<C-w>l", icon = " ", desc = "Move to Right Window" },
  { "[W", "<C-w>j", icon = " ", desc = "Move to Above Window" },
  { "]W", "<C-w>k", icon = " ", desc = "Move to Below Window" },
})

-- Split Window
wk.add({
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
-- dial.nvim: Increment/Decrement plugin
---------------------------------------------------------------------------
local map = require("dial.map")
wk.add({
  { "<C-a>",  map.inc_normal(),  icon = " ", desc = "Increment variable" },
  { "<C-x>",  map.dec_normal(),  icon = " ", desc = "Decrement variable" },
  { "g<C-a>", map.inc_gnormal(), icon = " ", desc = "Increment variable" },
  { "g<C-x>", map.dec_gnormal(), icon = " ", desc = "Decrement variable" },
}, opts)

wk.add({
  mode = "v",
  { "<C-a>",  map.inc_visual(),  icon = " ", desc = "Increment variable" },
  { "<C-x>",  map.dec_visual(),  icon = " ", desc = "Decrement variable" },
  { "g<C-a>", map.inc_gvisual(), icon = " ", desc = "Increment variable" },
  { "g<C-x>", map.dec_gvisual(), icon = " ", desc = "Decrement variable" },
}, opts)

---------------------------------------------------------------------------
-- Quickfix
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- 🛠  overseer.nvim: Task Runner
---------------------------------------------------------------------------
wk.add({
  { "<Leader>rr", "<CMD>OverseerRun<CR>",    icon = " ", desc = "Run a task from a template" },
  { "<Leader>rt", "<CMD>OverseerToggle<CR>", icon = " ", desc = "Toggle overseer window" },
}, opts)

---------------------------------------------------------------------------
-- 🔭  Telescope
---------------------------------------------------------------------------
-- Disable Telescope keymap for VSCode
if not is_vscode then

  wk.add({
    { "<Leader>f", group = "Telescope: Fuzzy Finder", icon = "🔭 " },
    { "<C-g>", "<CMD>Telescope egrepify<CR>",            icon = " ", desc = "Live grep with egrepify" },
    { "<Leader><C-g>", "<CMD>Telescope grep_string<CR>", icon = " ", desc = "Grep string in working directory" },
    { "<Leader>F", "<CMD>Telescope find_files<CR>",      icon = " ", desc = "Find files in current directory" },
    { "<Leader>fL", "<CMD>Telescope luasnip<CR>",        icon = " ", desc = "LuaSnip Browser" },
    { "<Leader>fb", "<CMD>Telescope file_browser<CR>",   icon = " ", desc = "File Browser" },


    { "<Leader>fd", group = "Telescope DAP Integration", icon = " " },
    {
      "<Leader>fdC",
      "<CMD>lua require'telescope'.extensinos.dap.commands()<CR>",
      icon = " ",
      desc = "Commands",
    },
    {
      "<Leader>fdc",
      "<CMD>lua require'telescope'.extensinos.dap.configurations()<CR>",
      icon = " ",
      desc = "Configs",
    },
    {
      "<Leader>fdf",
      "<CMD>lua require'telescope'.extensinos.dap.frames()<CR>",
      icon = " ",
      desc = "Frames",
    },
    {
      "<Leader>fdl",
      "<CMD>lua require'telescope'.extensinos.dap.list_breakpoints()<CR>",
      icon = " ",
      desc = "Breakpoints",
    },
    {
      "<Leader>fdv",
      "<CMD>lua require'telescope'.extensinos.dap.variables()<CR>",
      icon = " ",
      desc = "Variables",
    },
    {
      "<Leader>fc",
      ":lua require'telescope'.extensions.chezmoi.find_files()<CR>",
      icon = " ",
      desc = "Search chezmoi files",
    },

    { "<Leader>ff", "<CMD>Telescope frecency<CR>",  icon = " ", desc = "Frecency algorithm Search" },
    { "<Leader>fg", "<CMD>Telescope live_grep<CR>", icon = " ", desc = "Live grep with args" },
    { "<Leader>fh", "<CMD>Telescope help_tags<CR>", icon = " ", desc = "Help via Telescope" },
    { "<Leader>fl", "<CMD>Telescope lazy<CR>",      icon = " ", desc = "lazy.nvim Browser" },
    { "<Leader>fn", "<CMD>Telescope notify<CR>",    icon = " ", desc = "Notification History" },
    { "<Leader>fo", "<CMD>Telescope oldfiles<CR>",  icon = " ", desc = "Recently files" },
    { "<Leader>fq", "<CMD>Telescope quickfix<CR>",  icon = " ", desc = "Display Quickfix list" },
    { "<Leader>fr", "<CMD>Telescope resume<CR>",    icon = " ", desc = "Resume previous picker" },
    { "<Leader>ft", "<CMD>TodoTelescope<CR>",       icon = " ", desc = "Display Project ToDo" },
  }, opts)

end

---------------------------------------------------------------------------
-- LSP: Language Server Protocol
---------------------------------------------------------------------------
wk.add({
  { "K", "<NOP" },
  { "<Leader>P", "<CMD>Lazy<CR>",                        icon = " ", desc = "Open lazy.nvim Window" },
  { "<Leader>M", "<CMD>Mason<CR>",                       icon = " ", desc = "Open mason.nvim Window" },
  { "K",   "<CMD>lua vim.lsp.buf.hover()<CR>",           icon = " ", desc = "Hover Documentation" },
  { "gd",  "<CMD>lua vim.lsp.buf.definition()<CR>",      icon = " ", desc = "Go to Definition" },
  { "gD",  "<CMD>lua vim.lsp.buf.type_definition()<CR>", icon = " ", desc = "Go to Type Definition" },
  { "gi",  "<CMD>lua vim.lsp.buf.implementation()<CR>",  icon = " ", desc = "Go to implementation" },
  { "gr",  "<CMD>lua vim.lsp.buf.references()<CR>",      icon = " ", desc = "Go to references" },
  { "g[",  "<CMD>Lspsaga diagnostic_jump_prev<CR>",      icon = " ", desc = "Go to prev diagnostics" },
  { "g]",  "<CMD>Lspsaga diagnostic_jump_next<CR>",      icon = " ", desc = "Go to next diagnostics" },
  { "go",  "<CMD>Lspsaga outline<CR>",                   icon = " ", desc = "Code outline" },
  { "gn",  "<CMD>Lspsaga rename<CR>",                    icon = " ", desc = "Rename" },
  { "gci", "<CMD>Lspsaga incoming_calls<CR>",            icon = " ", desc = "Call incoming hierarchy" },
  { "gco", "<CMD>Lspsaga outcoming_calls<CR>",           icon = " ", desc = "Call outcoming hierarchy" },
}, opts)

wk.add({
  mode = nv,
  { "ga", "<CMD>Lspsaga code_action<CR>", desc = "  Code Action" },
}, opts)

--------------------------------------------------
---- 🚦  Keymap for LSP via Telescope
--------------------------------------------------
wk.add({
  { "<Leader>l", group = "LSP via Telescope", icon = "🚦 " },
  { "<Leader>lA", "<CMD>Telescope lsp_range_code_actions<CR>",    icon = " ", desc = "Range Code Actions" },
  { "<Leader>lD", "<CMD>Telescope diagnostics<CR>",               icon = " ", desc = "Show diagnostic" },
  { "<Leader>lI", "<CMD>Telescope lsp_implementation<CR>",        icon = " ", desc = "Implementation" },
  { "<Leader>lg", "<CMD>Telescope lsp_document_diagnostics<CR>",  icon = " ", desc = "Document Diagnostics" },
  { "<Leader>li", "<CMD>LspInfo<CR>",                             icon = " ", desc = "Display LSP Info" },
  { "<Leader>lo", "<CMD>Telescope lsp_workspace_diagnostics<CR>", icon = " ", desc = "Workspace Diagnostics" },
  { "<Leader>lr", "<CMD>Telescope lsp_references<CR>",            icon = " ", desc = "References" },
  { "<Leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",      icon = " ", desc = "Document Symbol" },
}, opts)

---------------------------------------------------------------------------
-- 🐛  DAP: Debugger Adapter Protocol
---------------------------------------------------------------------------
-- DAP keymap like VSCode
wk.add({
  { "<F5>",    "<CMD>DapContinue<CR>",  icon = "", desc = "Continue Process" },
  { "<S-F5>",  "<CMD>DapTerminate<CR>", icon = "□", desc = "Terminate Process" },
  { "<F10>",   "<CMD>DapStepOver<CR>",  icon = "", desc = "Step Over" },
  { "<F11>",   "<CMD>DapStepInto<CR>",  icon = "", desc = "Step Into" },
  { "<S-F11>", "<CMD>DapStepOut<CR>",   icon = "", desc = "Step Out" },
}, opts)

-- Debugger Control
wk.add({
  { "<Leader>d", group = "Debugger", icon = "🐛 " },
  { "<Leader>db", "<CMD>DapToggleBreakpoint<CR>", icon = " ", desc = "Toggle DAP Breakpoints" },
  { "<Leader>dc", "<CMD>DapContinue<CR>",         icon = " ", desc = "Continue Process" },
  { "<Leader>do", "<CMD>DapStepOver<CR>",         icon = " ", desc = "Step Over" },
  { "<Leader>di", "<CMD>DapStepInto<CR>",         icon = " ", desc = "Step Into" },
  { "<Leader>dO", "<CMD>DapStepOut<CR>",          icon = " ", desc = "Step Out" },
  { "<Leader>dB", "<CMD>DapStepBack<CR>",         icon = " ", desc = "Step Back" },
  { "<Leader>dt", "<CMD>DapTerminate<CR>",        icon = "□ ", desc = "Terminate Process" },

  { "<Leader>dd", "<CMD>lua require'utils.dap'.toggle_ui()<CR>",     icon = ":", desc = "Toggle Debugger UI" },
  { "<Leader>dp", "<CMD>lua require'utils.dap'.preview()<CR>",       icon = " ", desc = "DAP Preview" },
  { "<Leader>dh", "<CMD>lua require'utils.dap'.hover()<CR>",         icon = " ", desc = "Hover DAP widgets" },
  { "<Leader>dl", "<CMD>lua require'utils.dap'.open_log()<CR>",      icon = "󰌱 ", desc = "Open DAP log" },
  { "<Leader>dL", "<CMD>lua require'dap'.run_last()<CR>",            icon = "↻ ", desc = "Run Last" },
  { "<Leader>ds", "<CMD>lua require'utils.dap'.float_scopes()<CR>",  icon = " ", desc = "Float scopes" },
  { "<Leader>dS", "<CMD>lua require'utils.dap'.float_stacks()<CR>",  icon = " ", desc = "Float stacks" },
  { "<Leader>dw", "<CMD>lua require'utils.dap'.float_watches()<CR>", icon = " ", desc = "Float watches" },
}, opts)

---------------------------------------------------------------------------
-- Diffview
---------------------------------------------------------------------------
wk.add({
  { "<Leader>g", group = "Diffview", icon = "🧾 " },
  { "<Leader>gO", ":DiffviewOpen<Space>",         icon = "a", desc = "Open Diffview with args" },
  { "<Leader>gf", "<CMD>DiffviewFocusFiles<CR>",  icon = " ", desc = "Focus to the file panel" },
  { "<Leader>gh", ":DiffviewFileHistory<Space>",  icon = " ", desc = "Open file history" },
  { "<Leader>go", "<CMD>DiffviewOpen<CR>",        icon = "a", desc = "Open Diffview" },
  { "<Leader>gq", "<CMD>DiffviewClose<CR>",       icon = " ", desc = "Close Diffview" },
  { "<Leader>gr", "<CMD>DiffviewRefresh<CR>",     icon = " ", desc = "Refresh Diffview" },
  { "<Leader>gt", "<CMD>DiffviewToggleFiles<CR>", icon = " ", desc = "Toggle file panels" },
}, opts)

---------------------------------------------------------------------------
-- 🤖  AI Interaction
---------------------------------------------------------------------------
if not is_vscode then

  -- ChatGPT.nvim
  wk.add({
    mode = nv,
    { "<Leader>a", group = "ChatGPT", icon = "🤖 " },
    { "<Leader>ai", "<CMD>ChatGPT<CR>",                     icon = " ", desc = "Open Interactive Window" },
    { "<Leader>aa", "<CMD>ChatGPTActAs<CR>",                icon = " ", desc = "Awesome Prompts" },
    { "<Leader>ac", "<CMD>ChatGPTCompleteCode<CR>",         icon = "",  desc = "Complete code" },
    { "<Leader>ae", "<CMD>ChatGPTEditWithInstructions<CR>", icon = "",  desc = "Edit with instructions" },

    { "<Leader>ag", "<CMD>ChatGPTRun grammar_correction<CR>", icon = " ", desc = "Grammar Correction" },
    { "<Leader>as", "<CMD>ChatGPTRun summarize<CR>",          icon = " ", desc = "Summarize text" },
    { "<Leader>at", "<CMD>ChatGPTRun translate<CR>",          icon = " ", desc = "translate text" },
    { "<Leader>ak", "<CMD>ChatGPTRun keywords<CR>",           icon = " ", desc = "Keyword Generation" },
    { "<Leader>ad", "<CMD>ChatGPTRun docstring<CR>",          icon = " ", desc = "Create docstring" },
    { "<Leader>af", "<CMD>ChatGPTRun fix_bugs<CR>",           icon = " ", desc = "Fix bugs" },
    { "<Leader>aE", "<CMD>ChatGPTRun explain_code<CR>",       icon = " ", desc = "Explain Code" },
    { "<Leader>ao", "<CMD>ChatGPTRun optimize_code<CR>",      icon = " ", desc = "Optimize Code" },
    { "<Leader>ar", "<CMD>ChatGPTRun roxygen_edit<CR>",       icon = " ", desc = "Roxygen Edit" },
  }, opts)

end

---------------------------------------------------------------------------
-- obsidian.nvim
---------------------------------------------------------------------------
wk.add({
  { "<Leader>o", group = "Obsidian integration",  icon = "📝" },
  { "<Leader>ob", "<CMD>ObsidianBacklinks<CR>",   icon = " ", desc = "Get References To Current" },
  { "<Leader>od", "<CMD>ObsidianDailies<CR>",     icon = " ", desc = "Open Daily Notes" },
  { "<Leader>of", "<CMD>ObsidianFollowLink<CR>",  icon = " ", desc = "Go To Link Under Cursor" },
  { "<Leader>og", "<CMD>ObsidianSearch<CR>",      icon = " ", desc = "Grep Search notes" },
  { "<Leader>on", "<CMD>ObsidianNew<CR>",         icon = " ", desc = "Create New Note" },
  { "<Leader>oo", "<CMD>ObsidianOpen<CR>",        icon = " ", desc = "Open in Obsidian.app" },
  { "<Leader>os", "<CMD>ObsidianQuickSwitch<CR>", icon = " ", desc = "Quick Switch" },
  { "<Leader>ot", "<CMD>ObsidianTemplate<CR>",    icon = " ", desc = "Insert Obsidian Template" },
}, opts)

---------------------------------------------------------------------------
-- Others
---------------------------------------------------------------------------
-- Toggle Plugin
wk.add({
  { ",f", "<CMD>Neotree toggle<CR>",     icon = " ", desc = "Toggle NeoTree" },
  { ",s", "<CMD>ScrollbarToggle<CR>",    icon = " ", desc = "Toggle Scrollbar" },
  { ",/", "<CMD>HlSearchLensToggle<CR>", icon = " ", desc = "Toggle Hlsearch lens"  },
  { ",m", "<CMD>TSJToggle<CR>",          icon = " ", desc = "Toggle node under cursor" },
  { ",c", "<CMD>ColorizerToggle<CR>",    icon = " ", desc = "Toggle Colorizer" },

  { ",x", "<CMD>Trouble diagnostics toggle<CR>", icon = " ", desc = "Toggle Diagnostics" },
  { ",s", "<CMD>Trouble symbols toggle<CR>",     icon = " ", desc = "Toggle Symbols" },
  { ",q", "<CMD>Trouble qflist toggle<CR>",      icon = " ", desc = "Toggle Quickfix list" },
  { ",d", "<CMD>lua require'utils.lsp'.toggle_diagnostics<CR>", icon = " ", desc = "Toggle Diagnostic" },
}, opts)

wk.add({
  mode = nt,
  { ",t", "<CMD>ToggleTerm<CR>", icon = " ", desc = "Toggle Terminal" },
}, opts)
