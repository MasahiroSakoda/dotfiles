local dap_ok, dap     = pcall(require, "dap")
local dapjs_ok, dapjs = pcall(require, "dap-vscode-js")
if not (dap_ok or dapjs_ok) then return end

local fn  = vim.fn
local debugger_path = fn.stdpath("data") .. "/mason/packages/js-debug-adapter"

-- Base Configurations
dapjs.setup({
  node_path      = "node",
  debugger_path  = debugger_path,
  debugger_cmd   = { "js-debug-adapter" },
  adapters       = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
  -- log_file_path     = "(stdpath cache)/dap_vscode_js.log", -- Path for file logging
  log_file_level    = vim.log.levels.TRACE,
  -- log_console_level = vim.log.levels.ERROR, -- Logging level for output to console. Set to false to disable console output.
})

-- Language specific configurations
local languages = { "javascript", "typescript", "typescriptreaact" }

for _, lang in ipairs(languages) do
  dap.configurations[lang] = {
    {
      type      = "pwa-node",
      name      = "Launch file",
      request   = "launch",
      program   = "${file}",
      cwd       = "${workspaceFolder}",
    },
    {
      type      = "pwa-node",
      name      = "Attach",
      request   = "attach",
      processId = require("dap.utils").pick_process,
      cwd       = "${workspaceFolder}",
    },
    {
      type      = "pwa-node",
      name      = "Debug Jest Tests",
      request   = "launch",
      -- trace = true, -- include debugger info
      cwd       = "${workspaceFolder}",
      rootPath  = "${workspaceFolder}",
      console   = "integratedTerminal",
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      internalConsoleOptions = "neverOpen",
    },
  }
end

-- Language specific config for remote debug
for _, lang in ipairs(languages) do
  dap.configurations[lang] = {
    {
      type       = "pwa-chrome",
      name       = "Attach - Remote Debugging",
      request    = "attach",
      protocol   = "inspector",
      program    = "${file}",
      sourceMaps = true,
      port       = 9222,
      cwd        = fn.getcwd(),
      webRoot    = "${workspaceFolder}",
    },
    {
      type       = "pwa-chrome",
      name       = "Launch Chrome",
      request    = "launch",
      url        = "http://localhost:3000",
    },
  }
end
