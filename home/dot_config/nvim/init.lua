local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
      }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader      = [[ ]]
vim.g.maplocalleader = [[,]]
vim.g.colorscheme = "onedark" --- @type "nightfox"|"dayfox"|"dawnfox"|"duskfox"|"nordfox"|"carbonfox"|"onedark"

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then return end

lazy.setup("plugins", {
  defaults = { lazy   = true },
  checker  = { enable = true },
  change_detection = {
    enable = true,
    notify = true,
  },
  git = {
    log = { '--since=5 days ago' },
    timeout = 1200,  -- seconds
    url_format = 'https://github.com/%s.git',
    filter = true,
  },
  install  = {
    missing = true,
    colorscheme = { vim.g.colorscheme },
  },
  performance = {
    cache= {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      disable_events = { "UIEnter", "BufReadPre" },
      ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and the config directory
      -- paths = {}, -- add any custom paths here that you want to include in the rtp
      disabled_plugins = {
        "zip", "zipPlugin", "gzip",
        "tar", "tarPlugin",
        "getscript", "getscriptPlugin",
        "vimball", "vimballPlugin",
        "matchit", "matchparen",
        "netrw", "netrwPlugin",
        "netrwSettings", "netrwFileHandlers",
        "rrhelper", -- "spellfile_plugin",
        "tohtml",
        "logipat",
        "tutor",
      }
    }
  },
  ui = {
    border = "rounded",
    size  = { width = 0.7, height = 0.8 },
    icons = {
      cmd     = "⌘",
      config  = "🛠",
      event   = "📅",
      ft      = "📂",
      init    = "⚙",
      keys    = "🗝",
      plugin  = "🔌",
      runtime = "💻",
      source  = "📄",
      start   = "🚀",
      task    = "📌",
      lazy    = "💤 ",
    },
  }
})
require "core"
