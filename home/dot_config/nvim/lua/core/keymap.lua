---------------------------------------------------------------------------
-- Binding Rules:
-- Builtin keymap: <Leader> + h: help, H: history, b: Buffer, t: Tab, s: Split
-- LSP keymap:   `<Leader> + l`
-- DAP keymap:   `<Leader> + d`
-- Git Keymap:   `<Leader> + g`
-- Fuzzy Finder: `<Leader> + f`
-- Task Runner:  `<Leader> + o`
-- Toggle keymap `,`
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
  { "<Leader>?", group = "Which-Key", icon = "⌨️ " },
  { "<Leader>??", "<CMD>WhichKey<CR>",            icon = " ", desc = "All maps" },
  { "<Leader>?l", "<CMD>WhichKey <Leader><CR>",   icon = " ", desc = "All <Leader> maps" },
  { "<Leader>?v", "<CMD>WhichKey <Leader> v<CR>", icon = " ", desc = "All <Leader> maps for VISUAL mode" },
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
wk.add({
  { "jj", "<ESC>", mode = "i", icon = " ", desc = "Return to NORMAL mode" },
  { "kk", "<ESC>", mode = "i", icon = " ", desc = "Return to NORMAL mode" },

  { "s", "<CMD>lua require'flash'.jump()<CR>",              mode = nxo, icon = " ", desc = "Flash" },
  { "S", "<CMD>lua require'flash'.treesitter()<CR>",        mode = nxo, icon = " ", desc = "Flash Treesitter" },

  { "r", "<CMD>lua require'flash'.remote()<CR>",            mode = o,   icon = " ", desc = "Remote Flash" },
  { "R", "<CMD>lua require'flash'.treesitter_search()<CR>", mode = ox,  icon = " ", desc = "Treesitter Search" },

  { "<C-s>", "<CMD>lua require'flash'.treesitter_search()<CR>", mode = c, icon = " ", desc = "Toggle Flash Search" },
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

  -- Buffer Naigation
  { "<Leader>b", group = "Buffer Navigation", icon = "🖥 " },
  { "<Leader>bn", "<CMD>BufferLineCycleNext<CR>", icon = " ", desc = "Move to next buffer" },
  { "<Leader>bp", "<CMD>BufferLineCyclePrev<CR>", icon = " ", desc = "Move to prev buffer" },
  { "<Leader>bdc", "<CMD>lua require'snacks'.bufdelete()<CR>",       icon = " ", desc = "Delete current buffer" },
  { "<Leader>bdo", "<CMD>lua require'snacks'.bufdelete.other()<CR>", icon = " ", desc = "Delete other buffers" },

  -- Tab Navigation
  { "[t", "<CMD>tabprevious<CR>", icon = " ", desc = "Move to prev tab" },
  { "]t", "<CMD>tabnext<CR>",     icon = " ", desc = "Move to next tab" },
  { "[1", "<CMD>tabfirst<CR>",    icon = " ", desc = "Move to First tab" },
  { "]9", "<CMD>tablast<CR>",     icon = " ", desc = "Move to Last tab" },

  -- Tab Control
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
wk.add({
  { "<C-a>",  require'dial.map'.inc_normal(),  icon = " ", desc = "Increment vars" },
  { "<C-x>",  require'dial.map'.dec_normal(),  icon = " ", desc = "Decrement vars" },
  { "g<C-a>", require'dial.map'.inc_gnormal(), icon = " ", desc = "Increment vars" },
  { "g<C-x>", require'dial.map'.dec_gnormal(), icon = " ", desc = "Decrement vars" },

  { "<C-a>",  require'dial.map'.inc_visual(),  mode = "v", icon = " ", desc = "Increment vars" },
  { "<C-x>",  require'dial.map'.dec_visual(),  mode = "v", icon = " ", desc = "Decrement vars" },
  { "g<C-a>", require'dial.map'.inc_gvisual(), mode = "v", icon = " ", desc = "Increment vars" },
  { "g<C-x>", require'dial.map'.dec_gvisual(), mode = "v", icon = " ", desc = "Decrement vars" },
}, opts)

---------------------------------------------------------------------------
-- 🛠  overseer.nvim: Task Runner: <Leader> + r
---------------------------------------------------------------------------
wk.add({
  { "<Leader>r", group = "Task Runner", icon = "✅  " },

  -- Async commands
  { "<Leader>rg", "<CMD>cclose | grep <cword><CR>", icon = " ", desc = "Grep cursor word asynchronously" },
  { "<Leader>rm", "<CMD>Make<CR>",                  icon = " ", desc = "Run make asynchronously" },

  -- overseed.nvim commands
  { "<Leader>ri", "<CMD>OverseerInfo<CR>",        icon = " ", desc = "Display overseer.nvim Info" },
  { "<Leader>rr", "<CMD>OverseerRun<CR>",         icon = " ", desc = "Run a task from a template" },
  { "<Leader>rl", "<CMD>OverseerRestartLast<CR>", icon = " ", desc = "Restart Last Action" },
  { "<Leader>ra", "<CMD>OverseerTaskAction<CR>",  icon = " ", desc = "Select a task to run an action on" },
  { "<Leader>rq", "<CMD>OverseerQuickAction<CR>", icon = " ", desc = "Run an action on the most recent task" },
  { "<Leader>rw", "<CMD>OverseerToggle<CR>",      icon = " ", desc = "Toggle overseer window" },
}, opts)

---------------------------------------------------------------------------
-- fzf-lua: <Leader> + f
---------------------------------------------------------------------------
if not is_vscode then
  wk.add({
    { "<Leader>f", group = "fzf-lua: Fuzzy Finder", icon = "🔎 " },

    -- Builtin
    { "<Leader>ff", "<CMD>FzfLua files<CR>",      icon = " ", desc = "Find Files (cwd)" },
    { "<Leader>fr", "<CMD>FzfLua resume<CR>",     icon = " ", desc = "Resume Previous Picker" },
    { "<Leader>fk", "<CMD>FzfLua keymaps<CR>",    icon = " ", desc = "Keymaps" },
    { "<Leader>fo", "<CMD>FzfLua oldfiles<CR>",   icon = " ", desc = "Recent files" },
    { "<Leader>fw", "<CMD>FzfLua grep_cword<CR>", icon = " ", desc = "grep with cword" },
    { "<Leader>fW", "<CMD>FzfLua grep_cWORD<CR>", icon = " ", desc = "grep with cWORD" },

    { "<Leader>fhs", "<CMD>FzfLua search_history<CR>",  icon = " ", desc = "Search History" },
    { "<Leader>fhc", "<CMD>FzfLua command_history<CR>", icon = " ", desc = "Command History" },

    -- Grep
    { "<C-g>",      "<CMD>FzfLua live_grep<CR>",                    icon = " ", desc = "Live Grep" },
    { "<Leader>fg", "<CMD>FzfLua grep<CR>",        mode = "n", icon = " ", desc = "Grep (Normal)" },
    { "<Leader>fg", "<CMD>FzfLua grep_visual<CR>", mode = "v", icon = " ", desc = "Grep (Visual)" },

    -- Vim
    { "<Leader>fH", "<CMD>FzfLua help_tags<CR>", icon = " ", desc = "Help via fzf-lua" },
    { "<Leader>fq", "<CMD>FzfLua quickfix<CR>",  icon = " ", desc = "Quickfix list" },
    { "<Leader>fa", "<CMD>FzfLua autocmds<CR>",  icon = " ", desc = "autocmds list" },
    { "<Leader>fR", "<CMD>FzfLua registers<CR>", icon = " ", desc = "Register list" },
    { "<Leader>fj", "<CMD>FzfLua jumps<CR>",     icon = " ", desc = "Jump list" },
    { "<Leader>fb", "<CMD>FzfLua buffers sort_mru=true sort_lastused=true<CR>", icon = " ", desc = "Buffers" },

    -- Git
    { "<Leader>gf", "<CMD>FzfLua git_files<CR>",   icon = " ", desc = "Find files (Git)" },
    { "<Leader>gs", "<CMD>FzfLua git_status<CR>",  icon = " ", desc = "Git Status" },
    { "<Leader>gc", "<CMD>FzfLua git_commits<CR>", icon = " ", desc = "Git Commits" },

    -- LSP
    { "<Leader>ls", "<CMD>FzfLua lsp_document_symbols<CR>", icon = " ", desc = "Go to Symbols" },
    { "<Leader>ld", "<CMD>FzfLua lsp_definitions<CR>",      icon = " ", desc = "Go to Definition" },
    { "<Leader>lt", "<CMD>FzfLua lsp_type_defs<CR>",        icon = " ", desc = "Go to Type Definition" },
    { "<Leader>lr", "<CMD>FzfLua lsp_references<CR>",       icon = " ", desc = "References" },
    { "<Leader>lc", "<CMD>FzfLua lsp_code_actions<CR>",     icon = " ", desc = "Code Actions" },

    -- DAP
    { "<Leader>fdb", "<CMD>FzfLua dap_breakpoints<CR>",    icon = " ", desc = "Breakpoints" },
    { "<Leader>fdc", "<CMD>FzfLua dap_configurations<CR>", icon = " ", desc = "Debug Config" },
    { "<Leader>fdC", "<CMD>FzfLua dap_commands<CR>",       icon = " ", desc = "DAP Commands" },
    { "<Leader>fdv", "<CMD>FzfLua dap_variables<CR>",      icon = " ", desc = "Debug Variables" },

    -- Custom Actions
    { "<Leader>fs", "<CMD>lua require'utils.finder'.search_snippets()<CR>", icon = " ", desc = "LuaSnip Browser" },
    { "<Leader>fl", "<CMD>lua require'utils.finder'.search_plugins()<CR>",  icon = " ", desc = "lazy.nvim Browser" },

    { "<Leader>fn", "<CMD>lua require'snacks'.notifier.show_history()<CR>", icon = " ", desc = "Notify History" },

    { "<Leader>ft", "<CMD>TodoFzfLua<CR>", icon = " ", desc = "TODO list" },
  })
end

---------------------------------------------------------------------------
-- 🚦 LSP: Language Server Protocol: <Leader> + l
---------------------------------------------------------------------------
wk.add({
  { "K", "<NOP" },
  { "<Leader>P", "<CMD>Lazy<CR>",                        icon = " ", desc = "Open lazy.nvim Window" },
  { "<Leader>M", "<CMD>Mason<CR>",                       icon = " ", desc = "Open mason.nvim Window" },
  { "g[",  "<CMD>Lspsaga diagnostic_jump_prev<CR>",      icon = " ", desc = "Go to prev diagnostics" },
  { "g]",  "<CMD>Lspsaga diagnostic_jump_next<CR>",      icon = " ", desc = "Go to next diagnostics" },
  { "gh",  "<CMD>LspInlayHintsToggle<CR>",               icon = " ", desc = "Toggle Inlay Hints" },
  { "go",  "<CMD>Lspsaga outline<CR>",                   icon = " ", desc = "Code outline" },
  { "gn",  "<CMD>Lspsaga rename<CR>",                    icon = " ", desc = "Rename" },
  { "gci", "<CMD>Lspsaga incoming_calls<CR>",            icon = " ", desc = "Call incoming hierarchy" },
  { "gco", "<CMD>Lspsaga outcoming_calls<CR>",           icon = " ", desc = "Call outcoming hierarchy" },

  { "ga", "<CMD>Lspsaga code_action<CR>", mode = nv, icon = " ", desc = "Code Action" },

  { "<Leader>l", group = "LSP", icon = "🚦 " },
  { "<Leader>li", "<CMD>LspInfo<CR>",                             icon = " ", desc = "Display LSP Info" },
}, opts)

---------------------------------------------------------------------------
-- 🐛  DAP: Debugger Adapter Protocol: <Leader> + d
---------------------------------------------------------------------------
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

  { "<Leader>dd", "<CMD>lua require'dapui'.toggle({reset = true})<CR>", icon = ":", desc = "Toggle Debugger UI" },
  { "<Leader>dp", "<CMD>lua require'dap.ui.widgets'.preview()<CR>",     icon = " ", desc = "DAP Preview" },
  { "<Leader>dh", "<CMD>lua require'dap.ui.widgets'.hover()<CR>",       icon = " ", desc = "Hover DAP widgets" },
  { "<Leader>dL", "<CMD>lua require'dap'.run_last()<CR>",               icon = "↻ ", desc = "Run Last" },
  { "<Leader>ds", "<CMD>lua require'dapui'.float('scope')<CR>",         icon = " ", desc = "Float scopes" },
  { "<Leader>dS", "<CMD>lua require'dapui'.float('stacks')<CR>",        icon = " ", desc = "Float stacks" },
  { "<Leader>dw", "<CMD>lua require'dapui'.float('watches')<CR>",       icon = " ", desc = "Float watches" },
  { "<Leader>dl", "<CMD>vsplit ~/.cache/nvim/dap.log<CR>",              icon = "󰌱", desc = "Open DAP log" },

  { "<Leader>dv", "<CMD>lua require'osv'.launch({port=8086})<CR>", icon = "", desc = "Launch Lua debugger w/ OSV" },
}, opts)

---------------------------------------------------------------------------
-- Git: <Leader> + g
---------------------------------------------------------------------------
require("utils.git")

wk.add({
  { "<Leader>g", group = "Git Integration", icon = " " },
  { "<Leader>gb", "<CMD>GitBlameLine<CR>",     icon = " ", desc = "Git Blame Line" },

  {
    "<Leader>gg",
    "<CMD>lua require'toggleterm.terminal'.Terminal:new({cmd='lazygit',hidden=true,direction='float'}):toggle()<CR>",
    mode = nt,
    icon = " ",
    desc = "Toggle lazygit w/ terminal",
  },
  {
    "<Leader>gh",
    "<CMD>lua require'toggleterm.terminal'.Terminal:new({cmd='gh dash',hidden=true,direction='float'}):toggle()<CR>",
    mode = nt,
    icon = " ",
    desc = "Toggle gh dash w/ terminal",
  },
}, opts)

---------------------------------------------------------------------------
-- 🤖  AI Interaction: <Leader> + c
---------------------------------------------------------------------------
if not is_vscode then
  require("utils.ai")
  -- Abbreviation
  vim.cmd[[
    cnoreabbrev cc  CodeCompanion
    cnoreabbrev ccc CodeCompanionChat
    cnoreabbrev cca CodeCompanionActions
  ]]

  -- codecompanion.nvim
  wk.add({
    mode = nv,
    { "<Leader>c", group = "AI Code Assistant", icon = "🤖 " },
    { "<Leader>ci", "<CMD>CodeCompanion<CR>",            icon = " ", desc = "Inline Prompt" },
    { "<Leader>cw", "<CMD>CodeCompanionChat Toggle<CR>", icon = " ", desc = "Toggle Chat Window" },
    { "<Leader>ca", "<CMD>CodeCompanionActions<CR>",     icon = " ", desc = "Code completion action" },
    { "<Leader>cA", "<CMD>CodeCompanionChat Add<CR>",    icon = " ", desc = "Add Code to Chat" },

    -- Builtin prompt libraries
    { "<Leader>cb", "<CMD>CodeCompanion /buffer<CR>",  icon = " ", desc = "Send the current buffer" },
    { "<Leader>cc", "<CMD>CodeCompanion /commit<CR>",  icon = " ", desc = "Commit message" },
    { "<Leader>ce", "<CMD>CodeCompanion /explain<CR>", icon = " ", desc = "Explain how selected code" },
    { "<Leader>cf", "<CMD>CodeCompanion /fix<CR>",     icon = " ", desc = "Fix the selected code" },
    { "<Leader>cl", "<CMD>CodeCompanion /lsp<CR>",     icon = " ", desc = "Explain the LSP diagnostics" },
    { "<Leader>cT", "<CMD>CodeCompanion /terinal<CR>", icon = " ", desc = "" },
    { "<Leader>ct", "<CMD>CodeCompanion /tests<CR>",   icon = " ", desc = "Generate unit tests for selected code" },

    -- Custom prompt libraries
    { "<Leader>cd",  "<CMD>CodeCompanion /doc<CR>",       icon = " ", desc = "Generate docs to selected code" },
    { "<Leader>crc", "<CMD>CodeCompanion /refchat<CR>",   icon = " ", desc = "Refactor in chat window" },
    { "<Leader>cri", "<CMD>CodeCompanion /refinline<CR>", icon = " ", desc = "Refactor inline" },
    { "<Leader>cR",  "<CMD>CodeCompanion /review<CR>",    icon = " ", desc = "Review code in buffer" },
  }, opts)
end

---------------------------------------------------------------------------
---File Explorer: <Leader> + e
-----------------------------------------------------------------------
if not is_vscode then
  wk.add({
    mode = nt,
    { "<Leader>e", group = "Explore Directory & Files", icon = "📁 " },
    { "<Leader>eo", ":Oil<Space>",                                          icon = " ", desc = "Explore dir" },
    { "<Leader>ef", "<CMD>lua require'oil'.toggle_float()<CR>",             icon = " ", desc = "Parent Dir" },
    { "<Leader>er", "<CMD>lua require'oil'.toggle_float(vim.uv.cwd())<CR>", icon = " ", desc = "Root Dir" },
    { "<Leader>eh", "<CMD>lua require'oil'.toggle_hidden()<CR>",            icon = " ", desc = "Toggle Hidden" },
  }, opts)
end

---------------------------------------------------------------------------
-- Others:
---------------------------------------------------------------------------

if not is_vscode then
  -- Toggle Plugin
  wk.add({
    { ",/", "<CMD>HlSearchLensToggle<CR>", icon = " ", desc = "Toggle Hlsearch lens"  },
    { ",m", "<CMD>TSJToggle<CR>",          icon = " ", desc = "Toggle node under cursor" },
    { ",c", "<CMD>ColorizerToggle<CR>",    icon = " ", desc = "Toggle Colorizer" },

    { ",x", "<CMD>Trouble diagnostics toggle<CR>", icon = " ", desc = "Toggle Diagnostics" },
    { ",X", "<CMD>Trouble symbols toggle<CR>",     icon = " ", desc = "Toggle Symbols" },
    { ",q", "<CMD>Trouble qflist toggle<CR>",      icon = " ", desc = "Toggle Quickfix list" },

    { ",t", "<CMD>ToggleTerm<CR>",   mode = nt, icon = " ", desc = "Toggle Terminal" },

    { ",z", "<CMD>lua require'snacks'.zen.zoom()<CR>",   icon = " ", desc = "Toggle Zoom"},
    { ",Z", "<CMD>lua require'snacks'.toggle.zen()<CR>", icon = " ", desc = "Toggle Zen mode"},
    {
      ",b",
      "<CMD>lua require'toggleterm.terminal'.Terminal:new({cmd='btm',hidden=true,direction='float'}):toggle()<CR>",
      mode = nt,
      icon = " ",
      desc = "Open `btm` command w/ terminal",
    },
  }, opts)
end
