local ok, util = pcall(require, "lspconfig.util")
if not ok then return end

return {
  defaunt_config = {
    cmd     = { "marksman", "server" },
    filetypes = { "md", "markdown" },
    root_dir  = function(fname)
      local root_files = { ".marksman.toml" }
      return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    single_file_support = true,
  },
}
