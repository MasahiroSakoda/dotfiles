local ok, neotest = pcall(require, "neotest")
if not ok then return end

neotest.setup({
  -- TODO: Refactor here
  adapters = {
    -- Python
    require("neotest-python")({
      dap    = { justmycode = false },
      args   = { "--log-level", "DEBUG" },
      runner = "pytest", --- @type "pytest"|"unittest"
      python = ".venv/bin/python",
    }),
    -- Ruby
    require("neotest-rspec")({
      rspec_cmd = function() return vim.tbl_flatten({ "bundle", "exec", "rspec" }) end,
      root_files = { "Gemfile", ".rspec", ".gitignore" },
    }),
    require("neotest-jest")({
      -- TODO: configure parameter for npm/pnpm
      -- TODO: configure for jest watch mode
      jestCommand = "npm test --",
      -- TODO: configure for Monorepo environment
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path) return vim.fn.getcwd() end,
    }),
    -- JavaScript, TypeScript
    require("neotest-vitest"),
    require("neotest-playwright").adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,
        preset = "none", --- @type "none"|"headed"|"debug"
      }
    }),
  },
})
