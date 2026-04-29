
---@type vim.lsp.Config
return {
  cmd = { "zizmor", "--lsp" },
  filetypes = { "yaml" },
  root_dir = function(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local parent  = vim.fs.dirname(bufname)
    if
      vim.endswith(parent, "/.github/workflows") or
      vim.endswith(parent, "/.github/dependabot.yml") or
      vim.endswith(bufname, "action.yml") then
      on_dir(parent)
    end
  end,
  init_options = {},
  capabilities = {
    workspace = {
      didChangeWorkspaceFolders = {
        dynamicRegistration = true,
      },
    },
  },
}
