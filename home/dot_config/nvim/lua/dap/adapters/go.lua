local ok, dap_go = pcall(require, "dap-go")
if not ok then return end

dap_go.setup({
  dap_configurations = {
    -- Must be "go" or it will be ignored by the plugin
    type    = "go",
    name    = "Attach remote",
    mode    = "remote",
    request = "attach",
  },
  delve = {
    path = vim.fn.exepath("dlv"),
    initialize_timeout_sec = 20,
    port = "${port}",
    args = {},
    build_flags = "",
  },
})
