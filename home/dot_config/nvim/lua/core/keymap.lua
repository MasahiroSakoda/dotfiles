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
local nv_mode, nx_mode, nt_mode = { "n", "v" }, { "n", "x" }, { "n", "t" }

local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify('Failed loading ' .. "which-key", vim.log.levels.WARN)
end

keymap("n", "<Leader>e", ':edit<Space>', { desc = "   Edit" })

---------------------------------------------------------------------------
-- which-key commands
---------------------------------------------------------------------------
keymap("n", "<Leader>wa", ":WhichKey<CR>",            { desc = "   Show all mappings" })
keymap("n", "<Leader>wl", ":WhichKey <Leader><CR>",   { desc = "   Show all <Leader> mappings" })
keymap("n", "<Leader>wv", ":WhichKey <Leader> v<CR>", { desc = "   Show all <Leader> mappings for VISUAL mode" })

---------------------------------------------------------------------------
-- ❓ Help: <Leader>+H
---------------------------------------------------------------------------
vim.cmd [[
  cnoreabbrev H vert help
  cnoreabbrev HR vert bo h
]]

wk.register({
  mode    = "n",
  ["<Leader>H"]  = { name = "❓  Help"},
  ["<Leader>Hv"] = { ":vertical belowright help<Space>", "   Open Help page right side" },
  ["<Leader>Hh"] = { ":horizontal above help<Space>",    "   Open Help page above current buffer" },
}, opts)

---------------------------------------------------------------------------
-- 🕒  History: <Leader>+h
---------------------------------------------------------------------------
wk.register({
  mode    = "n",
  silent = false,
  ["<Leader>h"]  = { name = "🕒  History" },
  ["<Leader>hc"] = { "<CR>q:", "  Command History" },
  ["<Leader>hs"] = { "<CR>q/", "  Forward Search History" },
  ["<Leader>hS"] = { "<CR>q?", "  Backward Search History" },
})

---------------------------------------------------------------------------
-- Cursor
---------------------------------------------------------------------------
-- Insert Modeでjj/jk ESC
keymap("i", "jj", "<ESC>")

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
}, nx_mode)

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
keymap("n", "[t", ":tabprevious<CR>", { desc = "   Move to prev tab" })
keymap("n", "]t", ":tabnext<CR>",     { desc = "   Move to next tab" })
keymap("n", "[1", ":tabfirst<CR>",    { desc = "   Move to First tab" })
keymap("n", "]9", ":tablast<CR>",     { desc = "   Move to Last tab"})

-- Tab Control via Telescope
wk.register({
  mode    = "n",
  ["<Leader>t"]  = { name = "📑  Tab" },
  ["<Leader>tt"] = { ":Telescope telescope-tabs list_tabs<CR>", "   List Tabs" },
  ["<Leader>te"] = { ":tabedit<Space>",                         "   Edit file in new tab" },
  ["<Leader>tn"] = { ":tabnew<Space>",                          "   Edit file in new tab" },
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
local number = require("core.number")
keymap("n", ",n", number.toggleLineNumber,     { desc = "   Toggle Line Number" })
keymap("n", ",N", number.toggleRelativeNumber, { desc = "   Toggle Relatieve Number" })

---------------------------------------------------------------------------
-- dial.nvim: Increment/Decrement plugin
---------------------------------------------------------------------------
local map = require("dial.map")
keymap(nv_mode, "<C-a>", map.inc_normal('custom'), { desc = "   Increment variable" })
keymap(nv_mode, "<C-x>", map.dec_normal('custom'), { desc = "   Decrement variable" })
keymap("n", "g<C-a>", function() map.manipulate("increment", "gnormal") end, { desc = "   Serialized Increment" })
keymap("n", "g<C-x>", function() map.manipulate("decrement", "gnormal") end, { desc = "   Serialized Decrement" })

---------------------------------------------------------------------------
-- Quickfix
---------------------------------------------------------------------------
local quickfix = require("core.quickfix")
keymap("n", "<Leader>q", quickfix.toggleQuickfix,               { desc = "⚡  Toggle Quickfix" })
keymap("n", "[q",        quickfix.navigateQuickfix("previous"), { desc = "⚡ Move to prev Quickfix" })
keymap("n", "]q",        quickfix.navigateQuickfix("next"),     { desc = "⚡ Move to next Quickfix" })
-- keymap("n", "<Leader>r", ":lua require'replacer'.run()<CR>",    { desc = "Refactor" })

---------------------------------------------------------------------------
-- Generator
---------------------------------------------------------------------------
wk.register({
  mode = "n",
  ["<Leader>ng"] = { ":Neogen<CR>",       "   Generate annotation" },
  ["<Leader>nc"] = { ":Neogen class<CR>", "   Generate class annotation" },
  ["<Leader>nf"] = { ":Neogen func<CR>",  "   Generate function annotation" },
  ["<Leader>nt"] = { ":Neogen type<CR>",  "   Generate type annotation" },
}, opts)

wk.register({
  mode = "i",
  ["<C-h>"] = { ":lua require'neogen'.jump_prev()<CR>", "   Jump to prev annotation" },
  ["<C-l>"] = { ":lua require'neogen'.jump_next()<CR>", "   Jump to next annotation" },
}, opts)

---------------------------------------------------------------------------
-- 🔭  Telescope
---------------------------------------------------------------------------
-- Disable Telescope keymap for VSCode
if not is_vscode then

  wk.register({
    mode   = "n",
    ["<Leader>f"]  = { name = "🔭  Telescope: Fuzzy Finder" },
    ["<Leader>F"]  = { ":Telescope find_files<CR>",      "   Find files in current directory" },
    ["<Leader>fo"] = { ":Telescope oldfiles<CR>",        "   Recently files" },
    ["<Leader>fn"] = { ":Telescope notify<CR>",          "   Notification History" },
    ["<Leader>fh"] = { ":Telescope help_tags<CR>",       "   Help via Telescope" },
    ["<Leader>ft"] = { ":TodoTelescope<CR>",             "   Display Project ToDo" },
    ["<Leader>P"]  = { ":Lazy<CR>",                      "   Open lazy.nvim Window" },

    -- ["<C-g>"]         = { ":Telescope live_grep<CR>",    "   " },
    ["<C-g>"]         = { ":Telescope egrepify<CR>",     "   Telescope egrepify" },
    ["<Leader><C-g>"] = { ":Telescope grep_string<CR>",  "   Grep string in working directory" },

    ["<Leader>ff"] = { ":Telescope frecency<CR>",            "   Frecency algorithm Search" },
    ["<Leader>fF"] = { ":Telescope frecency workspace=<CR>", "   Frecency algorithm Search in workspace" },

    ["<Leader>fb"] = { ":Telescope file_browser<CR>", "   File Browser" },
    ["<Leader>fl"] = { ":Telescope lazy<CR>",         "   lazy.nvim Browser" },
    ["<Leader>fL"] = { ":Telescope luasnip<CR>",      "   LuaSnip Browser" },

    ["<Ldeader>fdc"] = { ":lua require'telescope'.extensinos.dap.configurations()<CR>",   "   dap configurations" },
    ["<Ldeader>fdC"] = { ":lua require'telescope'.extensinos.dap.commands()<CR>",         "   DAP Commands" },
    ["<Ldeader>fdl"] = { ":lua require'telescope'.extensinos.dap.list_breakpoints()<CR>", "   Show Breakpoints" },
    ["<Ldeader>fdv"] = { ":lua require'telescope'.extensinos.dap.variables()<CR>",        "   Show Variables" },
    ["<Ldeader>fdf"] = { ":lua require'telescope'.extensinos.dap.frames()<CR>", "   Show Frames" },
  }, opts)

end

---------------------------------------------------------------------------
-- LSP: Language Server Protocol
---------------------------------------------------------------------------
keymap("n", "<Leader>M", ":Mason<CR>",                 { desc = "   Open mason.nvim Window" })
keymap("n", "K",  "<NOP>")
keymap("n", "K",  ":Lspsaga hover_doc<CR>",            { desc = "   Hover Documentation"})
keymap("n", "gd", ":Lspsaga goto_definition<CR>",      { desc = "   Go to Definition" })
keymap("n", "gD", ":Lspsaga peek_type_definition<CR>", { desc = "   Go to Type Declaration" })
keymap("n", "gr", ":Lspsaga finder<CR>",           { desc = "   Go to References & Implementation" })
keymap("n", "go", ":Lspsaga outline<CR>",              { desc = "   Toggle code outline" })
keymap("n", "gR", ":Lspsaga rename<CR>",               { desc = "   Rename" })
keymap("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", { desc = "   Jump to prev diagnostics" })
keymap("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", { desc = "   Jump to next diagnostics" })
keymap(nv_mode, "ga", ":Lspsaga code_action<CR>",      { desc = "   Code Action" })

keymap("n", "<Leader>gi", "<CMD>Lspsaga incoming_calls<CR>", { desc = "   Call incoming hierarchy" })
keymap("n", "<Leader>go", "<CMD>Lspsaga outgoing_calls<CR>", { desc = "   Call outgoing hierarchy" })

keymap("n", "<Leader>gh", function() vim.lsp.buf.inlay_hints(0, nil) end, { desc = "Toggle Inlay Hints" })

--------------------------------------------------
---- 🚦  Keymap for LSP via Telescope
--------------------------------------------------
wk.register({
  mode   = "n",
  ["<Leader>l"]  = { name = "🚦  LSP via Telescope" },
  ["<Leader>li"] = { ":LspInfo<CR>",                             "   Display LSP Information" },
  ["<Leader>lr"] = { ":Telescope lsp_references<CR>",            "   References" },
  ["<Leader>lD"] = { ":Telescope diagnostics<CR>",               "   Show diagnostic" },
  ["<Leader>lI"] = { ":Telescope lsp_implementation<CR>",        "   Implementation" },
  ["<Leader>lA"] = { ":Telescope lsp_range_code_actions<CR>",    "   Range Code Actions" },
  ["<Leader>lg"] = { ":Telescope lsp_document_diagnostics<CR>",  "   Document Diagnostics" },
  ["<Leader>lo"] = { ":Telescope lsp_workspace_diagnostics<CR>", "   Workspace Diagnostics" },
  ["<Leader>ls"] = { ":Telescope lsp_document_symbols<CR>",      "   Document Symbol" },
}, opts)

---------------------------------------------------------------------------
-- 🐛  DAP: Debugger Adapterr Protocol
---------------------------------------------------------------------------
keymap("n", "<F5>",    ":DapContinue<CR>",  { desc = ": Continue Process" })
keymap("n", "<S-F5>",  ":DapTerminate<CR>", { desc = "□: Terminate Process" })
keymap("n", "<F10>",   ":DapStepOver<CR>",  { desc = ": Step Over" })
keymap("n", "<F11>",   ":DapStepInto<CR>",  { desc = ": Step Into" })
keymap("n", "<S-F11>", ":DapStepOut<CR>",   { desc = ": Step Out" })

-- Debugger Control
wk.register({
  mode    = "n",
  ["<Leader>d"]  = { name = "🐛  Debugger" },
  ["<Leader>dd"] = { ":lua require'dapui'.toggle()<CR>", ": Toggle Debugger UI" },
  ["<Leader>db"] = { ":DapToggleBreakpoint<CR>",         ": Toggle DAP Breakpoints" },
  ["<Leader>dc"] = { ":DapContinue<CR>",                 ": Continue Process" },
  ["<Leader>di"] = { ":DapStepInto<CR>",                 ": Step Into" },
  ["<Leader>do"] = { ":DapStepOver<CR>",                 ": Step Over" },
  ["<Leader>dO"] = { ":DapStepOut<CR>",                  ": Step Out" },
  ["<Leader>dB"] = { "::DapStepBack<CR>",                ": Step Back" },
  ["<Leader>dt"] = { ":DapTerminate<CR>",                "□: Terminate Process" },
  ["<Leader>dl"] = { ":lua require'dap'.run_last()<CR>", "↻: Run Last" },
}, opts)

-- Debugger Action
wk.register({
  mode = "n",
  ["<Leader>da"]  = { name = "🐛  Debugger" },
  ["<Leader>dal"] = { ":lua require'osv'.launch({ port = 8086 })<CR>",  "   Run Lua debugger server" },
  ["<Leader>daL"] = { ":lua require'osv'.run_this()<CR>",               "   Run Lua debugger" },
  ["<Leader>dap"] = { ":lua require'dap-python'.test_method()<CR>",     "   Debug Python test method" },
  ["<Leader>daP"] = { ":lua require'dap-python'.test_class()<CR>",      "   Debug Python test class" },
  ["<Leader>daq"] = { ":lua require'dap-python'.debug_selection()<CR>", "   Run test selection for Python" },
  ["<Leader>dag"] = { ":lua require'dap-go'.debug_test()<CR>",          "   Debug current test for Go" },
  ["<Leader>daG"] = { ":lua require'dap-go'.debug_last_test()<CR>",     "   Debug last test for Go" },
  ["<Leader>daf"] = { ":lua require'dap-go'.run_last()<CR>",            "   Run last test for Go" },
  ["<Leader>daj"] = { ":lua require''.run", "   Run JS debugger" },
})

-- Debugger
wk.register({
  mode    = "n",
  ["<Leader>fd"]  = { name = "  Telescope DAP Integration" },
}, opts)

---------------------------------------------------------------------------
-- IDE Integration
---------------------------------------------------------------------------
keymap("n", "<Leader>xs", "<CMD>XcodebuildSetup<CR>",  { desc = "Run configuration wizard to select project configuration" })
keymap("n", "<Leader>xa", "<CMD>XcodebuildPicker<CR>", { desc = "Show picker with all available actions" })

keymap("n", "<Leader>xp", "<CMD>XcodebuildSelectProject<CR>",  { desc = "Show project file picker" })
keymap("n", "<Leader>xS", "<CMD>XcodebuildSelectScheme<CR>",   { desc = "Show scheme picker" })
keymap("n", "<Leader>xc", "<CMD>XcodebuildSelectConfig<CR>",   { desc = "Show build configuration picker" })
keymap("n", "<Leader>xC", "<CMD>XcodebuildShowConfig<CR>",     { desc = "Print current project configuration" })
keymap("n", "<Leader>xd", "<CMD>XcodebuildSelectDevice<CR>",   { desc = "Show device picker" })
keymap("n", "<Leader>xP", "<CMD>XcodebuildSelectTestPlan<CR>", { desc = "Show test plan picker" })
keymap("n", "<Leader>xl", "<CMD>XcodebuildToggleLogs<CR>",     { desc = "Toggle logs panel" })

keymap("n", "<Leader>xb",  "<CMD>XcodebuildBuild<CR>",        { desc = "Build project" })
keymap("n", "<Leader>xb",  "<CMD>XcodebuildBuildRun<CR>",     { desc = "Build & run app" })
keymap("n", "<Leader>x.",  "<CMD>XcodebuildCancel<CR>",       { desc = "Cancel currently running action" })
keymap("n", "<Leader>xT",  "<CMD>XcodebuildTest<CR>",         { desc = "Run tests (whole test plan)" })
keymap("n", "<Leader>xtc", "<CMD>XcodebuildTestClass<CR>",    { desc = "Run test class (where the cursor is)" })
keymap("n", "<Leader>xtf", "<CMD>XcodebuildTestFunc<CR>",     { desc = "Run test (where the cursor is)" })
keymap("n", "<Leader>xts", "<CMD>XcodebuildTestSelected<CR>", { desc = "Run selected tests (using visual mode)" })
keymap("n", "<Leader>xtF", "<CMD>XcodebuildTestFailing<CR>",  { desc = "Rerun previously failed tests" })

---------------------------------------------------------------------------
-- Test with neotest
---------------------------------------------------------------------------
wk.register({
  mode = "n",
  ["<Leader>T"]  = { name = "🪧  Test" },
  ["<Leader>Tr"] = { ":lua require'neotest'.run.run(vim.fn.expand('%'))<CR>", "   Run Tests" },
  ["<Leader>Ta"] = { ":lua require'neotest'.run.run(vim.loop.cwd())<CR>",     "   Run All Tests" },
  ["<Leader>Tn"] = { ":lua require'neotest'.run.run()",                       "   Run Nearest" },
  ["<Leader>Ts"] = { ":lua require'neotest'.run.stop()<CR>",                  "   Stop Tests" },
  ["<Leader>Td"] = { ":lua require'neotest'.run.run({strategy = 'dap'})",     "   Debug Neaerest" },
  ["<Leader>TS"] = { ":lua require'neotest'.summary.toggle()<CR>",            "   Toggle Summary" },
  ["<Leader>To"] = { ":lua require'neotest'.output_panel.toggle()<CR>",       "   Toggle Output Panel" },
  ["<Leader>TO"] = { ":lua require'neotest'.output.open({ enter = true, auto_close = true })<CR>", "   Show Output" },
}, opts)

---------------------------------------------------------------------------
-- Terminal
---------------------------------------------------------------------------
keymap(nt_mode, ",t", "<CMD>ToggleTerm<CR>", { desc = "   Toggle Terminal" })

---------------------------------------------------------------------------
-- 🤖  AI Interaction
---------------------------------------------------------------------------
if not is_vscode then

  -- ChatGPT.nvim
  wk.register({
    mode = nv_mode,
    ["<Leader>a"]  = { name = "🤖  ChatGPT" },
    ["<Leader>ai"] = { ":ChatGPT<CR>",                     "   Open ChatGPT Interactive Window" },
    ["<Leader>aa"] = { ":ChatGPTActAs<CR>",                "   Awesome ChatGPT Prompts" },
    ["<Leader>ac"] = { ":ChatGPTCompleteCode<CR>",         "   Complete code with ChatGPT" },
    ["<Leader>ae"] = { ":ChatGPTEditWithInstructions<CR>", "   Edit with instructions" },

    ["<Leader>ag"] = { ":ChatGPTRun grammar_correction<CR>", "   Grammar Correction" },
    ["<Leader>as"] = { ":ChatGPTRun summarize<CR>",          "   Summarize text" },
    ["<Leader>at"] = { ":ChatGPTRun translate<CR>",          "   translate text" },
    ["<Leader>ak"] = { ":ChatGPTRun keywords<CR>",           "   Keyword Generation" },

    ["<Leader>ad"] = { ":ChatGPTRun docstring<CR>",     "   Create docstring" },
    ["<Leader>af"] = { ":ChatGPTRun fix_bugs<CR>",      "   Fix bugs" },
    ["<Leader>aE"] = { ":ChatGPTRun explain_code<CR>",  "   Explain Code" },
    ["<Leader>ao"] = { ":ChatGPTRun optimize_code<CR>", "   Optimize Code" },
    ["<Leader>ar"] = { ":ChatGPTRun roxygen_edit<CR>",  "   Roxygen Edit" },
  }, opts)

  wk.register({
    ["<Leader>a"]  = { name = "🤖  ChatGPT" },
    ["<Leader>ae"] = { ":ChatGPTEditWithInstructions<CR>", "Edit with instructions" },
  }, { mode = "v" })

end

---------------------------------------------------------------------------
-- Others
---------------------------------------------------------------------------
-- Toggle Plugin
keymap("n", ",f",  "<CMD>Neotree toggle<CR>",     { desc = "   Toggle NeoTree" })
keymap("n", ",s",  "<CMD>ScrollbarToggle<CR>",    { desc = "   Toggle Scrollbar" })
keymap("n", ",/",  "<CMD>HlSearchLensToggle<CR>", { desc = "   Toggle Hlsearch lens" })
keymap("n", ",m",  "<CMD>TSJToggle<CR>",          { desc = "   Toggle node under cursor" })
keymap("n", ",c",  "<CMD>ColorizerToggle<CR>",    { desc = "   Toggle Colorizer" })
keymap("n", ",x", "<CMD>TroubleToggle<CR>",       { desc = "   Toggle Diagnostic List" })
