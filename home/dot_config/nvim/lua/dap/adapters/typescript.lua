local ok, dap = pcall(require, "dap")
if not ok then return end

local mason = require("utils.mason")

-- Configure Debug Server
local adapters  = { "pwa-node", "pwa-chrome" }
local languages = { "javascript", "typescript", "javascriptreact", "typescriptreaact", "vue", "svelte" }

for _, adapter in ipairs(adapters) do
  if not dap.adapters[adapter] then
    dap.adapters[adapter] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { mason.adapter_path("js-debug-adapter") .. "/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }
  end
  require("dap.ext.vscode").type_to_filetypes[adapter] = languages
end

local firefoxExe = vim.fn.has("mac") and "/Applications/Firefox.app/Contents/MacOS/firefox" or "/usr/bin/firefox"
dap.adapters.firefox = {
  type    = "executable",
  command = "node",
  args = { mason.adapter_path("firefox-debug-adapter") .. "/dist/adapter.bundle.js" },
}

-- Configure debugger client config
for _, lang in ipairs(languages) do
  local isTS = lang == ("typescript" or "typescriptreaact")
  if not dap.configurations[lang] then
    dap.configurations[lang] = {
      {
        name        = "Launch Current File (pwa-node" .. (isTS and "with ts-node)" or ")"),
        type        = "pwa-node",
        request     = "launch",
        program     = "${file}",
        cwd         = "${workspaceFolder}",
        protocol    = "inspector",
        sourceMaps  = true,
        console     = "integratedTerminal",
        skipFiles   = { "<node_internals>/**", "node_modules/**" },
        runtimeArgs = isTS and { "--loader", "=ts-node/esc" } or {},
      },
      {
        name        = "Attach Program (pwa-node, select pid" .. (isTS and "with ts-node)" or ")"),
        type        = "pwa-node",
        request     = "attach",
        sourceMaps  = true,
        processId   = require("dap.utils").pick_process,
        cwd         = "${workspaceFolder}",
        runtimeArgs = isTS and { "--loader", "=ts-node/esc" } or {},
      },
      {
        name     = "Launch Test Current File (pwa-node with jest)",
        type     = "pwa-node",
        request  = "launch",
        trace    = true,
        cwd      = "${workspaceFolder}",
        rootPath = "${workspaceFolder}",
        console  = "integratedTerminal",
        runtimeExecutable = "node",
        runtimeArgs       = { "./node_modules/jest/bin/jest.js", "--runInBand" },
        internalConsoleOptions = "neverOpen",
      },
      {
        name    = "Launch Test Current File (pwa-node with deno)",
        type    = "pwa-node",
        request = "launch",
        cwd     = "${workspaceFolder}",
        runtimeExecutable = "deno",
        runtimeArgs       = { "test", "--inspect-brk", "--allow-all", "${file}" },
        attachSimplePort  = 9229,
      },
      {
        name    = "Attach Program (pwa-chrome)",
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
      },
      {
        name       = "Attach Program (firefox)",
        type       = "firefox",
        request    = "launch",
        reAttach   = true,
        sourceMaps = true,
        url        = "http://localhost:6969",
        webRoot    = "${workspaceFolder}",
        firefoxExecutable = firefoxExe,
      },
    }
  end
end
