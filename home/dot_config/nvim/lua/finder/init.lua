-- -*-mode:lua-*- vim:ft=lua
local ok, fzf = pcall(require, "fzf-lua")
if not ok then return end

require("utils.finder")

fzf.setup({
  commands = { sort_lastused = true },
  global_resume       = true,
  global_resume_query = true,

  fzf_opts   = {
    ["--header"] = " ", -- add space between prompt and results
    ["--no-scrollbar"] = true,

    ["--marker"]            = "┃",
    ["--marker-multi-line"] = "╻┃╹",
  },

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
      vertical   = "down:45%",  -- up|down:size
      horizontal = "right:50%", -- left|right:size
      scrollbar  = "float",
    },
  },

  -- ---------------------------------------------------------------------------
  -- Preview Options
  -- ---------------------------------------------------------------------------
  previewers = {
    builtin = {
      syntax_limit_b = 1024 * 1024 * 0.5, -- 0.5MB
      limit_b        = 1024 * 1024 * 0.5, -- 0.5MB
    },
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
    files  = { prompt = "  " },
    status = { prompt = "  " },
    commit = { prompt = "  " },
    branch = { prompt = "  " },
    tags   = { prompt = "  " },
  },
  grep = {
    prompt = "  ",
    multiline = 1,
  },
  args = { prompt = "  " },
  oldfiles = {
    prompt = "  ",
    include_current_session = true,
  },
  buffers = { prompt = "  ", sort_lastused = true },
  tabs    = { prompt = "  " },
  lines   = { prompt = "  ", sort_lastused = true },
  tags    = { prompt = "  " },
  keyamp  = { prompt = "  " },
})
