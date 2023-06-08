return {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "use", "describe", "it", "before_each", "after_each", "MiniTest" },
        -- disable = { "undefined-global", "lowercase-global", "unused-local", "unused-vararg", "trailing-space" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          vim.api.nvim_get_runtime_file("", true),
          -- vim.fn.expand("$VIMRUNTIME"),
          -- "${3rd}/luv/library",
          -- "${3rd}/lfs/library",
        },
        maxPreload      = 2000,
        preloadFileSize = 1000,
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
      completion = {
        autoRequire    = true,
        callSnippet    = "Both",
        keywordSnippet = "Both",
        showParams = true,
        showWord   = true,
        postfix = "@",
      },
    }
  },
  -- single_file_support = true,
}
