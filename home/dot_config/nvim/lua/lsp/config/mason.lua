local ok, mason = pcall(require, "mason")
if not ok then return end

mason.setup({
  ui = {
    icons = {
      package_pending     = "➜",
      package_installed   = "✓",
      package_uninstalled = "✗"
    }
  }
})
