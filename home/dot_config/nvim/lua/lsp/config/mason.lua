local ok, mason = pcall(require, "mason")
if not ok then return end

mason.setup({
  log_level = vim.log.levels.DEBUG,
  max_concurrent_installers = 4,
  check_outdated_packages_on_open = true,

  ui = {
    width  = 0.7,
    height = 0.85,
    icons  = {
      package_pending     = "➜",
      package_installed   = "✓",
      package_uninstalled = "✗"
    },
    keymaps = {
      toggle_package_expand   = "<CR>",
      install_package         = "i",
      update_package          = "u",
      update_all_packages     = "U",
      check_package           = "c",
      check_outdated_packages = "C",
      uninstall_package       = "X",
    }
  },
})
