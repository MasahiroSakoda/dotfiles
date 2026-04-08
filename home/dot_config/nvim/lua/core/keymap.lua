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
local nx, nt, nxo, o, ox, c = {"n", "x"}, {"n", "t"}, {"n", "x", "o"}, {"o"}, {"o", "x"}, {"c"}

local ok, wk = pcall(require, "which-key")
if not ok then vim.notify("Failed loading " .. "which-key", vim.log.levels.WARN) end

-- Abbreviation for typo
vim.cmd.cnoreabbrev("Q!", "q!")
vim.cmd.cnoreabbrev("q1", "q!")
vim.cmd.cnoreabbrev("Q1", "q!")
vim.cmd.cnoreabbrev("W!", "w!")
vim.cmd.cnoreabbrev("Wq", "wq")
vim.cmd.cnoreabbrev("WQ", "wq")

-- Workaround overlapping with `gc`
vim.keymap.del("n", "gc")

---------------------------------------------------------------------------
-- Groups
---------------------------------------------------------------------------
wk.add({
  { "[",  group = "Prev",        icon = "󰒮 ", desc = " Prev" },
  { "]",  group = "Next",        icon = "󰒭 ", desc = " Next" },
  { "g",  group = "Go to",       icon = " ", desc = " Go to" },
  { "gr", group = "LSP Actions", icon = " ", desc = " LSP Actions" },
  { "gs", group = "Surround",    icon = "󰅪 ", desc = " Surround" },
  { "gS", group = "Surround",    icon = "󰅪 ", desc = " Surround" },
  { "z",  group = "Fold",        icon = " ", desc = " Fold / Cursor" },
  { "\\", group = "Toggle",      icon = " ", desc = " Toggle keymaps" },

  { "<Leader>c", group = "Call Hierarchy", icon = " ", desc = " Call Hierarchy" },
})

---------------------------------------------------------------------------
-- which-key: <Leader> + w
---------------------------------------------------------------------------
wk.add({
  { "<Leader>?", group = "Which-Key", icon = "⌨️ " },
  { "<Leader>??", "<CMD>WhichKey<CR>",            icon = " ", desc = " All maps" },
  { "<Leader>?l", "<CMD>WhichKey <Leader><CR>",   icon = " ", desc = " All <Leader> maps" },
  { "<Leader>?v", "<CMD>WhichKey <Leader> v<CR>", icon = " ", desc = " All <Leader> maps for VISUAL mode" },
}, opts)

---------------------------------------------------------------------------
-- Command line
---------------------------------------------------------------------------
wk.add({
  mode = "n",
  { "<Leader>:", ":lua<Space>", icon = " ", desc = " Lua prompt" },
})

---------------------------------------------------------------------------
-- Cursor
---------------------------------------------------------------------------
wk.add({
  { "jj", "<ESC>", mode = "i", icon = " ", desc = " Return to NORMAL mode" },
  { "kk", "<ESC>", mode = "i", icon = " ", desc = " Return to NORMAL mode" },

  { "[[", "<CMD>lua Snacks.words.jump(-vim.v.count1)<CR>", icon = "󰼨 ", desc = "Prev Reference" },
  { "]]", "<CMD>lua Snacks.words.jump(vim.v.count1)<CR>",  icon = "󰼧 ", desc = "Next Reference" },

  { "s",     "<CMD>lua require'flash'.jump()<CR>",              mode = nxo, icon = " ", desc = " Jump" },
  { "S",     "<CMD>lua require'flash'.treesitter()<CR>",        mode = nxo, icon = " ", desc = " Treesitter" },
  { "r",     "<CMD>lua require'flash'.remote()<CR>",            mode = o,   icon = " ", desc = " Remote" },
  { "R",     "<CMD>lua require'flash'.treesitter_search()<CR>", mode = ox,  icon = " ", desc = " Treesitter Search" },
  { "<C-s>", "<CMD>lua require'flash'.toggle()<CR>",            mode = c,   icon = " ", desc = " Toggle" },

  { "<Leader>jl", "<CMD>FlashJumpLine<CR>",  mode = nxo, icon = " ", desc = " Jump to the line" },
  { "<Leader>jw", "<CMD>FlashJumpWord<CR>",  mode = nxo ,icon = " ", desc = " Jump to the word" },
  { "<Leader>*",  "<CMD>FlashJumpCword<CR>", mode = nxo, icon = "󰀬 ", desc = " Jump to <cword>" },
  { "<Leader>.",  "<CMD>FlashJumpContinue<CR>",          icon = " ", desc = " Continue last search" },
}, opts)

---------------------------------------------------------------------------
-- Search
---------------------------------------------------------------------------
wk.add({
  mode = nx,
  { "n", "<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua require'hlslens'.start()<CR>" },
  { "N", "<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua require'hlslens'.start()<CR>" },

  { "#",   "#<CMD>lua require'hlslens'.start()<CR>",   icon = " ", desc = " Search backward" },
  { "*",   "*<CMD>lua require'hlslens'.start()<CR>",   icon = " ", desc = " Search forward" },
  { "g#",  "g#<CMD>lua require'hlslens'.start()<CR>",  icon = " ", desc = " Partial search backward" },
  { "g*",  "g*<CMD>lua require'hlslens'.start()<CR>",  icon = " ", desc = " Partial Search forward" },
  { "gz#", "gz#<CMD>lua require'hlslens'.start()<CR>", icon = " ", desc = " Partial search backward (in-place)" },
  { "gz*", "gz*<CMD>lua require'hlslens'.start()<CR>", icon = " ", desc = " Partial Search forward (in-place)" },
}, opts)

---------------------------------------------------------------------------
-- 📑  Tab / Buffer / Window
---------------------------------------------------------------------------
wk.add({
  -- Buffer Naigation
  { "<Leader>b", group = "Buffer Navigation", icon = "🖥 " },
  { "[b",         "<CMD>bprev<CR>",                        icon = " ", desc = " Move to prev buffer" },
  { "]b",         "<CMD>bnext<CR>",                        icon = " ", desc = " Move to next buffer" },
  { "]B",         "<CMD>BufferLineMoveNext<CR>",           icon = " ", desc = " Move to next buffer" },
  { "[B",         "<CMD>BufferLineMovePrev<CR>",           icon = " ", desc = " Move to prev buffer" },
  { "<Leader>bd", "<CMD>lua Snacks.bufdelete()<CR>",       icon = " ", desc = " Delete current buffer" },
  { "<Leader>bD", "<CMD>lua Snacks.bufdelete.other()<CR>", icon = " ", desc = " Delete other buffers" },
  { "<Leader>bs", "<CMD>lua Snacks.scratch()<CR>",         icon = " ", desc = " Create scratch buffer" },
  { "<Leader>bS", "<CMD>lua Snacks.scratch.select()<CR>",  icon = " ", desc = " Select scratch buffer" },


  { "<S-Up>",    "<CMD>resize -1<CR>",          icon = " ", desc = " Decrease window height" },
  { "<S-Down>",  "<CMD>resize +1<CR>",          icon = " ", desc = " Increase window height" },
  { "<S-Left>",  "<CMD>vertical resize -1<CR>", icon = " ", desc = " Decrease window width" },
  { "<S-Right>", "<CMD>vertical resize +1<CR>", icon = " ", desc = " Increase window width" },

  -- Tab Navigation
  { "[t", "<CMD>tabprev<CR>",  icon = " ", desc = " Move to prev tab" },
  { "]t", "<CMD>tabnext<CR>",  icon = " ", desc = " Move to next tab" },
  { "[1", "<CMD>tabfirst<CR>", icon = " ", desc = " Move to First tab" },
  { "]9", "<CMD>tablast<CR>",  icon = " ", desc = " Move to Last tab" },

  { "<C-1>", "1gt",   icon = "󰬺 ", desc = " Tab #1" },
  { "<C-2>", "2gt",   icon = "󰬻 ", desc = " Tab #2" },
  { "<C-3>", "3gt",   icon = "󰬼 ", desc = " Tab #3" },
  { "<C-4>", "4gt",   icon = "󰬽 ", desc = " Tab #4" },
  { "<C-5>", "5gt",   icon = "󰬾 ", desc = " Tab #5" },
  { "<C-6>", "6gt",   icon = "󰬿 ", desc = " Tab #6" },
  { "<C-7>", "7gt",   icon = "󰭀 ", desc = " Tab #7" },
  { "<C-8>", "8gt",   icon = "󰭁 ", desc = " Tab #8" },
  { "<C-9>", "9gt",   icon = "󰭂 ", desc = " Tab #9" },

  -- Tab Control
  { "<Leader>t", group = "Tab", icon = "📑 " },
  { "<Leader>tc", "<CMD>tabclose<CR>", icon = " ", desc = " Close current tab" },
  { "<Leader>te", ":tabedit<Space>",   icon = " ", desc = " Edit file in new tab" },
  { "<Leader>tn", ":tabnew<Space>",    icon = " ", desc = " Edit file in new tab" },

  -- Window Control
  { "[w", "<C-w>h", icon = " ", desc = " Move to Left  Window" },
  { "]w", "<C-w>l", icon = " ", desc = " Move to Right Window" },

  { "<Leader>w", group = "Window Control", icon = "📖 " },
  { "<Leader>-",     ":split<Space>",   icon = " ", desc = " Split window horizontally" },
  { "<Leader><Bar>", ":vsplit<Space>",  icon = " ", desc = " Split window vertically" },
  { "<Leader>w-",    "<CMD>split<CR>",  icon = " ", desc = " Split window below" },
  { "<Leader>w|",    "<CMD>vsplit<CR>", icon = " ", desc = " Split window right" },
  { "<Leader>w=",    "<C-w>=",          icon = "󰙖 ", desc = " Resize and make windows equal"},
  { "<Leaderww",     "<C-w>p",          icon = " ", desc = " Other window" },
  { "<Leaderwd",     "<C-w>c",          icon = "󱎘 ", desc = " Close window" },

  { "[x", "<CMD>lua require'todo-comments'.jump_prev()<CR>", icon = "󰒮 ", desc = " Prev TODOs" },
  { "]x", "<CMD>lua require'todo-comments'.jump_next()<CR>", icon = "󰒭 ", desc = " Next TODOs" },
}, opts)

---------------------------------------------------------------------------
-- dial.nvim: Increment/Decrement plugin: <C-a> or <C-x>
---------------------------------------------------------------------------
wk.add({
  { "<C-a>",  require'dial.map'.inc_normal(),  icon = " ", desc = " Increment vars" },
  { "<C-x>",  require'dial.map'.dec_normal(),  icon = " ", desc = " Decrement vars" },
  { "g<C-a>", require'dial.map'.inc_gnormal(), icon = " ", desc = " Increment vars" },
  { "g<C-x>", require'dial.map'.dec_gnormal(), icon = " ", desc = " Decrement vars" },

  { "<C-a>",  require'dial.map'.inc_visual(),  mode = "v", icon = " ", desc = " Increment vars" },
  { "<C-x>",  require'dial.map'.dec_visual(),  mode = "v", icon = " ", desc = " Decrement vars" },
  { "g<C-a>", require'dial.map'.inc_gvisual(), mode = "v", icon = " ", desc = " Increment vars" },
  { "g<C-x>", require'dial.map'.dec_gvisual(), mode = "v", icon = " ", desc = " Decrement vars" },
}, opts)

---------------------------------------------------------------------------
-- 🛠  overseer.nvim: Task Runner: <Leader> + o
---------------------------------------------------------------------------
wk.add({
  { "<Leader>o", group = "overseer.nvim", icon = "✅  " },

  -- Async commands
  { "<Leader>og", "<CMD>cclose | Grep <cword><CR>", icon = " ", desc = " Async grep <cword>" },
  { "<Leader>oG", "<CMD>cclose | Grep <CWORD><CR>", icon = " ", desc = " Async grep <CWORD>" },
  { "<Leader>om", "<CMD>cclose | Make<CR>",         icon = " ", desc = " Async make" },

  -- overseed.nvim commands
  { "<Leader>oi", "<CMD>OverseerInfo<CR>",        icon = " ", desc = " Display overseer.nvim Info" },
  { "<Leader>or", "<CMD>OverseerRun<CR>",         icon = " ", desc = " Run a task from a template" },
  { "<Leader>ol", "<CMD>OverseerRestartLast<CR>", icon = " ", desc = " Restart Last Action" },
  { "<Leader>oa", "<CMD>OverseerTaskAction<CR>",  icon = " ", desc = " Select a task to run an action on" },
  { "<Leader>oq", "<CMD>OverseerQuickAction<CR>", icon = " ", desc = " Run an action on the most recent task" },
  { "<Leader>ow", "<CMD>OverseerToggle<CR>",      icon = " ", desc = " Toggle overseer window" },
}, opts)

---------------------------------------------------------------------------
-- 📂 Fuzzy Finder: <Leader> + f
---------------------------------------------------------------------------
if not is_vscode then
  wk.add({
    { "<Leader>f", group = "Fuzzy Finder", icon = "🔎 " },

    -- Builtin
    { "<Leader>ff", "<CMD>lua Snacks.picker.smart()<CR>",    icon = " ", desc = " Smart Find Files" },
    { "<Leader>f.", "<CMD>lua Snacks.picker.resume()<CR>",   icon = " ", desc = " Resume Prev Picker" },
    { "<Leader>fk", "<CMD>lua Snacks.picker.keymaps()<CR>",  icon = " ", desc = " Keymaps" },
    { "<Leader>fb", "<CMD>lua Snacks.picker.buffers()<CR>",  icon = " ", desc = " Buffers" },
    { "<Leader>fc", "<CMD>lua Snacks.picker.commands()<CR>", icon = " ", desc = " Commands" },
    { "<Leader>fp", "<CMD>lua Snacks.picker.projects()<CR>", icon = " ", desc = " Project" },
    {
      "<Leader>F",
      "<CMD>lua Snacks.picker.smart({ cwd = vim.fn.expand('%:p:h') })<CR>",
      icon = " ",
      desc = " Browse Current Dir",
    },

    { "<Leader>fn", "<CMD>lua Snacks.picker.notifications()<CR>",   icon = " ", desc = " Notification History" },
    { "<Leader>f/", "<CMD>lua Snacks.picker.search_history()<CR>",  icon = " ", desc = " Search History" },
    { "<Leader>f:", "<CMD>lua Snacks.picker.command_history()<CR>", icon = " ", desc = " Command History" },

    -- Grep
    { "<C-g>",         "<CMD>lua Snacks.picker.grep()<CR>",                 icon = " ", desc = " Live Grep" },
    { "<Leader><C-g>", "<CMD>lua Snacks.picker.grep_word()<CR>", mode = nx, icon = " ", desc = " grep with cword" },

    -- Vim
    { "<Leader>f?",  "<CMD>lua Snacks.picker.help()<CR>",         icon = " ", desc = " Help" },
    { "<Leader>fq",  "<CMD>lua Snacks.picker.qflist()<CR>",       icon = " ", desc = " Quickfix list" },
    { "<Leader>fl",  "<CMD>lua Snacks.picker.loclist()<CR>",      icon = " ", desc = " Location list" },
    { "<Leader>fj",  "<CMD>lua Snacks.picker.jumps()<CR>",        icon = " ", desc = " Jump list" },
    { "<Leader>fa",  "<CMD>lua Snacks.picker.autocmds()<CR>",     icon = " ", desc = " autocmds list" },
    { "<Leader>f\"", "<CMD>lua Snacks.picker.registers()<CR>",    icon = " ", desc = " Register list" },
    { "<Leader>f'",  "<CMD>lua Snacks.picker.marks()<CR>",        icon = " ", desc = " Mark list" },
    { "<Leader>fu",  "<CMD>lua Snacks.picker.undo()<CR>",         icon = " ", desc = " Undo Tree" },
    { "<Leader>fh",  "<CMD>lua Snacks.picker.highlights()<CR>",   icon = " ", desc = " Highlight list" },
    { "<Leader>fC",  "<CMD>lua Snacks.picker.colorschemes()<CR>", icon = " ", desc = " Colorschemes" },
    { "<Leader>z=",  "<CMD>lua Snacks.picker.spelling()<CR>",     icon = "󰀬 ", desc = " Spelling Suggestions" },

    -- Git
    { "<Leader>gf", "<CMD>lua Snacks.picker.git_files()<CR>",             icon = " ", desc = " Git Files" },
    { "<Leader>gs", "<CMD>lua Snacks.picker.git_status()<CR>",            icon = " ", desc = " Git Status" },
    { "<Leader>gS", "<CMD>lua Snacks.picker.git_stash()<CR>",             icon = " ", desc = " Git Stash" },
    { "<Leader>gl", "<CMD>lua Snacks.picker.git_log()<CR>",               icon = " ", desc = " Commit Log" },
    { "<Leader>gd", "<CMD>lua Snacks.picker.git_diff({staged=true})<CR>", icon = " ", desc = " Diff (staged)" },
    { "<Leader>gb", "<CMD>lua Snacks.picker.git_branches()<CR>",          icon = " ", desc = " View branches" },

    -- GitHub
    { "<Leader>gi", "<CMD>lua Snacks.picker.gh_issue({})<CR>",            icon = " ", desc = " Opened issues" },
    { "<Leader>gI", "<CMD>lua Snacks.picker.gh_issue({state='all'})<CR>", icon = " ", desc = " All issues" },

    { "<Leader>gp", "<CMD>lua Snacks.picker.gh_pr({})<CR>",               icon = " ", desc = " Opened PRs" },
    { "<Leader>gP", "<CMD>lua Snacks.picker.gh_pr({state='all'})<CR>",    icon = " ", desc = " All PRs" },

    -- LSP
    { "<Leader>fd", "<CMD>lua Snacks.picker.diagnostics()<CR>",    icon = " ", desc = " Diagnostics" },
    { "<Leader>fm", "<CMD>lua Snacks.picker.markdown()<CR>",       icon = " ", desc = " Documentation" },
    { "<Leader>fs", "<CMD>lua Snacks.picker.lsp_symbols()<CR>",    icon = " ", desc = " Symbols" },
    { "<Leader>fr", "<CMD>lua Snacks.picker.lsp_references()<CR>", icon = " ", desc = " References" },

    -- Others
    { "<Leader>fz", "<CMD>lua Snacks.picker.zoxide()<CR>",   icon = "󰾶 ", desc = " Zoxide" },
    { "<Leader>f;", "<CMD>lua Snacks.picker.snippets()<CR>", icon = " ", desc = " LuaSnip snippets" },
    { "<Leader>fi", "<CMD>lua Snacks.picker.icons()<CR>",    icon = " ", desc = " Search Icons" },
    {
      "<Leader>fL",
      "<CMD>lua Snacks.picker.smart({cwd = vim.fn.stdpath('data') .. '/lazy'})<CR>",
      icon = " ",
      desc = " Find nvim plugin files",
    },
    {
      "<Leader>fG",
      "<CMD>lua Snacks.picker.grep({cwd = vim.fn.stdpath('data') .. '/lazy'})<CR>",
      icon = " ",
      desc = " Grep search in nvim plugin files",
    },
    {
      "<Leader>ft",
      "<CMD>lua Snacks.picker.todo_comments({ keywords = {'TODO', 'FIX', 'FIXME'} })<CR>",
      icon = " ",
      desc = " TODO/Fix/Fixme",
    },
  })
end

---------------------------------------------------------------------------
-- 🚦 LSP: Language Server Protocol: <Leader> + l
---------------------------------------------------------------------------
wk.add({
  { "<Leader>L",  "<CMD>Lazy<CR>",  icon = " ", desc = " lazy.nvim" },

  { "<Leader>l", group = "LSP", icon = "🚦 " },
  { "<Leader>le", "<CMD>lsp enable",  icon = " ", desc = " Enable Language Server" },
  { "<Leader>ld", "<CMD>lsp disable", icon = " ", desc = " Disable Language Server " },
  { "<Leader>lr", "<CMD>lsp restart", icon = " ", desc = " Restart Language Server " },
  { "<Leader>ls", "<CMD>lsp stop",    icon = " ", desc = " Stop Language Server " },

  { "<Leader>lc", "<CMD>lua Snacks.picker.lsp_config()<CR>",           icon = " ", desc = " Display LSP Info" },
  { "<Leader>li", "<CMD>lua Snacks.picker.lsp_implementations()<CR>",  icon = " ", desc = " Implementations" },
  { "gh",         "<CMD>lua Snacks.toggle.inlay_hints():toggle()<CR>", icon = " ", desc = " Inlay Hints" },
  { "g[",         "<CMD>lua vim.diagnostic.goto_prev()<CR>",           icon = "󰒮 ", desc = " Prev Diagnostic" },
  { "g]",         "<CMD>lua vim.diagnostic.goto_prev()<CR>",           icon = "󰒮 ", desc = " Next Diagnostic" },
  { "gq",         "<CMD>Trouble qflist<CR>",                           icon = " ", desc = " Quickfix list" },
  { "gl",         "<CMD>Trouble loclist<CR>",                          icon = " ", desc = " Location list" },
  { "<Leader>x",  "<CMD>Trouble diagnostics toggle focus=true<CR>",    icon = " ", desc = " Diagnostics" },
  { "<Leader>X",  "<CMD>Trouble symbols toggle focus=true<CR>",        icon = " ", desc = " Symbols" },
  { "gR",         "<CMD>Trouble lsp_references toggle focus=true<CR>", icon = " ", desc = " References" },
}, opts)

---------------------------------------------------------------------------
-- 🐛  DAP: Debugger Adapter Protocol: <Leader> + d
---------------------------------------------------------------------------
wk.add({
  -- DAP keymap like VSCode
  { "<F5>",    "<CMD>DapContinue<CR>",  icon = "", desc = " Continue Process" },
  { "<S-F5>",  "<CMD>DapTerminate<CR>", icon = "□", desc = " Terminate Process" },
  { "<F10>",   "<CMD>DapStepOver<CR>",  icon = "", desc = " Step Over" },
  { "<F11>",   "<CMD>DapStepInto<CR>",  icon = "", desc = " Step Into" },
  { "<S-F11>", "<CMD>DapStepOut<CR>",   icon = "", desc = " Step Out" },

  -- Debugger Control
  { "<Leader>d", group = "Debugger", icon = "🐛 " },
  { "<Leader>db", "<CMD>DapToggleBreakpoint<CR>",         icon = " ", desc = " Toggle DAP Breakpoints" },
  { "<Leader>dc", "<CMD>DapContinue<CR>",                 icon = " ", desc = " Continue Process" },
  { "<Leader>dt", "<CMD>DapTerminate<CR>",                icon = "□ ", desc = " Terminate Process" },
  { "<Leader>dL", "<CMD>DapShowLog<CR>",                  icon = "󰌱 ", desc = " Open DAP log" },
  { "<Leader>dl", "<CMD>lua require'dap'.run_last()<CR>", icon = "↻ ", desc = " Run Last" },

  { "<Leader>ds", group = "Debugger Control", icon = "🛠️ " },
  { "<Leader>dso", "<CMD>DapStepOver<CR>",         icon = " ", desc = " Step Over" },
  { "<Leader>dsi", "<CMD>DapStepInto<CR>",         icon = " ", desc = " Step Into" },
  { "<Leader>dsO", "<CMD>DapStepOut<CR>",          icon = " ", desc = " Step Out" },
  { "<Leader>dsb", "<CMD>DapStepBack<CR>",         icon = " ", desc = " Step Back" },

  { "<Leader>dd",  "<CMD>DapViewToggle<CR>",           icon = " ", desc = " Toggle DAP View" },
  { "<Leader>dw",  "<CMD>DapViewWatch<CR>",            icon = " ", desc = " Add watch expression" },

  { "<Leader>dv", group = "Debugger Views", icon = "🖥️ " },
  { "<Leader>dvs", "<CMD>DapViewJump scopes<CR>",      icon = "󰃤 ", desc = " Jump to scopes" },
  { "<Leader>dvb", "<CMD>DapViewJump breakpoints<CR>", icon = " ", desc = " Jump to breakpoints" },
  { "<Leader>dve", "<CMD>DapViewJump exceptions<CR>",  icon = " ", desc = " Jump to exceptions" },
  { "<Leader>dvw", "<CMD>DapViewJump watches<CR>",     icon = " ", desc = " Jump to watches" },
  { "<Leader>dvt", "<CMD>DapViewJump threads<CR>",     icon = " ", desc = " Jump to threads" },
  { "<Leader>dvr", "<CMD>DapViewJump repl<CR>",        icon = " ", desc = " Jump to repl" },
  { "<Leader>dvc", "<CMD>DapViewJump console<CR>",     icon = "󰞷 ", desc = " Jump to console" },

  { "<Leader>d;", "<CMD>lua require'osv'.launch({port=8086})<CR>", icon = "", desc = " Launch Lua debugger" },
}, opts)

---------------------------------------------------------------------------
-- Git: <Leader> + g
---------------------------------------------------------------------------
require("utils.git")

wk.add({
  { "<Leader>g", group = "Git Integration", icon = " " },
  { "<Leader>gB", "<CMD>lua Snacks.git.blame_line()<CR>", icon = " ", desc = " Git Blame Line" },

  { "[g", "<CMD>Gitsigns nav_hunk prev<CR>", icon = " ", desc = " Jump to prev hunk" },
  { "]g", "<CMD>Gitsigns nav_hunk next<CR>", icon = " ", desc = " Jump to next hunk" },
}, opts)

---------------------------------------------------------------------------
-- 🤖  AI Interaction: <Leader> + c
---------------------------------------------------------------------------
if not is_vscode then

  -- sidekick.nvim
  wk.add({
    { "<Leader>a", group = "AI Code Agent", icon = "🤖 " },
    -- Next Edit Suggestion
    { "\\s", "<CMD>Sidekick nes toggle<CR>", icon = "󰁤 ", desc = " Next Edit Suggestion" },

    -- CLI
    { "<Leader>ap", "<CMD>Sidekick cli prompt<CR>",             icon = "󰞷 ", desc = " Prompt Menu" },
    { "<C-.>",      "<CMD>Sidekick cli focus<CR>", mode = nxo, icon = "󰽎 ", desc = " Switch Focus" },

    { "<Leader>at", "<CMD>Sidekick cli send msg='{this}'<CR>",       mode = nx,icon = "󰞷 ",desc = " Send Line" },
    { "<Leader>av", "<CMD>Sidekick cli send msg='{selection}'<CR>",  mode = nx,icon = "󰞷 ",desc = " Send Selection" },
    { "<Leader>af", "<CMD>Sidekick cli send msg='{file}'<CR>",       mode = nx,icon = "󰞷 ",desc = " Send File" },
    { "<Leader>ad", "<CMD>Sidekick cli send msg='{diagnostics}'<CR>",mode = nx,icon = " ", desc = " Send diagnostics" },
  })
end

---------------------------------------------------------------------------
---File Explorer: <Leader> + e
-----------------------------------------------------------------------
if not is_vscode then
  wk.add({
    mode = "n",
    { "-",         "<CMD>Oil<CR>", icon = " ", desc = " Open Parent Dir" },
    { "<Leader>e", "<CMD>Oil<CR>", icon = " ", desc = " Open Parent Dir" },
    { "<Leader>E", "<CMD>lua require'oil'.open(Snacks.git.get_root())<CR>", icon = " ", desc = " Open Repo Root" },
  }, opts)
end

---------------------------------------------------------------------------
-- HTTP Client: <Leader> + k
---------------------------------------------------------------------------
wk.add({
  mode = "n",
  { "<Leader>k", group = "kulala.nvim", icon = "🛜 " },
  { "<Leader>ks", "<CMD>lua require'kulala'.scratchpad()<CR>",  icon = "󰌘 ", desc = " Open scratchpad" },
  { "<Leader>kc", "<CMD>lua require'kulala'.copy()<CR>",        icon = " ", desc = " Copy as cURL" },
  { "<Leader>kp", "<CMD>lua require'kulala'.from_curl()<CR>",   icon = " ", desc = " Paste from cURL" },
  { "<Leader>kr", "<CMD>lua require'kulala'.run()<CR>",         icon = " ", desc = " Run request" },
  { "<Leader>kR", "<CMD>lua require'kulala'.run_all()<CR>",     icon = " ", desc = " Run all requests" },
  { "<Leader>kt", "<CMD>lua require'kulala'.toggle_view()<CR>", icon = " ", desc = " Toggle View" },
  { "<Leader>ki", "<CMD>lua require'kulala'.inspect()<CR>",     icon = " ", desc = " Inspect request" },
  { "<Leader>kS", "<CMD>lua require'kulala'.search()<CR>",      icon = " ", desc = " Search request file" },
})

---------------------------------------------------------------------------
-- Feed: <Leader> + n
---------------------------------------------------------------------------
if not is_vscode then
  wk.add({
    mode = "n",
    { "<Leader>n", group = "feed.nvim", icon = "📰 " },
    { "<Leader>nm", "<CMD>Feed<CR>",        icon = " ", desc = " Feed menu" },
    { "<Leader>ni", "<CMD>Feed index<CR>",  icon = " ", desc = " Feed index" },
    { "<Leader>nu", "<CMD>Feed update<CR>", icon = "󰚰 ", desc = " Update Feed" },
    { "<Leader>nl", "<CMD>Feed list<CR>",   icon = "󰚰 ", desc = " Feed list" },
    { "<Leader>ng", "<CMD>Feed grep<CR>",   icon = "󰚰 ", desc = " Grep search" },
    { "<Leader>ns", "<CMD>Feed sync<CR>",   icon = "󰚰 ", desc = " Sync feed" },
  })
end

---------------------------------------------------------------------------
-- Others:
---------------------------------------------------------------------------
if not is_vscode then
  -- Toggle Plugin
  wk.add({
    { "J",  "<CMD>TSJToggle<CR>",          icon = " ", desc = " Toggle split/join" },

    { "\\d", "<CMD>lua Snacks.toggle.dim():toggle()<CR>", icon = " ", desc = " Dim Mode" },
    { "\\z", "<CMD>lua Snacks.toggle.zen():toggle()<CR>", icon = " ", desc = " Zen Mode" },
    { "<Leader>/", "<CMD>HlSearchLensToggle<CR>",               icon = " ", desc = " Hlsearch lens" },
    { "\\c",       "<CMD>ColorizerToggle<CR>",                  icon = " ", desc = " Colorizer" },
    { "<C-,>",     "<CMD>lua Snacks.terminal()<CR>", mode = nt, icon = " ", desc = " Terminal" },
  }, opts)
end
