local g, fn, opt, loop = vim.g, vim.fn, vim.opt, vim.loop
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not loop.fs_stat(lazypath) then
  fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
end
opt.rtp:prepend(lazypath)

g.mapleader      = [[ ]]
g.maplocalleader = [[,]]

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
    colorscheme = { "nightfox", "kanagawa" },
  },
  performance = {
    cache= {
      enabled = true,
      path = fn.stdpath("cache") .. "/lazy/cache",
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
