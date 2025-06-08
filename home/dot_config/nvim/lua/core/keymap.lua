---------------------------------------------------------------------------
-- Binding Rules:
-- Builtin keymap: <Leader> + h: help, H: history, b: Buffer, t: Tab, w: Window
-- LSP keymap:    `<Leader> + l`
-- DAP keymap:    `<Leader> + d`
-- Git Keymap:    `<Leader> + g`
-- Fuzzy Finder:  `<Leader> + f`
-- Task Runner:   `<Leader> + o`
-- File Explorer: `<Leader> + e`
-- Toggle keymap  `,`
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
-- Command line
---------------------------------------------------------------------------
wk.add({
  mode = "n",
  { "<Leader>;", ":lua<Space>", icon = " ", desc = "Open lua prompt" },
})

---------------------------------------------------------------------------
-- Cursor
---------------------------------------------------------------------------
wk.add({
  { "jj", "<ESC>", mode = "i", icon = " ", desc = "Return to NORMAL mode" },
  { "kk", "<ESC>", mode = "i", icon = " ", desc = "Return to NORMAL mode" },

  { "s", "<CMD>lua require'flash'.jump()<CR>",              mode = nxo, icon = " ", desc = "Flash" },
  { "S", "<CMD>lua require'flash'.treesitter()<CR>",        mode = nxo, icon = " ", desc = "Flash Treesitter" },
  { "<Leader><Leader>", group = "flash.nvim", icon = "⚡️ " },
  { "<Leader><Leader>w", "<CMD>FlashJumpWord<CR>", icon = " ", desc = "Jump to the word" },
  { "<Leader><Leader>l", "<CMD>FlashJumpLine<CR>", icon = " ", desc = "Jump to the line" },

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
  -- Buffer Naigation
  { "<Leader>b", group = "Buffer Navigation", icon = "🖥 " },
  { "[b",         "<CMD>bprev<CR>",                        icon = " ", desc = "Move to prev buffer" },
  { "]b",         "<CMD>bnext<CR>",                        icon = " ", desc = "Move to next buffer" },
  { "]B",         "<CMD>BufferLineMoveNext<CR>",           icon = " ", desc = "Move to next buffer" },
  { "[B",         "<CMD>BufferLineMovePrev<CR>",           icon = " ", desc = "Move to prev buffer" },
  { "<Leader>bd", "<CMD>lua Snacks.bufdelete()<CR>",       icon = " ", desc = "Delete current buffer" },
  { "<Leader>bD", "<CMD>lua Snacks.bufdelete.other()<CR>", icon = " ", desc = "Delete other buffers" },

  { ";j", "<CMD>resize -3<CR>",          icon = " ", desc = "Decrease window height" },
  { ";k", "<CMD>resize +3<CR>",          icon = " ", desc = "Increase window height" },
  { ";h", "<CMD>vertical resize -3<CR>", icon = " ", desc = "Decrease window width" },
  { ";l", "<CMD>vertical resize +3<CR>", icon = " ", desc = "Increase window width" },

  -- Tab Navigation
  { "[t", "<CMD>tabprev<CR>",  icon = " ", desc = "Move to prev tab" },
  { "]t", "<CMD>tabnext<CR>",  icon = " ", desc = "Move to next tab" },
  { "[1", "<CMD>tabfirst<CR>", icon = " ", desc = "Move to First tab" },
  { "]9", "<CMD>tablast<CR>",  icon = " ", desc = "Move to Last tab" },

  -- Tab Control
  { "<Leader>t", group = "Tab", icon = "📑 " },
  { "<Leader>tc", "<CMD>tabclose<CR>", icon = " ", desc = "Close current tab" },
  { "<Leader>te", ":tabedit<Space>",   icon = " ", desc = "Edit file in new tab" },
  { "<Leader>tn", ":tabnew<Space>",    icon = " ", desc = "Edit file in new tab" },

  -- Window Control
  { "[w", "<C-w>h", icon = " ", desc = "Move to Left  Window" },
  { "]w", "<C-w>l", icon = " ", desc = "Move to Right Window" },

  { "<Leader>w", group = "Window Control", icon = "📖 " },
  { "<Leader>ws", ":split<Space>",  icon = " ", desc = "Split window horizontally" },
  { "<Leader>wS", ":vsplit<Space>", icon = " ", desc = "Split window vertically" },
}, opts)

---------------------------------------------------------------------------
-- 🔖  LuaSnip
---------------------------------------------------------------------------
wk.add({
  { "<Leader>fs", "<CMD>LuaSnipBrowse<CR>", icon = " ", desc = "Browse LuaSnip snippets" },

  { "<Leader>s", group = "Snippets", icon = "🔖 " },
  { "<Leader>sr", "<CMD>LuaSnipReload<CR>", icon = " ", desc = "Reload LusSnip config" },
  { "<Leader>se", "<CMD>LuaSnipEdit<CR>",   icon = " ", desc = "Edit LuaSnip file" },
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
  { "<Leader>rg", "<CMD>cclose | Grep <cword><CR>", icon = " ", desc = "Grep cursor word asynchronously" },
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
-- 📂 Fuzzy Finder: <Leader> + f
---------------------------------------------------------------------------
if not is_vscode then
  wk.add({
    { "<Leader>f", group = "Fuzzy Finder", icon = "🔎 " },

    -- Builtin
    { "<Leader>ff", "<CMD>lua Snacks.picker.smart()<CR>",    icon = " ", desc = "Frecency Search" },
    { "<Leader>f.", "<CMD>lua Snacks.picker.resume()<CR>",   icon = " ", desc = "Resume Prev Picker" },
    { "<Leader>fk", "<CMD>lua Snacks.picker.keymaps()<CR>",  icon = " ", desc = "Keymaps" },
    { "<Leader>fb", "<CMD>lua Snacks.picker.buffers()<CR>",  icon = " ", desc = "Buffers" },
    { "<Leader>fc", "<CMD>lua Snacks.picker.commands()<CR>", icon = " ", desc = "Commands" },
    { "<Leader>fp", "<CMD>lua Snacks.picker.projects()<CR>", icon = " ", desc = "Project" },

    { "<Leader>fn", "<CMD>lua Snacks.picker.notifications()<CR>",   icon = " ", desc = "Notify History" },
    { "<Leader>f/", "<CMD>lua Snacks.picker.search_history()<CR>",  icon = " ", desc = "Search History" },
    { "<Leader>f:", "<CMD>lua Snacks.picker.command_history()<CR>", icon = " ", desc = "Command History" },

    -- Grep
    { "<C-g>",      "<CMD>lua Snacks.picker.grep({ live = true })<CR>",  icon = " ", desc = "Live Grep" },
    { "<Leader>fw", "<CMD>lua Snacks.picker.grep_word()<CR>", mode = nx, icon = " ", desc = "grep with cword" },

    -- Vim
    { "<Leader>fh", "<CMD>lua Snacks.picker.help()<CR>",       icon = " ", desc = "Help" },
    { "<Leader>fq", "<CMD>lua Snacks.picker.qflist()<CR>",     icon = " ", desc = "Quickfix list" },
    { "<Leader>fl", "<CMD>lua Snacks.picker.loclist()<CR>",    icon = " ", desc = "Location list" },
    { "<Leader>fa", "<CMD>lua Snacks.picker.autocmds()<CR>",   icon = " ", desc = "autocmds list" },
    { "<Leader>fr", "<CMD>lua Snacks.picker.registers()<CR>",  icon = " ", desc = "Register list" },
    { "<Leader>fu", "<CMD>lua Snacks.picker.undo()<CR>",       icon = " ", desc = "Undo Tree" },
    { "<Leader>fH", "<CMD>lua Snacks.picker.highlights()<CR>", icon = " ", desc = "Hilight list" },

    -- Git
    { "<Leader>gf", "<CMD>lua Snacks.picker.git_files()<CR>",  icon = " ", desc = "Git Files" },
    { "<Leader>gs", "<CMD>lua Snacks.picker.git_status()<CR>", icon = " ", desc = "Git Status" },
    { "<Leader>gl", "<CMD>lua Snacks.picker.git_log()<CR>",    icon = " ", desc = "Commit Log" },

    -- LSP
    { "<Leader>fd", "<CMD>lua Snacks.picker.diagnostics()<CR>",          icon = " ", desc = "Diagnostics" },
    { "<Leader>ls", "<CMD>lua Snacks.picker.lsp_symbols()<CR>",          icon = " ", desc = "Symbols" },
    { "<Leader>ld", "<CMD>lua Snacks.picker.lsp_definitions()<CR>",      icon = " ", desc = "Definition" },
    { "<Leader>lt", "<CMD>lua Snacks.picker.lsp_type_definitions()<CR>", icon = " ", desc = "Type Definition" },
    { "<Leader>lr", "<CMD>lua Snacks.picker.lsp_references()<CR>",       icon = " ", desc = "References" },

    -- DAP
    -- TODO: Replace DAP commands with `Snacks.picker.*()`
    -- { "<Leader>fdb", "<CMD>FzfLua dap_breakpoints<CR>",    icon = " ", desc = "Breakpoints" },
    -- { "<Leader>fdc", "<CMD>FzfLua dap_configurations<CR>", icon = " ", desc = "Debug Config" },
    -- { "<Leader>fdC", "<CMD>FzfLua dap_commands<CR>",       icon = " ", desc = "DAP Commands" },
    -- { "<Leader>fdv", "<CMD>FzfLua dap_variables<CR>",      icon = " ", desc = "Debug Variables" },

    -- Others
    { "<Leader>fi", "<CMD>lua Snacks.picker.icons()<CR>", icon = " ", desc = "Search Icons" },
    {
      "<Leader>fL",
      "<CMD>lua Snacks.picker.smart({cwd = vim.fn.stdpath('data') .. '/lazy'})<CR>",
      icon = " ",
      desc = "nvim plugins",
    },
    { "<Leader>ft", "<CMD>lua Snacks.picker.todo_comments()<CR>", icon = " ", desc = "TODO list" },
  })
end

---------------------------------------------------------------------------
-- 🚦 LSP: Language Server Protocol: <Leader> + l
---------------------------------------------------------------------------
wk.add({
  { "<Leader>L",  "<CMD>Lazy<CR>",  icon = " ", desc = "Open lazy.nvim Window" },
  { "<Leader>M",  "<CMD>Mason<CR>", icon = " ", desc = "Open mason.nvim Window" },

  { "<Leader>l", group = "LSP", icon = "🚦 " },
  { "<Leader>li", "<CMD>lua Snacks.picker.lsp_config()<CR>", icon = " ", desc = "Display LSP Info" },

  { "g[",  "<CMD>lua vim.diagnostic.jump({count=-1,float=true })<CR>", icon = " ", desc = "Go to prev diagnostics" },
  { "g]",  "<CMD>lua vim.diagnostic.jump({count=1, float=true })<CR>", icon = " ", desc = "Go to next diagnostics" },

  { "gci", "<CMD>lua vim.lsp.buf.incoming_calls()<CR>",  icon = " ", desc = "Call incoming hierarchy" },
  { "gco", "<CMD>lua vim.lsp.buf.outcoming_calls()<CR>", icon = " ", desc = "Call outcoming hierarchy" },

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
  -- { "<Leader>gb", "<CMD>GitBlameLine<CR>",     icon = " ", desc = "Git Blame Line" },

  { "<Leader>gg", "<CMD>lua Snacks.lazygit()<CR>", mode = nt, icon = " ", desc = "Toggle lazygit" },
}, opts)

---------------------------------------------------------------------------
-- octo.nvim: <Leader> + o
---------------------------------------------------------------------------
if not is_vscode then
  wk.add({
    { "<Leader>o", group = "octo.nvim", icon = " " },
    { "<Leader>O",  ":Octo<Space>", icon = " ", desc = "Open Octo" },

    -- Issues
    { "<Leader>gi", group = "Issues cmd via octo.nvim", icon = " " },
    { "<Leader>gis", "<CMD>Octo issue search involves:@me state:open<CR>", icon = " ", desc = "Issues involves @me" },
    { "<Leader>gic", "<CMD>Octo issue create<CR>",                         icon = " ", desc = "Create new issue" },

    -- Pull Request
    { "<Leader>gp", group = "Pull Request cmd via octo.nvim", icon = " " },
    { "<Leader>gpr", "<CMD>Octo pr search involves:@me state:open<CR>", icon = " ", desc = "PRs involves @me" },
    { "<Leader>gpc", "<CMD>Octo pr create<CR>",                         icon = " ", desc = "Create new PR" },
    { "<Leader>gpd", "<CMD>Octo pr diff<CR>",                           icon = " ", desc = "Show PR diff" },
    { "<Leader>gpC", "<CMD>Octo pr changes<CR>",                        icon = " ", desc = "Show all PR changes" },
  })
end

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
    { "<Leader>c", group = "AI Code Assistant", icon = "🤖 " },
    { "<Leader>ci", "<CMD>CodeCompanion<CR>",            mode = nv,  icon = " ", desc = "Inline Prompt" },
    { "<Leader>cw", "<CMD>CodeCompanionChat Toggle<CR>", mode = nv,  icon = " ", desc = "Toggle Chat Window" },
    { "<Leader>ca", "<CMD>CodeCompanionActions<CR>",     mode = nv,  icon = " ", desc = "Code completion action" },
    { "<Leader>cA", "<CMD>CodeCompanionChat Add<CR>",    mode = "v", icon = " ", desc = "Add Code to Chat" },

    -- Builtin prompt libraries
    { "<Leader>cb", "<CMD>CodeCompanion /buffer<CR>",   mode = nv, icon = " ", desc = "Send the current buffer" },
    { "<Leader>cc", "<CMD>CodeCompanion /commit<CR>",   mode = nv, icon = " ", desc = "Commit message" },
    { "<Leader>ce", "<CMD>CodeCompanion /explain<CR>",  mode = nv, icon = " ", desc = "Explain how selected code" },
    { "<Leader>cf", "<CMD>CodeCompanion /fix<CR>",      mode = nv, icon = " ", desc = "Fix the selected code" },
    { "<Leader>cl", "<CMD>CodeCompanion /lsp<CR>",      mode = nv, icon = " ", desc = "Explain LSP diagnostics" },
    { "<Leader>cT", "<CMD>CodeCompanion /terminal<CR>", mode = nv, icon = " ", desc = "Insert Terminal Output" },
    { "<Leader>ct", "<CMD>CodeCompanion /tests<CR>",    mode = nv, icon = " ", desc = "Generate unit tests" },

    -- Custom prompt libraries
    { "<Leader>cd",  "<CMD>CodeCompanion /doc<CR>",       mode = "v", icon = " ", desc = "Generate documentation" },
    { "<Leader>crc", "<CMD>CodeCompanion /refchat<CR>",   mode = "v", icon = " ", desc = "Refactor in chat window" },
    { "<Leader>cri", "<CMD>CodeCompanion /refinline<CR>", mode = "v", icon = " ", desc = "Refactor inline" },
    { "<Leader>cR",  "<CMD>CodeCompanion /review<CR>",    mode = "v", icon = " ", desc = "Review code in buffer" },
    { "<Leader>cg",  "<CMD>CodeCompanion /grammar<CR>",   mode = "v", icon = " ", desc = "Correct Grammar" },

    -- Other command
    { "<Leader>chs", "<CMD>CodeCompanionHistorySave<CR>", mode = nv, icon = " ", desc = "Save chat history" },
    { "<Leader>chl", "<CMD>CodeCompanionHistoryLoad<CR>", mode = nv, icon = " ", desc = "Load chat history" },

    -- MCP Integration
    { "<Leader>m", "<CMD>MCPHub<CR>", icon = " ", desc = "Open MCPHub window" },
  }, opts)
end

---------------------------------------------------------------------------
---File Explorer: <Leader> + e
-----------------------------------------------------------------------
if not is_vscode then
  wk.add({
    mode = nt,
    { "<Leader>e", group = "Explore Directory & Files", icon = "📁 " },
    { "<Leader>ee", "<CMD>Oil --float .<CR>", icon = " ", desc = "Explore Directory" },
    { "<Leader>ef", "<CMD>Oil --float<CR>",   icon = " ", desc = "Open Parent Directory" },
  }, opts)
end

---------------------------------------------------------------------------
-- Feed: <Leader> + n
---------------------------------------------------------------------------
if not is_vscode then
  wk.add({
    mode = "n",
    { "<Leader>n", group = "feed.nvim", icon = "📰 " },
    { "<Leader>nm", "<CMD>Feed<CR>",        icon = " ", desc = "Feed menu" },
    { "<Leader>ni", "<CMD>Feed index<CR>",  icon = " ", desc = "Feed index" },
    { "<Leader>nu", "<CMD>Feed update<CR>", icon = "󰚰 ", desc = "Update Feed" },
    { "<Leader>nl", "<CMD>Feed list<CR>",   icon = "󰚰 ", desc = "Show feed list" },
    { "<Leader>ns", "<CMD>Feed sync<CR>",   icon = "󰚰 ", desc = "Sync feed" },
    { "<Leader>nS", "<CMD>Feed sync!<CR>",  icon = "󰚰 ", desc = "Sync feed" },
  })
end

---------------------------------------------------------------------------
-- Others:
---------------------------------------------------------------------------
if not is_vscode then
  -- Toggle Plugin
  wk.add({
    { ",s", "<CMD>ToogleCopilotSuggest<CR>", mode = { "n", "i" }, icon = " ", desc = "Toggle Copilot suggesion" },

    { ",/", "<CMD>HlSearchLensToggle<CR>", icon = " ", desc = "Toggle Hlsearch lens"  },
    { ",m", "<CMD>TSJToggle<CR>",          icon = " ", desc = "Toggle node under cursor" },
    { ",c", "<CMD>ColorizerToggle<CR>",    icon = " ", desc = "Toggle Colorizer" },
    { ",C", "<CMD>ToggleOneDarkStyle<CR>", icon = " ", desc = "Toggle theme style" },

    { ",x", "<CMD>Trouble diagnostics toggle<CR>",      icon = " ", desc = "Toggle Diagnostics" },
    { ",X", "<CMD>Trouble symbols toggle<CR>",          icon = " ", desc = "Toggle Symbols" },
    { ",q", "<CMD>cclose | Trouble qflist toggle<CR>",  icon = " ", desc = "Toggle Quickfix list" },
    { ",l", "<CMD>lclose | Trouble loclist toggle<CR>", icon = " ", desc = "Toggle Location list" },

    { ",f", "<CMD>lua Snacks.explorer()<CR>",                    icon = " ", desc = "Toggle File Explorer"},
    { ",h", "<CMD>lua Snacks.toggle.inlay_hints():toggle()<CR>", icon = " ", desc = "Toggle Inlay Hints" },
    { ",d", "<CMD>lua Snacks.toggle.dim():toggle()<CR>",         icon = " ", desc = "Toggle Dim mode"},
    { ",z", "<CMD>lua Snacks.toggle.zen():toggle()<CR>",         icon = " ", desc = "Toggle Zen mode"},
    { ",t", "<CMD>lua Snacks.terminal()<CR>",        mode = nt,  icon = " ", desc = "Toggle Terminal" },
    { ",b", "<CMD>lua Snacks.terminal({'btm'})<CR>", mode = nt,  icon = " ", desc = "Toggle btm w/ terminal" },
    { ",n", "<CMD>lua Snacks.toggle.line_number():toggle()<CR>", icon = " ", desc = "Toggle Line Number" },
  }, opts)
end
