-- -*-mode:lua-*- vim:ft=lua
local ok, fzf = pcall(require, "fzf-lua")
if not ok then return end

fzf.setup({
  commands = { sort_lastused = true },
  -- ---------------------------------------------------------------------------
  -- Window Optiosn
  -- ---------------------------------------------------------------------------
  winops = {
    border     = "rounded",
    width      = 0.95,
    height     = 0.9,
    row        = 0.35,
    col        = 0.5,
    fullscreen = false,

    preview = {
      vertical       = "down:45%",
      horizontal     = "right:50%",
    },
  },

  -- ---------------------------------------------------------------------------
  -- Preview Options
  -- ---------------------------------------------------------------------------
  previewers = {
    builtin = {
      syntax_limit_b = 1024 * 100, -- 100KB
    }
  },

  -- ---------------------------------------------------------------------------
  -- Picker Options
  -- ---------------------------------------------------------------------------
  files = {
    prompt  = " ",
    rg_opts = [[--color=always --files --hidden --follow -g "!.git"]],
    fd_opts = [[--color=always --type f --hidden --follow --exclude .git]],
  },
  git = {
    files  = { prompt = " " },
    status = { prompt = " " },
    commit = { prompt = " " },
    branch = { prompt = " " },
    tags   = { prompt = " " },
  },
  grep = {
    prompt = " ",
    multiline = 1,
  },
  args = { prompt = " " },
  oldfiles = {
    prompt = " ",
    include_current_session = true,
  },
  buffers = { prompt = " " },
  tabs    = { prompt = " " },
  lines   = { prompt = " " },
  tags    = { prompt = " " },
  keyamp  = { prompt = " " },
})
