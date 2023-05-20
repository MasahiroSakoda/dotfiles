local ok, nt = pcall(require, "neo-tree")
if not ok then return end

nt.setup({
  open_on_setup  = true,
  autoselect_one = true,
  include_current = false,
  popup_border_style = "rounded",
  close_if_last_window = true,

  enable_git_status  = true,
  enable_diagnostics = true,

  window = {
    position = "left",
    width = 25,
    mappings = {
      ["<Space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["o"]     = "open",
      ["<C-v>"] = "open_vsplit",
      ["<C-t>"] = "open_tabnew",
      ["/"]     = "fuzzy_finder",
      ["?"]     = "fuzzy_finder_directory",
      ["<C-X>"] = "open",
    }
  },

  file_rules = {
    bo = {
      filetype = {
        "neo-tree",
        "neo-tree-popup",
        "notify",
        "quickfix",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
        "dap-repl",
      },
      buftype = { "terminal", "quickfix" },
    },
  },

  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded  = "",
      expander_highlight = "NeoTreeExpander",
    },

    icon = {
      folder_closed = "",
      folder_open   = "",
      folder_empty  = "ﰊ",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },

    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
      symbols = {
        -- Change type
        added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted   = "✖",-- this can only be used in the git_status source
        renamed   = "",-- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      }
    },
  },

  filesystem = {
    filtered_items = {
      visibile       = true,
      hide_dotfiles  = false,
      hide_gitignore = false,
      hide_by_name = {
      -- never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        ".DS_Store",
        "thumbs.db",
        ".git", ".github",
        ".tool-versions",
        ".idea",
        ".terraform",
        "node_modules",
        "__pycache__",
      },
      follow_current_file = true,
    }
  },
})
