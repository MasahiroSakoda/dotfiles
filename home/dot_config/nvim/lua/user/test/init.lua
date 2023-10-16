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
  },
})
