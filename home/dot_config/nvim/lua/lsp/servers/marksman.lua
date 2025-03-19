local ok, util = pcall(require, "lspconfig.util")
if not ok then return end

return {
  defaunt_config = {
    cmd       = { "marksman", "server" },
    filetypes = { "md", "markdown" },
    root_dir  = function(fname)
      local root_files = { ".marksman.toml" }
      return util.root_pattern(table.unpack(root_files))(fname)
        or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    end,
    single_file_support = true,
  },
}
