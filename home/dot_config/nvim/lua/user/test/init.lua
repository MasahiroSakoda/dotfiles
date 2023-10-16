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
  },
})
