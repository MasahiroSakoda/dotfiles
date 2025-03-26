-- -*-mode:lua-*- vim:ft=lua
local util = require("utils.javascript")
local cwd  = vim.fs.root(0, "package.json") or vim.fn.getcwd()
local npm  = vim.fn.executable("pnpm") and "pnpm " or "npm "
local braveExe = os.getenv("HOME") .. "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

local configs = {
  {
    name    = "Launch Current File (pwa-node)",
    type    = "pwa-node",
    request = "launch",
    cwd     = "${workspaceFolder}",
    args    = { "${file}" },
    soruceMaps = true,
    protocol   = "inspector",
    runtimeExecutable = npm,
    runtimeArgs       = { "run-script", "dev" },
  },
  {
    name    = "Launch Project",
    type    = "pwa-node",
    request = "launch",
    cwd     = cwd,
  },
  {
    name        = "Attach Process (pwa-node)",
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
    resolveSourceMapLocations = {
      "${webRoot}/*",
      "${webRoot}/apps/**/**",
      "${workspaceFolder}/apps/**/**",
      "${webRoot}/packages/**/**",
      "${workspaceFolder}/packages/**/**",
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    name    = "Launch Chrome with \"localhost\"",
    type    = "pwa-chrome",
    request = "launch",
    webRoot = "${workspaceFolder}",
    url = function()
      local co = coroutine.running()
      vim.ui.input({ prompt = "", default = "https://localhost:3000" }, function(url)
        if url == nil or url == "" then
          return
        else
          coroutine.resume(co, url)
        end
      end)
    end,
    userDataDir = false,
    sourceMaps  = true,
    resolveSourceMapLocations = {
      "${webRoot}/*",
      "${webRoot}/apps/**/**",
      "${workspaceFolder}/apps/**/**",
      "${webRoot}/packages/**/**",
      "${workspaceFolder}/packages/**/**",
      "${workspaceFolder}/*",
      "!**/node_modules/**",
    },
  },
}
if util.is_jest_available() then
  table.insert(configs, {
    name     = "Debug Jest Tests (pwa-node with Jest)",
    type     = "pwa-node",
    request  = "launch",
    cwd      = "${workspaceFolder}",
    rootPath = "${workspaceFolder}",
    console  = "integratedTerminal",
    sourceMap = true,
    internalConsoleOptions = "neverOpen",
    runtimeExecutable = "node",
    runtimeArgs       = { "./node_modules/jest/bin/jest.js", "--runInBand" },
    args              = { "${file}", "--coverage", "false" },
  })
  table.insert(configs, {
    name    = "Next.js: debug server side (pwa-node)",
    type    = "pwa-node",
    request = "attach",
    cwd     = "${workspaceFolder}",
    port    = 9231,
    skipFiles = { "<node_internals>/**", "node_modules/**" },
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
