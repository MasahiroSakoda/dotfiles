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
local opts = { noremap = true, silent = true }
local nv, nx, nt = { "n", "v" }, { "n", "x" }, { "n", "t" }

local ok, wk = pcall(require, "which-key")
if not ok then vim.notify("Failed loading " .. "which-key", vim.log.levels.WARN) end

keymap("n", "<Leader>e", ':edit<Space>', { desc = "   Edit" })

---------------------------------------------------------------------------
-- which-key commands
---------------------------------------------------------------------------
wk.register({
  mode = "n",
  silent = false,
  ["<Leader>w"]  = { name = "⌨️   Which-Key" },
  ["<Leader>wk"] = { "<CMD>WhichKey<CR>",            "   Show all mappings" },
  ["<Leader>wl"] = { "<CMD>WhichKey <Leader><CR>",   "   Show all <Leader> mappings" },
  ["<Leader>wv"] = { "<CMD>WhichKey <Leader> v<CR>", "   Show all <Leader> mappings for VISUAL mode" },
})

---------------------------------------------------------------------------
-- ❓ Help: <Leader>+H
---------------------------------------------------------------------------
vim.cmd [[
  cnoreabbrev H vert help
  cnoreabbrev HR vert bo h
]]

wk.register({
  mode    = "n",
  ["<Leader>h"]  = { name = "❓  Help"},
  ["<Leader>hv"] = { ":vertical belowright help<Space>", "   Open Help page right side" },
  ["<Leader>hh"] = { ":horizontal above help<Space>",    "   Open Help page above current buffer" },
}, opts)

---------------------------------------------------------------------------
-- 🕒  History: <Leader>+h
---------------------------------------------------------------------------
wk.register({
  mode    = "n",
  silent = false,
  ["<Leader>H"]  = { name = "🕒  History" },
  ["<Leader>Hc"] = { "<CR>q:", "  Command History" },
  ["<Leader>Hs"] = { "<CR>q/", "  Forward Search History" },
  ["<Leader>HS"] = { "<CR>q?", "  Backward Search History" },
})

---------------------------------------------------------------------------
-- Cursor
---------------------------------------------------------------------------
-- Insert Modeでjj/jk ESC
keymap("i", "jj", "<ESC>")

-- flash.nvim
local nxo = { "n", "x", "o" }
keymap(nxo, "s", "<CMD>lua require'flash'.jump()<CR>",       { desc = "  Flash" })
keymap(nxo, "S", "<CMD>lua require'flash'.treesitter()<CR>", { desc = "  Flash Treesitter" })

keymap({ "o" },      "r", "<CMD>lua require'flash'.remote()<CR>",            { desc = "  Remote Flash" })
keymap({ "o", "x" }, "R", "<CMD>lua require'flash'.treesitter_search()<CR>", { desc = "  Treesitter Search" })
keymap({ "c" },  "<C-s>", "<CMD>lua require'flash'.toggle()<CR>",            { desc = "  Toggle Flash Search" })

---------------------------------------------------------------------------
-- Search
---------------------------------------------------------------------------
wk.register({
  ["*"]   = { "<Plug>(asterisk-*)",   "  Search forward" },
  ["#"]   = { "<Plug>(asterisk-#)",   "  Search backward" },
  ["g*"]  = { "<Plug>(asterisk-g*)",  "  Partial Search forward" },
  ["g#"]  = { "<Plug>(asterisk-g#)",  "  Partial search backward" },
  ["gz*"] = { "<Plug>(asterisk-gz*)", "  Partial Search forward (in-place)" },
  ["gz#"] = { "<Plug>(asterisk-gz#)", "  Partial search backward (in-place)" },
  ["z"]   = { name = "   Search in-place" },
  ["z*"]  = { "<Plug>(asterisk-z*)",  "  Search forward (in-place)" },
  ["z#"]  = { "<Plug>(asterisk-z#)",  "  Search backward (in-place)" },
}, nx)

---------------------------------------------------------------------------
-- 📑  Tab / Buffer / Window
---------------------------------------------------------------------------
keymap("n", "[b", "<CMD>bprev<CR>", { desc = "  Move to prev buffer" })
keymap("n", "]b", "<CMD>bnext<CR>", { desc = "  Move to next buffer" })

-- Buffer Naigation
wk.register({
  mode   = "n",
  ["<Leader>b"]  = { name = "🖥  Buffer Navigation" },
  ["<Leader>bb"] = { "<CMD>Telescope buffers<CR>",   "   Display buffers list" },
  ["<Leader>bp"] = { "<CMD>BufferLineCyclePrev<CR>", "   Move to prev buffer" },
  ["<Leader>bn"] = { "<CMD>BufferLineCycleNext<CR>", "   Move to next buffer" },
  ["<Leader>bd"] = { "<CMD>bdelete<CR>",             "   Delete buffer" },
}, opts)

-- Tab Navigation
keymap("n", "[t", "<CMD>tabprevious<CR>", { desc = "   Move to prev tab" })
keymap("n", "]t", "<CMD>tabnext<CR>",     { desc = "   Move to next tab" })
keymap("n", "[1", "<CMD>tabfirst<CR>",    { desc = "   Move to First tab" })
keymap("n", "]9", "<CMD>tablast<CR>",     { desc = "   Move to Last tab"})

-- Tab Control via Telescope
wk.register({
  mode    = "n",
  ["<Leader>t"]  = { name = "📑  Tab" },
  ["<Leader>te"] = { ":tabedit<Space>", "   Edit file in new tab" },
  ["<Leader>tn"] = { ":tabnew<Space>",  "   Edit file in new tab" },
  ["<Leader>tc"] = { "<CMD>tabclose<CR>",   "   Close current tab" },
}, opts)

-- Window Moving
keymap("n", "[w", "<C-w>h", { desc = "   Move to Left  Window" })
keymap("n", "]w", "<C-w>l", { desc = "   Move to Right Window" })
keymap("n", "]W", "<C-w>j", { desc = "   Move to Above Window" })
keymap("n", "[W", "<C-w>k", { desc = "   Move to Below Window" })

-- Split Window
wk.register({
  mode    = "n",
  ["<Leader>s"]  = { name = "📖  Split Window" },
  ["<Leader>sh"] = { ":split<Space>",  "   Split window horizontally" },
  ["<Leader>sv"] = { ":vsplit<Space>", "   Split window vertically" },
}, opts)

---------------------------------------------------------------------------
-- Line Number
---------------------------------------------------------------------------
local ui = require("utils.ui")
keymap("n", ",n", ui.toggle_line_number,     { desc = "   Toggle Line Number" })
keymap("n", ",N", ui.toggle_relative_number, { desc = "   Toggle Relatieve Number" })

---------------------------------------------------------------------------
-- dial.nvim: Increment/Decrement plugin
---------------------------------------------------------------------------
local map = require("dial.map")
keymap("n", "<C-a>",  map.inc_normal(),  { desc = "   Increment variable" })
keymap("n", "<C-a>",  map.inc_normal(),  { desc = "   Decrement variable" })
keymap("n", "g<C-x>", map.dec_gnormal(), { desc = "   Increment variable" })
keymap("n", "g<C-x>", map.dec_gnormal(), { desc = "   Decrement variable" })

keymap("v", "<C-a>",  map.inc_visual(),  { desc = "   Increment variable" })
keymap("v", "<C-a>",  map.inc_visual(),  { desc = "   Decrement variable" })
keymap("v", "g<C-x>", map.dec_gvisual(), { desc = "   Increment variable" })
keymap("v", "g<C-x>", map.dec_gvisual(), { desc = "   Decrement variable" })

---------------------------------------------------------------------------
-- Quickfix
---------------------------------------------------------------------------
keymap("n", "<C-p>", "<Nop>")

wk.register({
  mode   = "n",
  silent = true,
  [",q"]    = { "<CMD>TroubleToggle quickfix<CR>",              "   Toggle Quickfix list" },
  ["[q"]    = { "<CMD>lua require'utils.trouble'.prev()<CR>zz", "   Prev trouble / quickfix item" },
  ["]q"]    = { "<CMD>lua require'utils.trouble'.next()<CR>zz", "   Next trouble / quickfix item" },
  ["<C-p>"] = { "<CMD>lua require'utils.trouble'.prev()<CR>",   "   Prev trouble / quickfix item" },
  ["<C-n>"] = { "<CMD>lua require'utils.trouble'.next()<CR>",   "   Next trouble / quickfix item" },
  ["<Leader>m"] = { "<CMD>make<Space>", "   Run make" },
}, opts)

---------------------------------------------------------------------------
-- 🛠  overseer.nvim: Task Runner
---------------------------------------------------------------------------
wk.register({
  mode   = "n",
  silent = false,
  ["<Leader>rt"] = { "<CMD>OverseerToggle<CR>",  "  Toggle overseer window" },
  ["<Leader>rr"] = { "<CMD>OverseerRun<CR>",     "  Run a task from a template" },
})

---------------------------------------------------------------------------
-- 🔭  Telescope
---------------------------------------------------------------------------
-- Disable Telescope keymap for VSCode
if not is_vscode then

  wk.register({
    mode   = "n",
    ["<Leader>f"]  = { name = "🔭  Telescope: Fuzzy Finder" },
    ["<Leader>F"]  = { "<CMD>Telescope find_files<CR>", "   Find files in current directory" },
    ["<Leader>fo"] = { "<CMD>Telescope oldfiles<CR>",   "   Recently files" },
    ["<Leader>fn"] = { "<CMD>Telescope notify<CR>",     "   Notification History" },
    ["<Leader>fq"] = { "<CMD>Telescope quickfix<CR>",   "   Display Quickfix list" },
    ["<Leader>fr"] = { "<CMD>Telescope resume<CR>",     "   Resume previous picker" },
    ["<Leader>fh"] = { "<CMD>Telescope help_tags<CR>",  "   Help via Telescope" },
    ["<Leader>ft"] = { "<CMD>TodoTelescope<CR>",        "   Display Project ToDo" },
    ["<Leader>P"]  = { "<CMD>Lazy<CR>",                 "   Open lazy.nvim Window" },

    ["<Leader>fg"]    = { "<CMD>Telescope live_grep<CR>",    "   Live grep with args" },
    ["<C-g>"]         = { "<CMD>Telescope egrepify<CR>",     "   Live grep with egrepify" },
    ["<Leader><C-g>"] = { "<CMD>Telescope grep_string<CR>",  "   Grep string in working directory" },

    ["<Leader>ff"] = { "<CMD>Telescope frecency workspace=CWD<CR>", "   Frecency algorithm Search" },
    ["<Leader>fb"] = { "<CMD>Telescope file_browser<CR>",           "   File Browser" },
    ["<Leader>fl"] = { "<CMD>Telescope lazy<CR>",                   "   lazy.nvim Browser" },
    ["<Leader>fL"] = { "<CMD>Telescope luasnip<CR>",                "   LuaSnip Browser" },

    ["<Leader>fdc"] = { ":lua require'telescope'.extensinos.dap.configurations()<CR>",   "   DAP Configs" },
    ["<Leader>fdC"] = { ":lua require'telescope'.extensinos.dap.commands()<CR>",         "   DAP Commands" },
    ["<Leader>fdl"] = { ":lua require'telescope'.extensinos.dap.list_breakpoints()<CR>", "   Show Breakpoints" },
    ["<Leader>fdv"] = { ":lua require'telescope'.extensinos.dap.variables()<CR>",        "   Show Variables" },
    ["<Leader>fdf"] = { ":lua require'telescope'.extensinos.dap.frames()<CR>",           "   Show Frames" },

    ["<Leader>fc"]  = { ":lua require'telescope'.extensions.chezmoi.find_files()<CR>", "   Search chezmoi files" },
  }, opts)

end

---------------------------------------------------------------------------
-- LSP: Language Server Protocol
---------------------------------------------------------------------------
keymap("n", "K",  "<NOP>")
keymap("n", "<Leader>M", "<CMD>Mason<CR>",                          { desc = "   Open mason.nvim Window" })
keymap("n", "K",  "<CMD>lua vim.lsp.buf.hover()<CR>",           { desc = "   Hover Documentation" })
keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>",      { desc = "   Go to Definition" })
keymap("n", "gD", "<CMD>lua vim.lsp.buf.type_definition()<CR>", { desc = "   Go to Type Definition" })
keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>",  { desc = "   Go to implementation" })
keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>",      { desc = "   Go to references" })

keymap("n", "g[",  "<CMD>Lspsaga diagnostic_jump_prev<CR>", { desc = "   Go to prev diagnostics" })
keymap("n", "g]",  "<CMD>Lspsaga diagnostic_jump_next<CR>", { desc = "   Go to next diagnostics" })
keymap("n", "go",  "<CMD>Lspsaga outline<CR>",              { desc = "   Code outline" })
keymap("n", "gn",  "<CMD>Lspsaga rename<CR>",               { desc = "   Rename" })
keymap("n", "gci", "<CMD>Lspsaga incoming_calls<CR>",       { desc = "   Call incoming hierarchy" })
keymap("n", "gco", "<CMD>Lspsaga outcoming_calls<CR>",      { desc = "   Call outcoming hierarchy" })
keymap(nv, "ga", "<CMD>Lspsaga code_action<CR>",       { desc = "   Code Action" })

--------------------------------------------------
---- 🚦  Keymap for LSP via Telescope
--------------------------------------------------
wk.register({
  mode   = "n",
  ["<Leader>l"]  = { name = "🚦  LSP via Telescope" },
  ["<Leader>li"] = { "<CMD>LspInfo<CR>",                             "   Display LSP Information" },
  ["<Leader>lr"] = { "<CMD>Telescope lsp_references<CR>",            "   References" },
  ["<Leader>lD"] = { "<CMD>Telescope diagnostics<CR>",               "   Show diagnostic" },
  ["<Leader>lI"] = { "<CMD>Telescope lsp_implementation<CR>",        "   Implementation" },
  ["<Leader>lA"] = { "<CMD>Telescope lsp_range_code_actions<CR>",    "   Range Code Actions" },
  ["<Leader>lg"] = { "<CMD>Telescope lsp_document_diagnostics<CR>",  "   Document Diagnostics" },
  ["<Leader>lo"] = { "<CMD>Telescope lsp_workspace_diagnostics<CR>", "   Workspace Diagnostics" },
  ["<Leader>ls"] = { "<CMD>Telescope lsp_document_symbols<CR>",      "   Document Symbol" },
}, opts)

---------------------------------------------------------------------------
-- 🐛  DAP: Debugger Adapter Protocol
---------------------------------------------------------------------------
-- DAP keymap like VSCoed
keymap("n", "<F5>",    "<CMD>DapContinue<CR>",  { desc = ": Continue Process" })
keymap("n", "<S-F5>",  "<CMD>DapTerminate<CR>", { desc = "□: Terminate Process" })
keymap("n", "<F10>",   "<CMD>DapStepOver<CR>",  { desc = ": Step Over" })
keymap("n", "<F11>",   "<CMD>DapStepInto<CR>",  { desc = ": Step Into" })
keymap("n", "<S-F11>", "<CMD>DapStepOut<CR>",   { desc = ": Step Out" })

-- Debugger Control
wk.register({
  mode    = "n",
  ["<Leader>d"]  = { name = "🐛  Debugger" },
  ["<Leader>dd"] = { "<CMD>lua require'utils.dap'.toggle_ui<CR>",     ": Toggle Debugger UI" },
  ["<Leader>dw"] = { "<CMD>lua require'utils.dap'.float_watches<CR>", "  Float watches" },
  ["<Leader>ds"] = { "<CMD>lua require'utils.dap'.float_scopes<CR>",  "  Float scopes" },
  ["<Leader>dS"] = { "<CMD>lua require'utils.dap'.float_stacks<CR>",  "  Float stacks" },
  ["<Leader>dh"] = { "<CMD>lua require'utils.dap'.hover<CR>",         "  Hover DAP widgets" },
  ["<Leader>dp"] = { "<CMD>lua require'utils.dap'.preview<CR>",       "  DAP Preview" },
  ["<Leader>dl"] = { "<CMD>lua require'utils.dap'.open_log<CR>",      "󰌱  Open DAP log" },

  ["<Leader>db"] = { "<CMD>DapToggleBreakpoint<CR>", ": Toggle DAP Breakpoints" },
  ["<Leader>dc"] = { "<CMD>DapContinue<CR>",         ": Continue Process" },
  ["<Leader>di"] = { "<CMD>DapStepInto<CR>",         ": Step Into" },
  ["<Leader>do"] = { "<CMD>DapStepOver<CR>",         ": Step Over" },
  ["<Leader>dO"] = { "<CMD>DapStepOut<CR>",          ": Step Out" },
  ["<Leader>dB"] = { "<CMD>DapStepBack<CR>",         ": Step Back" },
  ["<Leader>dt"] = { "<CMD>DapTerminate<CR>",        "□: Terminate Process" },
  ["<Leader>dL"] = { "<CMD>lua require'dap'.run_last()<CR>", "↻: Run Last" },
}, opts)

-- Debugger
wk.register({
  mode    = "n",
  ["<Leader>fd"]  = { name = "  Telescope DAP Integration" },
}, opts)

---------------------------------------------------------------------------
-- Diffview
---------------------------------------------------------------------------
wk.register({
  mode = "n",
  silent = false,
  ["<Leader>g"]  = { name = "🧾  Diffview" },
  ["<Leader>go"] = { "<CMD>DiffviewOpen<CR>",            "a Open Diffview" },
  ["<Leader>gO"] = { ":DiffviewOpen<Space>",             "a Open Diffview with args" },
  ["<Leader>gq"] = { "<CMD>DiffviewClose<CR>",           "  Close Diffview" },
  ["<Leader>gt"] = { "<CMD>DiffviewToggleFiles<CR>",     "  Toggle file panels" },
  ["<Leader>gh"] = { ":DiffviewFileHistory<Space>",      "  Open file history" },
  ["<Leader>gf"] = { "<CMD>DiffviewFocusFiles<CR>",      "  Bring focus to the file panel" },
  ["<Leader>gr"] = { "<CMD>DiffviewRefresh<CR>",         "  Refresh Diffview" },
})

---------------------------------------------------------------------------
-- 🤖  AI Interaction
---------------------------------------------------------------------------
if not is_vscode then

  -- ChatGPT.nvim
  wk.register({
    mode = nv,
    ["<Leader>a"]  = { name = "🤖  ChatGPT" },
    ["<Leader>ai"] = { "<CMD>ChatGPT<CR>",                     "   Open ChatGPT Interactive Window" },
    ["<Leader>aa"] = { "<CMD>ChatGPTActAs<CR>",                "   Awesome ChatGPT Prompts" },
    ["<Leader>ac"] = { "<CMD>ChatGPTCompleteCode<CR>",         "   Complete code with ChatGPT" },
    ["<Leader>ae"] = { "<CMD>ChatGPTEditWithInstructions<CR>", "   Edit with instructions" },

    ["<Leader>ag"] = { "<CMD>ChatGPTRun grammar_correction<CR>", "   Grammar Correction" },
    ["<Leader>as"] = { "<CMD>ChatGPTRun summarize<CR>",          "   Summarize text" },
    ["<Leader>at"] = { "<CMD>ChatGPTRun translate<CR>",          "   translate text" },
    ["<Leader>ak"] = { "<CMD>ChatGPTRun keywords<CR>",           "   Keyword Generation" },

    ["<Leader>ad"] = { "<CMD>ChatGPTRun docstring<CR>",     "   Create docstring" },
    ["<Leader>af"] = { "<CMD>ChatGPTRun fix_bugs<CR>",      "   Fix bugs" },
    ["<Leader>aE"] = { "<CMD>ChatGPTRun explain_code<CR>",  "   Explain Code" },
    ["<Leader>ao"] = { "<CMD>ChatGPTRun optimize_code<CR>", "   Optimize Code" },
    ["<Leader>ar"] = { "<CMD>ChatGPTRun roxygen_edit<CR>",  "   Roxygen Edit" },
  }, opts)

end

---------------------------------------------------------------------------
-- obsidian.nvim
---------------------------------------------------------------------------
wk.register({
  mode = "n",
  ["<Leader>o"]  = { name = "📝  Obsidian integration" },
  ["<Leader>oo"] = { "<CMD>ObsidianOpen<CR>",        "  Open in Obsidian.app" },
  ["<Leader>on"] = { "<CMD>ObsidianNew<CR>",         "  Create New Note" },
  ["<Leader>ot"] = { "<CMD>ObsidianTemplate<CR>",    "  Insert Obsidian Template" },
  ["<Leader>of"] = { "<CMD>ObsidianFollowLink<CR>",  "  Go To Link Under Cursor" },
  ["<Leader>ob"] = { "<CMD>ObsidianBacklinks<CR>",   "  Get References To Current" },
  ["<Leader>og"] = { "<CMD>ObsidianSearch<CR>",      "  Grep Search notes" },
  ["<Leader>os"] = { "<CMD>ObsidianQuickSwitch<CR>", "  Quick Switch" },
  ["<Leader>od"] = { "<CMD>ObsidianDailies<CR>",     "  Open Daily Notes" },
}, opts)

---------------------------------------------------------------------------
-- Others
---------------------------------------------------------------------------
-- Toggle Plugin
keymap(nt,  ",t", "<CMD>ToggleTerm<CR>",         { desc = "   Toggle Terminal" })
keymap("n", ",f", "<CMD>Neotree toggle<CR>",     { desc = "   Toggle NeoTree" })
keymap("n", ",s", "<CMD>ScrollbarToggle<CR>",    { desc = "   Toggle Scrollbar" })
keymap("n", ",/", "<CMD>HlSearchLensToggle<CR>", { desc = "   Toggle Hlsearch lens" })
keymap("n", ",m", "<CMD>TSJToggle<CR>",          { desc = "   Toggle node under cursor" })
keymap("n", ",c", "<CMD>ColorizerToggle<CR>",    { desc = "   Toggle Colorizer" })

keymap("n", ",x", "<CMD>TroubleToggle workspace_diagnostics<CR>",       { desc = "   Toggle Diagnostic List" })
keymap("n", ",d", "<CMD>lua require'utils.lsp'.toggle_diagnostics<CR>", { desc = "   Toggle Diagnostic" })
