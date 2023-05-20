local ok, util = pcall(require, "lspconfig.util")
if not ok then return end

return {
  default_config = {
    cmd = { "terraform", "serve" },
    filetypes = { "terraform", "tf", "terraform-vars", "hcl" },
  },
}
