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
local nv, nx, nt, nxo = { "n", "v" }, { "n", "x" }, { "n", "t" }, { "n", "x", "o" }

local ok, wk = pcall(require, "which-key")
if not ok then vim.notify("Failed loading " .. "which-key", vim.log.levels.WARN) end

---------------------------------------------------------------------------
-- which-key commands
---------------------------------------------------------------------------
wk.add({
  { "<Leader>w", group = "⌨️ Which-Key" },
  { "<Leader>wk", "<CMD>WhichKey<CR>",            desc = "  Show all mappings" },
  { "<Leader>wl", "<CMD>WhichKey <Leader><CR>",   desc = "  Show all <Leader> mappings" },
  { "<Leader>wv", "<CMD>WhichKey <Leader> v<CR>", desc = "  Show all <Leader> mappings for VISUAL mode" },
}, opts)

---------------------------------------------------------------------------
-- ❓ Help: <Leader>+H
---------------------------------------------------------------------------
vim.cmd [[
  cnoreabbrev H vert help
  cnoreabbrev HR vert bo h
]]

wk.add({
  { "<Leader>h", group = "❓ Help" },
  { "<Leader>hh", ":horizontal above help<Space>",    desc = "  Open Help page above current buffer" },
  { "<Leader>hv", ":vertical belowright help<Space>", desc = "  Open Help page right side" },
}, opts)

---------------------------------------------------------------------------
-- 🕒  History: <Leader>+h
---------------------------------------------------------------------------
wk.add({
  silent = false,
  { "<Leader>H", group = "🕒 History" },
  { "<Leader>HS", "<CR>q?", desc = "  Backward Search History" },
  { "<Leader>Hc", "<CR>q:", desc = "  Command History" },
  { "<Leader>Hs", "<CR>q/", desc = "  Forward Search History" },
})

---------------------------------------------------------------------------
-- Cursor
---------------------------------------------------------------------------
-- Insert Modeでjj/jk ESC
keymap("i", "jj", "<ESC>")

-- flash.nvim
wk.add({
  mode = nxo,
  { "s", "<CMD>lua require'flash'.jump()<CR>",       desc = "  Flash" },
  { "s", "<CMD>lua require'flash'.treesitter()<CR>", desc = "  Flash Treesitter" },
})

keymap({ "o" },      "r", "<CMD>lua require'flash'.remote()<CR>",            { desc = "  Remote Flash" })
keymap({ "o", "x" }, "R", "<CMD>lua require'flash'.treesitter_search()<CR>", { desc = "  Treesitter Search" })
keymap({ "c" },  "<C-s>", "<CMD>lua require'flash'.toggle()<CR>",            { desc = "  Toggle Flash Search" })

---------------------------------------------------------------------------
-- Search
---------------------------------------------------------------------------
wk.add({
    { "#", "<Plug>(asterisk-#)",     desc = "   Search backward" },
    { "*", "<Plug>(asterisk-*)",     desc = "   Search forward" },
    { "g#", "<Plug>(asterisk-g#)",   desc = "   Partial search backward" },
    { "g*", "<Plug>(asterisk-g*)",   desc = "   Partial Search forward" },
    { "gz#", "<Plug>(asterisk-gz#)", desc = "   Partial search backward (in-place)" },
    { "gz*", "<Plug>(asterisk-gz*)", desc = "   Partial Search forward (in-place)" },
    { "z", group = " Search in-place" },
    { "z#", "<Plug>(asterisk-z#)",   desc = "  Search backward (in-place)" },
    { "z*", "<Plug>(asterisk-z*)",   desc = "  Search forward (in-place)" },
}, nx)

---------------------------------------------------------------------------
-- 📑  Tab / Buffer / Window
---------------------------------------------------------------------------
wk.add({
  { "[b", "<CMD>bprev<CR>", desc = "  Move to prev buffer" },
  { "]b", "<CMD>bnext<CR>", desc = "  Move to next buffer" },
})

-- Buffer Naigation
wk.add({
  { "<Leader>b", group = "🖥 Buffer Navigation" },
  { "<Leader>bb", "<CMD>Telescope buffers<CR>",   desc = "  Display buffers list" },
  { "<Leader>bd", "<CMD>bdelete<CR>",             desc = "  Delete buffer" },
  { "<Leader>bn", "<CMD>BufferLineCycleNext<CR>", desc = "  Move to next buffer" },
  { "<Leader>bp", "<CMD>BufferLineCyclePrev<CR>", desc = "  Move to prev buffer" },
}, opts)

-- Tab Navigation
wk.add({
  { "[t", "<CMD>tabprevious<CR>", desc = "   Move to prev tab" },
  { "]t", "<CMD>tabnext<CR>",     desc = "   Move to next tab" },
  { "[1", "<CMD>tabfirst<CR>",    desc = "   Move to First tab" },
  { "]9", "<CMD>tablast<CR>",     desc = "   Move to Last tab" },
})

-- Tab Control via Telescope
wk.add({
    { "<Leader>t", group = "📑 Tab" },
    { "<Leader>tc", "<CMD>tabclose<CR>", desc = "  Close current tab" },
    { "<Leader>te", ":tabedit<Space>",   desc = "  Edit file in new tab" },
    { "<Leader>tn", ":tabnew<Space>",    desc = "  Edit file in new tab" },
}, opts)

-- Window Moving
wk.add({
  { "[w", "<C-w>h", desc = "   Move to Left  Window" },
  { "]w", "<C-w>l", desc = "   Move to Right Window" },
  { "[W", "<C-w>j", desc = "   Move to Above Window" },
  { "]W", "<C-w>k", desc = "   Move to Below Window" },
})

-- Split Window
wk.add({
  { "<Leader>s", group = "📖 Split Window" },
  { "<Leader>sh", ":split<Space>",  desc = "  Split window horizontally" },
  { "<Leader>sv", ":vsplit<Space>", desc = "  Split window vertically" },
}, opts)

---------------------------------------------------------------------------
-- Line Number
---------------------------------------------------------------------------
local ui = require("utils.ui")
wk.add({
  { ",n", ui.toggle_line_number,     desc = "   Toggle Line Number" },
  { ",N", ui.toggle_relative_number, desc = "   Toggle Relatieve Number" },
})

---------------------------------------------------------------------------
-- dial.nvim: Increment/Decrement plugin
---------------------------------------------------------------------------
local map = require("dial.map")
wk.add({
  { "<C-a>",  map.inc_normal(),  desc = "   Increment variable" },
  { "<C-x>",  map.dec_normal(),  desc = "   Decrement variable" },
  { "g<C-a>", map.inc_gnormal(), desc = "   Increment variable" },
  { "g<C-x>", map.dec_gnormal(), desc = "   Decrement variable" },
})

wk.add({
  mode = "v",
  { "<C-a>",  map.inc_visual(),  desc = "   Increment variable" },
  { "<C-x>",  map.dec_visual(),  desc = "   Decrement variable" },
  { "g<C-a>", map.inc_gvisual(), desc = "   Increment variable" },
  { "g<C-x>", map.dec_gvisual(), desc = "   Decrement variable" },
})

---------------------------------------------------------------------------
-- Quickfix
---------------------------------------------------------------------------

wk.add({
  { "<C-p>",     "<NOP>"},
  { ",q",        "<CMD>Trouble qflist toggle<CR>",                desc = "  Toggle Quickfix list" },
  { "<C-n>",     "<CMD>lua require'utils.trouble'.next()<CR>",    desc = "  Next trouble / quickfix item" },
  { "<C-p>",     "<CMD>lua require'utils.trouble'.prev()<CR>",    desc = "  Prev trouble / quickfix item" },
  { "<Leader>m", "<CMD>make<Space>",                              desc = "  Run make" },
  { "[q",        "<CMD>lua require'utils.trouble'.prev()<CR>zz",  desc = "  Prev trouble / quickfix item" },
  { "]q",        "<CMD>lua require'utils.trouble'.next()<CR>zz",  desc = "  Next trouble / quickfix item" },
}, opts)

---------------------------------------------------------------------------
-- 🛠  overseer.nvim: Task Runner
---------------------------------------------------------------------------
wk.add({
  { "<Leader>rr", "<CMD>OverseerRun<CR>",    desc = "  Run a task from a template" },
  { "<Leader>rt", "<CMD>OverseerToggle<CR>", desc = "  Toggle overseer window" },
})

---------------------------------------------------------------------------
-- 🔭  Telescope
---------------------------------------------------------------------------
-- Disable Telescope keymap for VSCode
if not is_vscode then

  wk.add({
    { "<Leader>f", group = "🔭 Telescope: Fuzzy Finder" },
    { "<C-g>", "<CMD>Telescope egrepify<CR>",            desc = "  Live grep with egrepify" },
    { "<Leader><C-g>", "<CMD>Telescope grep_string<CR>", desc = "  Grep string in working directory" },
    { "<Leader>F", "<CMD>Telescope find_files<CR>",      desc = "  Find files in current directory" },
    { "<Leader>fL", "<CMD>Telescope luasnip<CR>",        desc = "  LuaSnip Browser" },
    { "<Leader>fb", "<CMD>Telescope file_browser<CR>",   desc = "  File Browser" },

    { "<Leader>fc", ":lua require'telescope'.extensions.chezmoi.find_files()<CR>", desc = "  Search chezmoi files" },

    { "<Leader>fdC", ":lua require'telescope'.extensinos.dap.commands()<CR>",         desc = "  DAP Commands" },
    { "<Leader>fdc", ":lua require'telescope'.extensinos.dap.configurations()<CR>",   desc = "  DAP Configs" },
    { "<Leader>fdf", ":lua require'telescope'.extensinos.dap.frames()<CR>",           desc = "  Show Frames" },
    { "<Leader>fdl", ":lua require'telescope'.extensinos.dap.list_breakpoints()<CR>", desc = "  Show Breakpoints" },
    { "<Leader>fdv", ":lua require'telescope'.extensinos.dap.variables()<CR>",        desc = "  Show Variables" },

    { "<Leader>ff", "<CMD>Telescope frecency workspace=CWD<CR>", desc = "  Frecency algorithm Search" },
    { "<Leader>fg", "<CMD>Telescope live_grep<CR>",              desc = "  Live grep with args" },
    { "<Leader>fh", "<CMD>Telescope help_tags<CR>",              desc = "  Help via Telescope" },
    { "<Leader>fl", "<CMD>Telescope lazy<CR>",                   desc = "  lazy.nvim Browser" },
    { "<Leader>fn", "<CMD>Telescope notify<CR>",                 desc = "  Notification History" },
    { "<Leader>fo", "<CMD>Telescope oldfiles<CR>",               desc = "  Recently files" },
    { "<Leader>fq", "<CMD>Telescope quickfix<CR>",               desc = "  Display Quickfix list" },
    { "<Leader>fr", "<CMD>Telescope resume<CR>",                 desc = "  Resume previous picker" },
    { "<Leader>ft", "<CMD>TodoTelescope<CR>",                    desc = "  Display Project ToDo" },
  }, opts)

end

---------------------------------------------------------------------------
-- LSP: Language Server Protocol
---------------------------------------------------------------------------
wk.add({
  { "K", "<NOP" },
  { "<Leader>P", "<CMD>Lazy<CR>",                        desc = "  Open lazy.nvim Window" },
  { "<Leader>M", "<CMD>Mason<CR>",                       desc = "  Open mason.nvim Window" },

  { "K",   "<CMD>lua vim.lsp.buf.hover()<CR>",           desc = "  Hover Documentation" },
  { "gd",  "<CMD>lua vim.lsp.buf.definition()<CR>",      desc = "  Go to Definition" },
  { "gD",  "<CMD>lua vim.lsp.buf.type_definition()<CR>", desc = "  Go to Type Definition" },
  { "gi",  "<CMD>lua vim.lsp.buf.implementation()<CR>",  desc = "  Go to implementation" },
  { "gr",  "<CMD>lua vim.lsp.buf.references()<CR>",      desc = "  Go to references" },
  { "g[",  "<CMD>Lspsaga diagnostic_jump_prev<CR>",      desc = "  Go to prev diagnostics" },
  { "g]",  "<CMD>Lspsaga diagnostic_jump_next<CR>",      desc = "  Go to next diagnostics" },
  { "go",  "<CMD>Lspsaga outline<CR>",                   desc = "  Code outline" },
  { "gn",  "<CMD>Lspsaga rename<CR>",                    desc = "  Rename" },
  { "gci", "<CMD>Lspsaga incoming_calls<CR>",            desc = "  Call incoming hierarchy" },
  { "gco", "<CMD>Lspsaga outcoming_calls<CR>",           desc = "  Call outcoming hierarchy" },
})

wk.add({
  mode = nv,
  { "ga", "<CMD>Lspsaga code_action<CR>", desc = "  Code Action" },
})

--------------------------------------------------
---- 🚦  Keymap for LSP via Telescope
--------------------------------------------------
wk.add({
  { "<Leader>l", group = "🚦 LSP via Telescope" },
  { "<Leader>lA", "<CMD>Telescope lsp_range_code_actions<CR>",    desc = "  Range Code Actions" },
  { "<Leader>lD", "<CMD>Telescope diagnostics<CR>",               desc = "  Show diagnostic" },
  { "<Leader>lI", "<CMD>Telescope lsp_implementation<CR>",        desc = "  Implementation" },
  { "<Leader>lg", "<CMD>Telescope lsp_document_diagnostics<CR>",  desc = "  Document Diagnostics" },
  { "<Leader>li", "<CMD>LspInfo<CR>",                             desc = "  Display LSP Information" },
  { "<Leader>lo", "<CMD>Telescope lsp_workspace_diagnostics<CR>", desc = "  Workspace Diagnostics" },
  { "<Leader>lr", "<CMD>Telescope lsp_references<CR>",            desc = "  References" },
  { "<Leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",      desc = "  Document Symbol" },
}, opts)

---------------------------------------------------------------------------
-- 🐛  DAP: Debugger Adapter Protocol
---------------------------------------------------------------------------
-- DAP keymap like VSCode
wk.add({
  { "<F5>",    "<CMD>Dap<CR>", desc = ": Continue Process" },
  { "<S-F5>",  "<CMD>Dap<CR>", desc = "□: Terminate Process" },
  { "<F10>",   "<CMD>Dap<CR>", desc = ": Step Over" },
  { "<F11>",   "<CMD>Dap<CR>", desc = ": Step Into" },
  { "<S-F11>", "<CMD>Dap<CR>", desc = ": Step Out" },
})

-- Debugger Control
wk.add({
  { "<Leader>d", group = "🐛 Debugger" },
  { "<Leader>db", "<CMD>DapToggleBreakpoint<CR>",                    desc = ": Toggle DAP Breakpoints" },
  { "<Leader>dc", "<CMD>DapContinue<CR>",                            desc = ": Continue Process" },
  { "<Leader>do", "<CMD>DapStepOver<CR>",                            desc = ": Step Over" },
  { "<Leader>di", "<CMD>DapStepInto<CR>",                            desc = ": Step Into" },
  { "<Leader>dO", "<CMD>DapStepOut<CR>",                             desc = ": Step Out" },
  { "<Leader>dB", "<CMD>DapStepBack<CR>",                            desc = ": Step Back" },
  { "<Leader>dt", "<CMD>DapTerminate<CR>",                           desc = "□: Terminate Process" },
  { "<Leader>dd", "<CMD>lua require'utils.dap'.toggle_ui()<CR>",     desc = ": Toggle Debugger UI" },
  { "<Leader>dp", "<CMD>lua require'utils.dap'.preview()<CR>",       desc = "  DAP Preview" },
  { "<Leader>dh", "<CMD>lua require'utils.dap'.hover()<CR>",         desc = "  Hover DAP widgets" },
  { "<Leader>dl", "<CMD>lua require'utils.dap'.open_log()<CR>",      desc = "󰌱  Open DAP log" },
  { "<Leader>dL", "<CMD>lua require'dap'.run_last()<CR>",            desc = "↻: Run Last" },
  { "<Leader>ds", "<CMD>lua require'utils.dap'.float_scopes()<CR>",  desc = "  Float scopes" },
  { "<Leader>dS", "<CMD>lua require'utils.dap'.float_stacks()<CR>",  desc = "  Float stacks" },
  { "<Leader>dw", "<CMD>lua require'utils.dap'.float_watches()<CR>", desc = "  Float watches" },
}, opts)

-- Debugger
wk.add({
  { "<Leader>fd", group = " Telescope DAP Integration" },
}, opts)

---------------------------------------------------------------------------
-- Diffview
---------------------------------------------------------------------------
wk.add({
  { "<Leader>g", group = "🧾 Diffview" },
  { "<Leader>gO", ":DiffviewOpen<Space>",         desc = "a Open Diffview with args" },
  { "<Leader>gf", "<CMD>DiffviewFocusFiles<CR>",  desc = "  Bring focus to the file panel" },
  { "<Leader>gh", ":DiffviewFileHistory<Space>",  desc = "  Open file history" },
  { "<Leader>go", "<CMD>DiffviewOpen<CR>",        desc = "a Open Diffview" },
  { "<Leader>gq", "<CMD>DiffviewClose<CR>",       desc = "  Close Diffview" },
  { "<Leader>gr", "<CMD>DiffviewRefresh<CR>",     desc = "  Refresh Diffview" },
  { "<Leader>gt", "<CMD>DiffviewToggleFiles<CR>", desc = "  Toggle file panels" },
})

---------------------------------------------------------------------------
-- 🤖  AI Interaction
---------------------------------------------------------------------------
if not is_vscode then

  -- ChatGPT.nvim
  wk.add({
    mode = nv,
    { "<Leader>a", group = "🤖 ChatGPT" },
    { "<Leader>ai", "<CMD>ChatGPT<CR>",                       desc = "  Open ChatGPT Interactive Window" },
    { "<Leader>aa", "<CMD>ChatGPTActAs<CR>",                  desc = "  Awesome ChatGPT Prompts" },

    { "<Leader>ac", "<CMD>ChatGPTCompleteCode<CR>",           desc = "  Complete code with ChatGPT" },
    { "<Leader>ae", "<CMD>ChatGPTEditWithInstructions<CR>",   desc = "  Edit with instructions" },
    { "<Leader>ag", "<CMD>ChatGPTRun grammar_correction<CR>", desc = "  Grammar Correction" },
    { "<Leader>as", "<CMD>ChatGPTRun summarize<CR>",          desc = "  Summarize text" },
    { "<Leader>at", "<CMD>ChatGPTRun translate<CR>",          desc = "  translate text" },
    { "<Leader>ak", "<CMD>ChatGPTRun keywords<CR>",           desc = "  Keyword Generation" },

    { "<Leader>ad", "<CMD>ChatGPTRun docstring<CR>",          desc = "  Create docstring" },
    { "<Leader>af", "<CMD>ChatGPTRun fix_bugs<CR>",           desc = "  Fix bugs" },
    { "<Leader>aE", "<CMD>ChatGPTRun explain_code<CR>",       desc = "  Explain Code" },
    { "<Leader>ao", "<CMD>ChatGPTRun optimize_code<CR>",      desc = "  Optimize Code" },
    { "<Leader>ar", "<CMD>ChatGPTRun roxygen_edit<CR>",       desc = "  Roxygen Edit" },
  }, opts)

end

---------------------------------------------------------------------------
-- obsidian.nvim
---------------------------------------------------------------------------
wk.add({
  { "<Leader>o", group = "📝 Obsidian integration" },
  { "<Leader>ob", "<CMD>ObsidianBacklinks<CR>",   desc = "  Get References To Current" },
  { "<Leader>od", "<CMD>ObsidianDailies<CR>",     desc = "  Open Daily Notes" },
  { "<Leader>of", "<CMD>ObsidianFollowLink<CR>",  desc = "  Go To Link Under Cursor" },
  { "<Leader>og", "<CMD>ObsidianSearch<CR>",      desc = "  Grep Search notes" },
  { "<Leader>on", "<CMD>ObsidianNew<CR>",         desc = "  Create New Note" },
  { "<Leader>oo", "<CMD>ObsidianOpen<CR>",        desc = "  Open in Obsidian.app" },
  { "<Leader>os", "<CMD>ObsidianQuickSwitch<CR>", desc = "  Quick Switch" },
  { "<Leader>ot", "<CMD>ObsidianTemplate<CR>",    desc = "  Insert Obsidian Template" },
}, opts)

---------------------------------------------------------------------------
-- Others
---------------------------------------------------------------------------
-- Toggle Plugin
wk.add({
  { ",f", "<CMD>Neotree toggle<CR>",                            desc = "  Toggle NeoTree" },
  { ",s", "<CMD>ScrollbarToggle<CR>",                           desc = "  Toggle Scrollbar" },
  { ",/", "<CMD>HlSearchLensToggle<CR>",                        desc = "  Toggle Hlsearch lens" },
  { ",m", "<CMD>TSJToggle<CR>",                                 desc = "  Toggle node under cursor" },
  { ",c", "<CMD>ColorizerToggle<CR>",                           desc = "  Toggle Colorizer" },
  { ",x", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",   desc = "  Toggle Diagnostic List" },
  { ",d", "<CMD>lua require'utils.lsp'.toggle_diagnostics<CR>", desc = "  Toggle Diagnostic" },
})

wk.add({
  mode = nt,
  { ",t", "<CMD>ToggleTerm<CR>", desc = "  Toggle Terminal" },
})
