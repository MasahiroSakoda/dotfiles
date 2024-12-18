local ok, dap = pcall(require, "dap")
if not ok then return end

local M = {}
local mason, util = require("utils.mason"), require("utils.javascript")
local cwd = vim.fs.root(0, "package.json") or vim.fn.getcwd()
local npm = vim.fn.executable("pnpm") and "pnpm " or "npm "

---@param adapters table<string, any> Debug adapter: server side
M.dap_adapter = function(adapters)
  for _, adapter in ipairs(adapters) do
    if not dap.adapters[adapter] then
      dap.adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { mason.install_path("js-debug-adapter") .. "/js-debug/src/dapDebugServer.js", "${port}" },
        },
      }
    end
  end
end

local braveExe = os.getenv("HOME") .. "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

M.dap_configuration = function(_)
  if not dap.configurations.javascript then
    dap.configurations.javascript = {
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
        url      = function()
          local co = coroutine.running()
          return coroutine.create(function()
            vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
              if url == nil or url == "" then
                return
              else
                coroutine.resume(co, url)
              end
            end)
          end)
        end,
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
      table.insert(dap.configurations.javascript, {
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
    end

    if util.is_next_project() then
      table.insert(dap.configurations.javascript, {
        name    = "Next.js: debug server side",
        type    = "node-terminal",
        request = "launch",
        webRoot = "${workspaceFolder}",
        command = npm .. "run dev",
        sourceMaps = true,
        sourceMapPathOverrides = {
          -- Sourcemap override for nextjs
          ["webpack://_N_E/./*"] = "${webRoot}/*",
          ["webpack:///./*"]     = "${webRoot}/*",
        },
      })
      table.insert(dap.configurations.javascript, {
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
      table.insert(dap.configurations.javascript, {
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
  end

  dap.configurations.typescript      = dap.configurations.javascript
  dap.configurations.javascriptreact = dap.configurations.javascript
  dap.configurations.typescriptreact = dap.configurations.javascript
end

return M
