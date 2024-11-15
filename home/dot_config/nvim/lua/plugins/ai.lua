-- -*-mode:lua-*- vim:ft=lua

return {
  -- AI-driven IDE
  {
    "yetone/avante.nvim",
    event   = "VeryLazy",
    lazy    = false,
    version = false, -- set this if you want to always pull the latest change
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build   = "make BUILD_FROM_SOURCE=true",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
      -- { -- support for image pasting
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts  = {
      --     default = { -- recommended settings
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name  = false,
      --       drag_and_drop = { insert_mode = true },
      --       use_absolute_path = true, -- required for Windows user
      --     },
      --   },
      -- },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft   = { "markdown", "Avante" },
      }
    },
    cond = not vim.g.vscode,
    config = function() require("ai.avante") end,
  }
}
