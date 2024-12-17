local ok, dap = pcall(require, "dap")
if not ok then return end

dap.adapters.chrome = {
  type    = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
}
local firefoxExecutable = "~/Applications/Firefox.app/Contents/MacOS/firefox"

dap.adapters.firefox = {
  type    = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/out/src/firefoxDebug.js" },
}

dap.configurations.typescript = {
  {
    name       = "Launch file",
    type       = "node2",
    request    = "launch",
    program    = "${file}",
    cwd        = vim.fn.getcwd(),
    sourceMaps = true,
    protocol   = "inspector",
    console    = "integratedTerminal",
  },
  {
    name       = "Attach to process",
    type       = "node2",
    sourceMaps = true,
    request    = "attach",
    processId  = require("dap.utils").pick_process,
  },
  -- TODO: Configure Chgome debug environment
  {
    name       = "Debug with Chrome",
    type       = "chrome",
    request    = "attach",
    program    = "${file}",
    port       = 9222,
    webRoot    = "${workspaceFolder}",
    sourceMapPathOverrides = {
      -- Sourcemap override for nextjs
      ["webpack://_N_E/./*"] = "${webRoot}/*",
      ["webpack:///./*"]     = "${webRoot}/*",
    },
  },
  -- TODO: Configure Firefox debug environment
  {
    name       = "Debug with Firefox",
    type       = "firefox",
    request    = "launch",
    reAttach   = true,
    sourceMaps = true,
    url        = "http://localhost:6969",
    webRoot    = "",
    firefoxExecutable = firefoxExecutable,
  }
}
-- dap.configurations.javascript      = dap.configurations.typescript
-- dap.configurations.javascriptreact = dap.configurations.typescript
-- dap.configurations.typescriptreact = dap.configurations.typescript
