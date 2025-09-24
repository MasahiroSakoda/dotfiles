-- -*-mode:lua-*- vim:ft=lua
local ok, ts = pcall(require, "nvim-treesitter")
if not ok then return end

ts.setup({ install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "/site") })

-- Install unregistered treesitter parser
local fts     = require("user.filetypes").treesitter
local parsers = vim.iter(fts):filter(function(p) return not vim.tbl_contains(ts.get_installed(), p) end):totable()
ts.install(parsers):await(function(err)
  if err then
    vim.notify("Failed to install treesitter parser for " .. fts .. " error: " .. err, vim.log.levels.WARN)
  end
end)

-- Register extended filetype
vim.filetype.add({
  extension = { plist = "xml", mdx = "mdx" },
  pattern   = {
    ["Brewfile.*"]         = "ruby",
    ["Caskfile.*"]         = "ruby",
    ["Masfile.*"]          = "ruby",
    ["[Dd]ockerfile.*"]    = "dockerfile",
    [".*%.env%..*"]        = "dotenv",
    [".*/.vscode/.*.json"] = "jsonc",
    [".*/ghostty/.+"]      = "bash",
    [".*/.chezmoiignore"]  = "gitignore",
  },
})
-- -- Register extended language for treesitter
vim.treesitter.language.register("bash",     { "sh", "zsh", "dotenv" })
vim.treesitter.language.register("markdown", { "mdx", "vimwiki", "octo", "codecompanion" })
vim.treesitter.language.register("latex",    { "tex", "plaintex" })

-- Activate treesittter highlights, fold & indent
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc     = "Start treesiter highlighting",
  group    = vim.api.nvim_create_augroup("TreesitterParser", {}),
  -- pattern  = { "*" },
  callback = function(ev)
    local ft   = ev.match
    local lang = vim.treesitter.language.get_lang(ft)

    if not vim.g.vscode then
      -- Activate nvim-treesitter highlight
      pcall(vim.treesitter.start, ev.buf, lang)
      -- Activate NeoVim fold
      vim.wo.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
      -- Activate nvim-treesitter indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
