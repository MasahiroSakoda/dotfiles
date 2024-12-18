local ok, dap = pcall(require, "dap")
if not ok then return end

local M = {}
local mason      = require("utils.mason")

---@param adapters table<string, any> Debug adapter: server side
M.dap_adapter = function(adapters)
  for _, adapter in ipairs(adapters) do
    if not dap.adapters[adapter] then
      dap.adapters[adapter] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args    = { mason.install_path("js-debug-adapter") .. "/js-debug/src/dapDebugServer.js", "${port}" },
        },
      }
    end
  end
end

---@param languages table<string, any> Target language for debugging
M.dap_configuration = function(languages)
  for _, language in ipairs(languages) do
    if not dap.configurations[language] then
      dap.configurations[language] = {
        {
          name      = "Launch Current File (pwa-node: " .. language .. ")",
          type      = "pwa-node",
          request   = "launch",
          cwd       = "${workspaceFolder}",
          program   = "${file}",
          protocol  = "inspector",
          sourceMaps  = true,
          skipFiles = { "<node_internals>/**", "node_modules/**", "<anonymous>/**" },
        },
        {
          name        = "Attach Program (pwa-node: " .. language .. ", select pid)",
          type        = "pwa-node",
          request     = "attach",
          sourceMaps  = true,
          processId   = require("dap.utils").pick_process({ filter = "node" }),
          cwd         = "${workspaceFolder}",
          skipFiles   = { "<node_internals>/**", "node_modules/**", "<anonymous>/**" },
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
        {
          name    = "Attach Program (pwa-chrome: " .. language .. ")",
          type    = "pwa-chrome",
          request = "attach",
          program = "${file}",
          port    = 9222,
          webRoot = "${workspaceFolder}",
          sourceMapPathOverrides = {
            -- Sourcemap override for nextjs
            ["webpack://_N_E/./*"] = "${webRoot}/*",
            ["webpack:///./*"]     = "${webRoot}/*",
          },
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
      }
    end
  end
end

return M
