-- -*-mode:lua-*- vim:ft=lua
local util = require("utils.javascript")
local cwd = vim.fs.root(0, "package.json") or vim.fn.getcwd()
local npm = vim.fn.executable("pnpm") and "pnpm " or "npm "
local braveExe = os.getenv("HOME") .. "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

local configs = {
  {
    name    = "Launch File",
    type    = "pwa-node",
    request = "launch",
    cwd     = "${workspaceFolder}",
    program = "${file}",
  },
  {
    name    = "Launch Project",
    type    = "pwa-node",
    request = "launch",
    cwd     = cwd,
  },
  {
    name        = "Attach Process",
    type        = "pwa-node",
    request     = "attach",
    processId   = require("dap.utils").pick_process({ filter = "node" }),
    cwd         = "${workspaceFolder}",
  },
  {
    name     = "Attach - Remote Debugging (pwa-chrome)",
    type     = "pwa-chrome",
    request  = "attach",
    port     = 9222,
    webRoot  = "${workspaceFolder}",
    protocol = "inspector",
    runtimeExecutable = braveExe,
    runtimeArgs = { "--incognito" },
    sourceMaps = true,
    sourceMapPathOverrides = {
      -- Sourcemap override for nextjs
      ["webpack://_N_E/./*"] = "${webRoot}/*",
      ["webpack:///./*"]     = "${webRoot}/*",
    },
    resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
  },
}
if util.is_jest_available() then
  table.insert(configs, {
    name     = "Debug Jest Tests",
    type     = "pwa-node",
    request  = "launch",
    cwd      = "${workspaceFolder}",
    rootPath = "${workspaceFolder}",
    console  = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    runtimeExecutable = "node",
    runtimeArgs       = { "./node_modules/jest/bin/jest.js", "--runInBand" },
  })
  table.insert(configs, {
    name    = "Next.js: debug client side",
    type    = "pwa-chrome",
    request = "launch",
    webRoot = "${workspaceFolder}",
    url     = "http://localhost:3000",
    runtimeExecutable = braveExe,
    runtimeArgs = { "--incognito" },
    sourceMaps = true,
    sourceMapPathOverrides = {
      -- Sourcemap override for nextjs
      ["webpack://_N_E/./*"] = "${webRoot}/*",
      ["webpack:///./*"]     = "${webRoot}/*",
    },
  })
  table.insert(configs, {
    name    = "Next.js: debug full stack",
    type    = "node-terminal",
    request = "launch",
    webRoot = "${workspaceFolder}",
    url     = "http://localhost:3000",
    command = npm .. "run dev",
    console = "integratedTerminal",
    serverReadyAction = {
      pattern   = "started server on .+, url: (https?://.+)",
      uriFormat = "%s",
      action    = "debugWithChrome",
    },
    runtimeExecutable = braveExe,
    runtimeArgs = { "--incognito" },
    sourceMaps = true,
    sourceMapPathOverrides = {
      -- Sourcemap override for nextjs
      ["webpack://_N_E/./*"] = "${webRoot}/*",
      ["webpack:///./*"]     = "${webRoot}/*",
    },
  })
end

return configs
