-- -*-mode:lua-*- vim:ft=lua
local ok, dapjs = pcall(require, "dap-vscode-js")
if not ok then return end

dapjs.setup({
  debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})
